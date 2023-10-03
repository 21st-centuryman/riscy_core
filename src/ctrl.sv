// This is really ugly, but I am blidnly following the harris and harris
// guide. As soon as we have a working cpu we will worry about cleaning this
// up
module controller (
  input zero,
  input [6:0] op,
  input [2:0] funct3,
  input funct7,
  // OUTPUTS
  output pcSrc, ResultSrc, MemWrite, ALUSrc, Immsrc, RegWrite
  output [2:0] ALUControl
);
always_ff @(op) begin : main_decoder
  logic branch; logic jump;
  logic[1:0] ALUOp;
  case (op)
    7'b0000011: begin : lw
      RegWrite = 1;
      Immsrc = 2'b00;
      ALUSrc = 1;
      MemWrite = 0;
      ResultSrc = 2'b01;
      branch = 0;
      ALUOp = 2'b00;
      jump = 0;
    end
    7'b0100011: begin : sw
      RegWrite = 0;
      Immsrc = 2'b01;
      ALUSrc = 1;
      MemWrite = 1;
      branch = 0;
      ALUOp = 2'b00;
      jump = 0;
    end
    7'b0110011: begin : r-type
      RegWrite = 1;
      ALUSrc = 0;
      MemWrite = 0;
      ResultSrc = 2'b00;
      branch = 0;
      ALUOp = 2'b10;
      jump = 0;
    end
    7'b1100011: begin : beq
      RegWrite = 0;
      Immsrc = 2'b10;
      ALUSrc = 0;
      MemWrite = 0;
      branch = 1;
      ALUOp = 2'b01;
      jump = 0;
    end
    7'b0010011: begin : i-type ALU
      RegWrite = 1;
      Immsrc = 2'b00;
      ALUSrc = 1;
      MemWrite = 0;
      ResultSrc = 2'b00;
      branch = 0;
      ALUOp = 2'b10;
      jump = 0;
    end
    7'b1101111: begin : jal
      RegWrite = 1;
      Immsrc = 2'b11;
      MemWrite = 0;
      ResultSrc = 2'b10;
      branch = 0;
      jump = 1;
    end
  endcase
end

always_ff @(op or funct3 or funct7 or ALUOp) begin : alu_decoder
  case (ALUOp)
    2'b00: ALUControl = 3'b000;
    2'b01: ALUControl = 3'b001;
    2'b10: begin
      case (funct3)
        3'b000: ALUControl = ({op[5], funct7} == 2'b11) ? 3'b001 : 3'b000;
        3'b010: ALUControl = 3'b101;
        3'b110: ALUControl = 3'b011;
        3'b111: ALUControl = 3'b010;
      endcase
    end
  endcase
end

assign pcSrc = (jump | (branch & zero));

endmodule
