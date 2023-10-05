`timescale 10ns/1ns

module ctrl_tb();
  logic [6:0] op;
  logic [2:0] funct3;
  logic funct7, zero;
  logic [2:0] ALUControl;
  logic pcSrc, ResultSrc, MemWrite, ALUSrc, Immsrc, RegWrite;

  reg status;

  ctrl ctrl(
    .op(op), 
    .zero(zero),
    .funct3(funct3),
    .funct7(funct7),
    .pcSrc(pcSrc), 
    .ResultSrc(ResultSrc), 
    .MemWrite(MemWrite), 
    .ALUSrc(ALUSrc), 
    .Immsrc(Immsrc), 
    .RegWrite(RegWrite),
    .ALUControl(ALUControl)
    );

  initial begin
      $dumpfile("sim.vcd"); 
      $dumpvars(
        0,
        op, 
        funct3, 
        funct7, 
        ALUControl, 
        pcSrc, 
        ResultSrc, 
        MemWrite, 
        ALUSrc, 
        Immsrc, 
        RegWrite
      );

      zero = 0;
      status = 0;

      // -------------------------------
      //        MAIN DECORDER
      // -------------------------------
      op = 7'b0000011; // lw
      #1
      assert(
        RegWrite == 1 &&
        Immsrc == 2'b00 &&
        ALUSrc == 1 &&
        MemWrite == 0 &&
        ResultSrc == 2'b01 &&
        pcSrc == 0 && // Set expected_pcSrc to the expected value
        ALUControl == 3'b000
      ) else begin
        $error("lw: is broken"); 
        status = 1;
      end

      op = 7'b0100011; // sw
      zero = 0;
      #1
      assert(
        RegWrite == 0 &&
        Immsrc == 2'b01 &&
        ALUSrc == 1 &&
        MemWrite == 1 &&
        pcSrc == 0 &&
        ALUControl == 3'b000
      ) else begin
        $error("sw: is broken"); 
        status = 1;
      end

      op = 7'b1101111; // jal
      zero = 0;
      #1
      assert(
        RegWrite == 1 &&
        Immsrc == 2'b11 &&
        MemWrite == 0 &&
        ResultSrc == 2'b10 &&
        pcSrc == 1
      ) else begin
        $error("jal: is broken");
        status = 1;
      end

      op = 7'b1100011; // beq
      zero = 1;
      #1
      assert(
        RegWrite == 0 &&
        Immsrc == 2'b10 &&
        ALUSrc == 0 &&
        MemWrite == 0 &&
        pcSrc == 1 &&
        ALUControl == 3'b001
      ) else begin
        $error("beq: is broken");
        status = 1;
      end

      op = 7'b0010011; // addi
      funct3 = 1'h0;
      #1
      assert(
        RegWrite == 1 &&
        Immsrc == 2'b00 &&
        ALUSrc == 1 &&
        MemWrite == 0 &&
        ResultSrc == 2'b00 &&
        pcSrc == 0 &&
        ALUControl == 3'b000
      ) else begin
        $error("i-type alu 1: is broken"); 
        status = 1;
      end

      op = 7'b0000011; // r-type
      #1
      assert(
        RegWrite == 1 &&
        Immsrc == 2'b00 &&
        ALUSrc == 1 &&
        MemWrite == 0 &&
        ResultSrc == 2'b01 &&
        pcSrc == 0 &&
        ALUControl == 3'b000
      ) else begin
        $error("r-type: is broken");
        status = 1;
      end

      #1;

      if (status) {
        $stop(1);
      } else {
        $finish();
      }
    end
endmodule
