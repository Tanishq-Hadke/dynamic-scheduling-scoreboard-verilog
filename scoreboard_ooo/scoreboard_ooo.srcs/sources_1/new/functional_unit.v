module functional_unit(
    input clk,
    input reset,
    input start,
    input [3:0] opcode,
    output reg done
);

reg [2:0] counter;
reg [2:0] latency;

always @(*) begin
    case(opcode)
        4'b0001: latency = 1;
        4'b0011: latency = 3;
        4'b0100: latency = 5;
        default: latency = 1;
    endcase
end

always @(posedge clk or posedge reset) begin
    if (reset) begin
        counter <= 0;
        done <= 0;
    end else if (start) begin
        counter <= latency;
        done <= 0;
    end else if (counter > 0) begin
        counter <= counter - 1;
        if (counter == 1)
            done <= 1;
    end else
        done <= 0;
end

endmodule