module writeback_unit(
    input clk,
    input reset,
    input fu_done,
    input [4:0] rd_exec,
    output reg wb_en,
    output reg [4:0] rd_wb
);

always @(posedge clk or posedge reset) begin
    if (reset) begin
        wb_en <= 0;
        rd_wb <= 0;
    end
    else begin
        if (fu_done) begin
            wb_en <= 1;
            rd_wb <= rd_exec;
        end
        else begin
            wb_en <= 0;
        end
    end
end

endmodule