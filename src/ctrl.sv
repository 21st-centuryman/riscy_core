module ctrl (
    // INPUTS
    input clk,
    input [6:0] op,
    input [2:0] funct3,
    input funct7,
    input Zero,
    // OUTPUTS
    output reg PCSrc,
    MemWrite,
    ALUSrc,
    RegWrite,
    output reg [1:0] ImmSrc,
    ResultSrc,
    output reg [2:0] ALUControl


);
  reg [1:0] ALUOp;
  alu_decorder alu_dec (
      .ALUOp(ALUOp),
      .op(op[5]),
      .funct3(funct3),
      .funct7(funct7),
      .ALUControl(ALUControl)
  );

  always @(posedge clk) begin  // main_decoder
    reg Branch, Jump;
    case (op)

      7'b0000011: begin  // lw
        RegWrite <= 1;
        ImmSrc <= 2'b00;
        ALUSrc <= 1;
        MemWrite <= 0;
        ResultSrc <= 2'b01;
        Branch <= 0;
        ALUOp <= 2'b00;
        Jump <= 0;
      end
      7'b0100011: begin  // sw
        RegWrite <= 0;
        ImmSrc <= 2'b01;
        ALUSrc <= 1;
        MemWrite <= 1;
        Branch <= 0;
        ALUOp <= 2'b00;
        Jump <= 0;
      end

      7'b0110011: begin  // r-type
        RegWrite <= 1;
        ALUSrc <= 0;
        MemWrite <= 0;
        ResultSrc <= 2'b00;
        Branch = 0;
        Jump   = 0;
        ALUOp <= 2'b10;
      end

      7'b1100011: begin  // beq
        RegWrite <= 0;
        ImmSrc <= 2'b10;
        ALUSrc <= 0;
        MemWrite <= 0;
        Branch <= 1;
        ALUOp <= 2'b01;
        Jump <= 0;
      end
      7'b0010011: begin  // i-type ALU
        RegWrite <= 1;
        ImmSrc <= 2'b00;
        ALUSrc <= 1;
        MemWrite <= 0;
        ResultSrc <= 2'b00;
        Branch <= 0;
        ALUOp <= 2'b10;
        Jump <= 0;
      end
      7'b1101111: begin  // jal
        RegWrite <= 1;
        ImmSrc <= 2'b11;
        MemWrite <= 0;
        ResultSrc <= 2'b10;
        Branch <= 0;
        Jump <= 1;
      end

      default: ;
    endcase
    PCSrc <= (Jump | (Branch & Zero));
  end
endmodule



module alu_decorder (
    // INPUTS
    input [1:0] ALUOp,
    input [2:0] funct3,
    input op,
    funct7,
    // OUTPUTS
    output reg [2:0] ALUControl
);
  always @(ALUOp) begin
    case (ALUOp)
      2'b00:   ALUControl <= 3'b000;  // add
      2'b01:   ALUControl <= 3'b001;  // sub
      2'b10: begin
        case (funct3)
          3'b000:  ALUControl <= op && funct7 ? 3'b001 : 3'b000;  // sub : add
          3'b010:  ALUControl <= 3'b101;  // slt
          3'b110:  ALUControl <= 3'b110;  // or
          3'b111:  ALUControl <= 3'b010;  // and
          default: ;
        endcase
      end
      default: ;
    endcase
  end
endmodule
