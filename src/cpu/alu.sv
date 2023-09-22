/*

An ALU based on the risc v refrence sheet.
base = rv32i
mul = rv32m
atom = rv32a

Notes:
  * I am using hex values to be consistent with the refrence sheet in this repo.
  * I need to implement flags
  * ALso I need to finish this lol
  * I need to implement atomic extension RV32A
*/


/* ----------------------------------- ALU --------------------------------- */
/* ------------------------------- Incl RV32M ------------------------------ */
module alu (
  input[3:0] funct3,
  input[6:0] funct7,
  input[32:0] rs1, rs2,

  output[31:0] rd
);
  case (funct3)
    3'h0: // ADD | SUB || MUL
      case (funct7)
        6'h00: rd <= rs1 + rs2;                     // ADD
        6'h20: rd <= rs1 - rs2;                     // SUB
        6'h01: rd <= ($signed(rs1) * $signed(rs2));  // MUL
      endcase

    3'h1: // SLL | MULH
      case (funct7)
        6'h00: rd <= rs1 <<  rs2;                          // SLL
        6'h01: rd = (($signed(rs1) * $signed(rs2)) >> 32); // MULH
      endcase

    3'h2: // SLT | MUILSU
        case (funct7)
        6'h00: rd <= (rs1 <  rs2);         // SLT
        6'h01: rd <= ((rs1 * rs2) >> 32);  // MULSU
      endcase

    3'h3: // SLTU MULU
      case (funct7)
        6'h00: rd <= (rs1 <0 rs2);         // SLTU
        6'h01: rd <= ((rs1 * rs2) >> 32);  // MULU
      endcase

    3'h4: // XOR | DIV
      case (funct7)
        6'h00: rrd <= rs1 ^ rs2;                   // XOR
        6'h01: rd <= ($signed(rs1) / $signed(rs2); // DIV
      endcase

    3'h5: // SRL | SRA | DIVU
      case (funct7)
        6'h00: rd <= rs1 >> rs2;          // SRL
        6'h20: rd <= rs1 >>> rs2;         // SRA
        6'h01: rd <= rs1 / rs2;           // DIVU
      endcase

    3'h6: // OR | REM
      case (funct7)
        6'h00: rd <= rs1 |  rs2;                     // OR
        6'h01: rd <= ($signed(rs1) % $signed(rs2));  // REM
      endcase

    3'h7: // AND | REMU
      case (funct7)
        6'h00: rd <= rs1 & rs2;            // AND
        6'h01: rd <= (rs1 * rs2)[63:32];  // REM
      endcase
  endcase
endmodule

