module instruction_window(
    input clk,
    input reset,
    input [31:0] instr_in,
    input push,
    output [31:0] instr_out
);

reg [31:0] window [0:3];

always @(posedge clk or posedge reset) begin
    if (reset)
        window[0] <= 0;
    else if (push)
        window[0] <= instr_in;
end

assign instr_out = window[0];

endmodule