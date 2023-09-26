
module cpu ():
  logic clk;
  logic [31:0] pc;
  logic [31:0] instr;

  initial begin
    
  end
endmodule


/* ------------------------------ CONTROLLER ------------------------------ */
module controller (
  input clk,
  input[31:0] instr, pc,
  output [31:0] out,pc_out
);
  always_ff @(posedge clk) begin : controller
    case (instr[6:0]) // OP CODE
      7'b0110011: begin : R-Type
        // Fetch the value of rs1, rs2, and the register we need to .rd
        alu #(.funct3(instr[14:12]), .funct7(instr[31:25]), .rs1(rs1), .rs2(rs2)) .rd(out);
        pc_out <= pc + 4;
      end
      
      7'b0010011: begin : I-Type
        // Fetch the value of rs1 and register rd
        assign logic [6:0] f7 = (instr[31:25] == 6'h00 || instr[31:25] == 6'h20) ?
          instr[31:25] : 6'h00;
        alu #(.funct3(instr[14:12]), .funct7(f7), .rs1(rs1), .rs2({21'b0, instr[31:19])}) .rd(pc_out;);
      end
              
      7'b0000011: begin : 
        // Load type
        pc_out <= pc + 4;
      end
              
      7'b0100011: begin : S-Type
        // S type
        pc_out <= pc + 4;
      end
              
      7'b1100011: begin : B-Type
        // B type
        pc_out <= pc + 4;
      end
              
      7'b1101111: begin : jal
        jal #(.pc(pc), .imm(instr[31:12]), .pc_out(pc_out));
      end      
              
      7'01100111: begin : jalr
        pc_out <= pc + 4;
      end
    endcase
  end
endmodule


/* ------------------------------ CONDITIONER ------------------------------ */
module branch (
  input clk,
  input[31:0] pc,imm,
  input[31:0] rs1, rs2,
  input[3:0] funct3,

  output [31:0] pc_out
);
  always @(posedge clk) begin
    case (funct3)
      3'h0: pc_out = (rs1 == rs2) ? pc + imm : pc + 4; // beq
      3'h1: pc_out = (rs1 != rs2) ? pc + imm : pc + 4; // bne
      3'h4: pc_out = (rs1 < rs2) ? pc + imm : pc + 4;  // blt
      3'h5: pc_out = (rs1 >= rs2) ? pc + imm : pc + 4; // bge
      3'h6: pc_out = (rs1 < rs2) ? pc + imm : pc + 4;  // bltu
      3'h7: pc_out = (rs1 >= rs2) ? pc + imm : pc + 4; // bgeu
    endcase
  end
endmodule

module jal (
  input [31:0] pc,
  input [19:0] imm,
  output [31:0] rd
);
  assign rd = pc + 4 + {{12{imm[19]}}, imm, 1'b0}; // jal
endmodule


/* ----------------------------------- ALU --------------------------------- */
/* ------------------------------- Incl RV32M ------------------------------ */
module alu (
  input[3:0] funct3,
  input[6:0] funct7,
  input[31:0] rs1, rs2,
  output reg [31:0] rd
);
always_comb begin 
  case (funct3)
    3'h0:  // ADD | SUB | MUL
      case (funct7)
        6'h00: rd = rs1 + rs2;                      // ADD
        6'h20: rd = rs1 - rs2;                      // SUB
        6'h01: rd = ($signed(rs1) * $signed(rs2));  // MUL
      endcase

    3'h1: // SLL | MULH
      case (funct7)
        6'h00: rd = rs1 <<  rs2;                           // SLL
        6'h01: rd = (($signed(rs1) * $signed(rs2)) >> 32); // MULH
      endcase

    3'h2:  // SLT | MUILSU
      case (funct7)
        6'h00: rd = rs1 <  rs2;         // SLT
        6'h01: rd = (rs1 * rs2) >> 32;  // MULSU
      endcase

    3'h3: // SLTU | MULU
      case (funct7)
        6'h00: rd = {31'b0, rs1 < rs2};   // SLTU
        6'h01: rd = (rs1 * rs2) >> 32;    // MULU
      endcase

    3'h4: // XOR | DIV
      case (funct7)
        6'h00: rd = rs1 ^ rs2;                      // XOR
        6'h01: rd = ($signed(rs1) / $signed(rs2));  // DIV
      endcase

    3'h5: begin // SRL | SRA | DIVU
      case (funct7)
        6'h00: rd = rs1 >> rs2;  // SRL
        6'h20: rd = rs1 >>> rs2; // SRA
        6'h01: rd = rs1 / rs2;   // DIVU
      endcase
    end

    3'h6: // OR | REM
      case (funct7)
        6'h00: rd = rs1 |  rs2;                     // OR
        6'h01: rd = ($signed(rs1) % $signed(rs2));  // REM
      endcase

    3'h7: // AND | REMU
      case (funct7)
        6'h00: rd = rs1 & rs2;          // AND
        6'h01: rd = (rs1 * rs2) >> 32;  // REM
      endcase
  endcase
end
endmodule
