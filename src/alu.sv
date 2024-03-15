module alu (
    input clk,
    input [2:0] funct3,
    input [6:0] funct7,
    input [31:0] rs1,
    rs2,
    // OUTPUTS
    output z,
    output reg [31:0] rd
);
  always_ff @(posedge clk) begin
    case (funct3)
      3'b000:  rd <= !funct7[6] ? (rs1 + rs2) : (rs1 - rs2);  // ADD | SUB
      //3'b001: rd <= rs1 << rs2;  // SLL
      //3'b010: rd <= (rs1 < rs2) ? 1 : 0;  // SLT
      //3'b011: rd <= (rs1 < rs2) ? 1 : 0;  // SLTU
      3'b100:  rd <= (rs1 ^ rs2);  // XOR
      //3'b101: rd <= !tmp ? rs1 >> rs2 : rs1 >> rs2;  // SRL | SRA
      3'b110:  rd <= (rs1 | rs2);  // OR
      3'b111:  rd <= (rs1 & rs2);  // AND
      default;
    endcase
  end
  //assign z = (rs1 - rs2) == 0;
endmodule



// -----------------------
// FIX FINISH THIS AND FIX THE TEST
// -----------------------
