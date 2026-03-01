module scoreboard_top(
    input clk,
    input reset
);

// ----------------------
// Instruction Register
// ----------------------
reg [31:0] instr_reg;

// Example instruction stream (manual feed)
always @(posedge clk or posedge reset) begin
    if (reset)
        instr_reg <= 32'h10088000;  // dummy ADD
    else
        instr_reg <= instr_reg;     // static for now
end

// ----------------------
// Decode fields
// ----------------------
wire [3:0] opcode = instr_reg[31:28];
wire [4:0] rd     = instr_reg[27:23];
wire [4:0] rs1    = instr_reg[22:18];
wire [4:0] rs2    = instr_reg[17:13];

// ----------------------
// Scoreboard
// ----------------------
wire [31:0] busy_table;
wire wb_en;
wire [4:0] rd_wb;

scoreboard_table sb(
    .clk(clk),
    .reset(reset),
    .issue(issue_en),
    .writeback(wb_en),
    .rd_issue(rd),
    .rd_wb(rd_wb),
    .busy_table(busy_table)
);

// ----------------------
// Issue Logic
// ----------------------
wire can_issue;
reg issue_en;

issue_logic issue_unit(
    .busy_table(busy_table),
    .rs1(rs1),
    .rs2(rs2),
    .rd(rd),
    .can_issue(can_issue)
);

// ----------------------
// Reservation Station
// ----------------------
reg rs_busy;

always @(posedge clk or posedge reset) begin
    if (reset)
        rs_busy <= 0;
    else if (issue_en)
        rs_busy <= 1;
    else if (wb_en)
        rs_busy <= 0;
end

// ----------------------
// Functional Unit
// ----------------------
wire fu_done;
reg fu_start;

functional_unit fu(
    .clk(clk),
    .reset(reset),
    .start(fu_start),
    .opcode(opcode),
    .done(fu_done)
);

// ----------------------
// Writeback
// ----------------------
writeback_unit wb(
    .clk(clk),
    .reset(reset),
    .fu_done(fu_done),
    .rd_exec(rd),
    .wb_en(wb_en),
    .rd_wb(rd_wb)
);

// ----------------------
// Control FSM
// ----------------------
reg [1:0] state;

localparam FETCH     = 2'd0,
           ISSUE     = 2'd1,
           EXECUTE   = 2'd2,
           WRITEBACK = 2'd3;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= FETCH;
        issue_en <= 0;
        fu_start <= 0;
    end
    else begin
        case(state)

        FETCH: begin
            issue_en <= 0;
            fu_start <= 0;
            state <= ISSUE;
        end

        ISSUE: begin
            if (can_issue && !rs_busy) begin
                issue_en <= 1;
                state <= EXECUTE;
            end
            else begin
                issue_en <= 0;
            end
        end

        EXECUTE: begin
            issue_en <= 0;
            fu_start <= 1;
            state <= WRITEBACK;
        end

        WRITEBACK: begin
            fu_start <= 0;
            if (fu_done)
                state <= FETCH;
        end

        endcase
    end
end

endmodule