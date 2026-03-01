module reservation_station(
    input clk,
    input reset,
    input issue_en,
    input [3:0] opcode_in,
    input [4:0] rd_in,
    input [4:0] rs1_in,
    input [4:0] rs2_in,
    output reg busy
);

always @(posedge clk or posedge reset) begin
    if (reset)
        busy <= 0;
    else if (issue_en)
        busy <= 1;
end

endmodule