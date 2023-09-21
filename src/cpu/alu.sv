/*

An ALU based on the risc v refrence sheet. 
base = rv32i
mul = rv32m
atom = rv32a

Notes:
  * I am using hex values to be consistent with the refrence sheet in this repo.
  * I need to implement flags
  * ALso I need to finish this lol
*/


module alu (
  input clk,
  input[3:0] funct3
  input[6:0] funct7
  input[6:0] OP
);

endmodule

/* --------------------------------- R TYPE -------------------------------- */
/* ------------------------------- Incl RV32M ------------------------------ */
module r_type (
  input[3:0] funct3,
  input[6:0] OP, funct7,
  input[32:0] rs1, rs2

  output [31:0] rd
);
case (funct3)
  3'h0: // ADD | SUB || MUL
    case (funct7)
      6'h00: rd <= rs1 + rs2;          // ADD
      6'h20: rd <= rs1 - rs2;          // SUB
      6'h01: rd <= (rs1 * rs2)[31:0];  // MUL
    endcase

  3'h1: // SLL | MULH
    case (funct7)
      6'h00: rd <= rs1 <<  rs2;        // SLL
      6'h01: rd <= (rs1 * rs2)[63:32]; // MULM
    endcase

  3'h2: // SLT | MUILSU
    case (funct7)
      6'h00: rd <= (rs1 <  rs2);        // SLT
      6'h01: rd <= (rs1 * rs2)[63:32];  // FIX
    endcase

  3'h3: // SLTU MULU
    case (funct7)
      6'h00: rd <= (rs1 <0 rs2);        // SLTU
      6'h01: rd <= (rs1 * rs2)[63:32];  // FIX
    endcase

  3'h4: // XOR | DIV
    case (funct7)
      6'h00: rrd <= rs1 ^ rs2;          // XOR
      6'h01: rd <= (rs1 * rs2)[63:32];  // FIX
    endcase

  3'h5: // SRL | SRA | DIVU
    case (funct7)
      6'h00: rd <= rs1 >> rs2;          // SRL
      6'h20: rd <= rs1 >>> rs2;         // SRA
      6'h01: rd <= (rs1 * rs2)[63:32];  // FIX
    endcase

  3'h6: // OR | REM
    case (funct7)
      6'h00: rd <= rs1 |  rs2;        // OR
      6'h01: rd <= (rs1 * rs2)[63:32];  // FIX
    endcase


  3'h7: // AND | REMU
    case (funct7)
      6'h00: rd <= rs1 & rs2;        // AND
      6'h01: rd <= (rs1 * rs2)[63:32];  // FIX
    endcase

endcase
endmodule

/* --------------------------------- I TYPE -------------------------------- */
module i_type (
  input[32:0] rs1,
  input[11:0] imm,
  input[3:0] funct3,

  output [31:0] rd
);
case (funct3)
  3'h0: rd <= rs1 + imm; // ADDI

  3'h1:
    case (imm[11:5])
      6'h00: rd <= (rs1 << imm[4:0]); //SLLI
    endcase

  3'h2: rd <= (rs1 < imm); // SLTI

  3'h3: rd <= (rs1 <0 imm); // SLTIU

  3'h4: rd <= (rs1 ^ imm); //XORI

  3'h5:  //SRLI/SRAI
    case (imm[11:5])
      6'h00: rd <= rs1 >> imm[4:0]; //SRLI
      6'h20: rd <= rs1 >>> imm[4:0]; //SRAI
    endcase

  3'h6: rd <= (rs1 | imm); //ORI

  3'h7: rd <= (rs1 & imm) //ANDI

endcase
endmodule

module i_type_load (
  input[32:0] rs1,
  input[11:0] imm,
  input[3:0] funct3,

  output [31:0] rd
);
  
endmodule

/* --------------------------------- S TYPE -------------------------------- */
module moduleName (
  ports
);
  
endmodule

/* --------------------------------- B TYPE -------------------------------- */
module moduleName (
  ports
);
  
endmodule

/* --------------------------------- U TYPE -------------------------------- */
module moduleName (
  ports
);
  
endmodule

/* --------------------------------- J TYPE -------------------------------- */
module moduleName (
  ports
);
  
endmodule
