`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/01/2026 05:35:23 PM
// Design Name: 
// Module Name: tb_scoreboard
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

module tb_scoreboard;

reg clk = 0;
reg reset = 1;

always #5 clk = ~clk;

scoreboard_top DUT(
    .clk(clk),
    .reset(reset)
);

initial begin
    $dumpfile("wave.vcd");
    $dumpvars(0, DUT);

    #20 reset = 0;
    #500 $finish;
end

endmodule