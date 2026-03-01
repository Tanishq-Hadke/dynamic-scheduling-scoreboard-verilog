`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/01/2026 05:31:28 PM
// Design Name: 
// Module Name: scoreboard_table
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module scoreboard_table(
    input clk,
    input reset,
    input issue,
    input writeback,
    input [4:0] rd_issue,
    input [4:0] rd_wb,
    output [31:0] busy_table
);

reg [31:0] busy;

assign busy_table = busy;

always @(posedge clk or posedge reset) begin
    if (reset)
        busy <= 0;
    else begin
        if (issue)
            busy[rd_issue] <= 1;
        if (writeback)
            busy[rd_wb] <= 0;
    end
end

endmodule
