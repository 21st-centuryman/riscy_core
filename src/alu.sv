module alu (
    input clk,
    input [2:0] funct3,
    input funct7,
    input [31:0] rs1,
    rs2,
    // OUTPUTS
    output reg [31:0] rd,
    // FLAGS
    output z
);
  always_ff @(posedge clk) begin
    case ({
      funct7, funct3
    })
      4'b0000: rd <= (rs1 + rs2);  // ADD
      4'b1000: rd <= (rs1 - rs2);  // SUB
      4'b0001: rd <= rs1 << rs2;  // SLL
      4'b0010: rd <= (rs1 < rs2) ? 1 : 0;  // SLT
      4'b0011: rd <= {31'b0, rs1 < rs2};  // SLTU
      4'b0100: rd <= (rs1 ^ rs2);  // XOR
      4'b0101: rd <= (rs1 >> rs2);  // SRL
      4'b1101: rd <= (rs1 >>> rs2);  // SRA
      4'b0110: rd <= (rs1 | rs2);  // OR
      4'b0111: rd <= (rs1 & rs2);  // AND
      default;
    endcase
  end
  assign z = (rs1 - rs2) == 0;
endmodule

