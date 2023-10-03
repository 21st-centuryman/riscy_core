module controller (
  input [6:0] op,
  input [3:0] funct3,
  input [7:0] funct7,
  // OUTPUTS
  output pcSrc, ResultSrc, Memwrite, ALUsrc, Immsrc, RegWrite
  output [2:0] ALUControl
);
  
endmodule
