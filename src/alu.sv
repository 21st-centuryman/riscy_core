module alu (
  input [2:0] ctrl,
  input [31:0] rs1, rs2
  // OUTPUTS
  output z,
  output [31:0] rd
);
always_ff @(*) begin : alu_1st version
  case (crl)
    3'b000: rd <= rs1 + rs2; 
    3'b001: rd <= rs1 + rs2; 
    3'b010: rd <= rs1 - rs2; 
    3'b000: rd <= rs1 & rs2; 
    3'b011: rd <= rs1 | rs2; 
    3'b101: rd <= rs1 < rs2; 
  endcase
  z <= (rs1 - rs2) == 0; // Using rd makes it flakey
end
endmodule
