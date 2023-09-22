/*

A Conditioner based on the risc v refrence sheet.
base = rv32i

Takes care of branching and jump.

Notes:
  * I am using hex values to be consistent with the refrence sheet in this repo.
*/


/* ------------------------------ CONDITIONER ------------------------------ */
module branch (
  input[31:0] pc,
  input[3:0] funct3,

  output [31:0] rd
);
  case (funct3)
    3'h0:
    3'h1:
    3'h4:
    3'h5:
    3'h6:
    3'h7:
  endcase
endcase
endmodule

module jump (
  input[31:0] pc,
  input[19:0] imm,

  output[31:0] rd
);
rd = (pc + imm) + 4;
endmodule
