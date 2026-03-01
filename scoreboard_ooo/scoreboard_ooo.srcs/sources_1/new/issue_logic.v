module issue_logic(
    input [31:0] busy_table,
    input [4:0] rs1,
    input [4:0] rs2,
    input [4:0] rd,
    output can_issue
);

assign can_issue =
       ~busy_table[rs1] &&
       ~busy_table[rs2] &&
       ~busy_table[rd];

endmodule