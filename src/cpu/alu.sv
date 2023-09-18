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

module base_alui (
  input[32:0] rs1
  input[19:0] imm
  input[3:0] funct3
  /* --------------------------------- Outputs -------------------------------- */
  output [31:0 ] rd
);
case (funct3)
  3'h0: begin: ADDI
    rd <= rs1 + imm
  end
  3'h1: begin: SLLI
  end
  3'h2: begin: SLTI
  end
  3'h3: begin: SLTIU
  end
  3'h4: begin: XORI
  end
  3'h5: begin: SRLI/SRAI
  end
  3'h6: begin: ORI
  end
  3'h7: begin: ANDI
  end
endcase
endmodule



/*
---------------
EXTENSIONS BABY
---------------
*/

// RV32M Multiply Extension
// RV32A Atomic Extension
// RV32F / D Floating-Point Extensions 
