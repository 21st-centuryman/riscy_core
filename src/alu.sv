module alu (
  input clk,
  input [2:0] ctrl,
  input [31:0] rs1, rs2,
  // OUTPUTS
  output z,
  output reg [31:0] rd
);
always_ff @(posedge clk) begin
  case (ctrl)
    3'b000: rd <= rs1 + rs2; 
    3'b001: rd <= rs1 + rs2; 
    3'b010: rd <= rs1 - rs2; 
    3'b000: rd <= rs1 & rs2; 
    3'b011: rd <= rs1 | rs2; 
    3'b101: rd <= rs1 < rs2; 
  endcase
end
  assign z = (rs1 - rs2) == 0;
endmodule
