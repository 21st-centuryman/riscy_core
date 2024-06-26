module ctrl_tb ();
  logic [6:0] op;
  logic [2:0] funct3, ALUControl;
  logic [1:0] ImmSrc, ResultSrc;
  logic funct7, Zero;
  logic PCSrc, MemWrite, ALUSrc, RegWrite;
  logic [31:0] a, b,  /* verilator lint_off UNUSEDSIGNAL */ out;

  reg clk;

  alu alu (
      // INPUTS
      .clk(clk),
      .funct3(funct3),
      .funct7(funct7),
      .rs1(a),
      .rs2(b),
      // OUTPUTS
      .rd(out),
      // FLAGS
      .z(Zero)
  );


  ctrl ctrl (
      // INPUTS
      .clk(clk),
      .op(op),
      .funct3(funct3),
      .funct7(funct7),
      .Zero(Zero),
      // OUTPUTS
      .PCSrc(PCSrc),
      .MemWrite(MemWrite),
      .ALUSrc(ALUSrc),
      .RegWrite(RegWrite),
      .ImmSrc(ImmSrc),
      .ResultSrc(ResultSrc),
      .ALUControl(ALUControl)
  );

  always begin
    #1 clk <= ~clk;
  end


  initial begin
    $dumpfile("sim.vcd");
    $dumpvars(0, clk, op, funct3, ALUControl, PCSrc, ResultSrc, MemWrite, ALUSrc, ImmSrc, RegWrite);

    Zero = 0;
    a = 0;
    b = 0;

    // -------------------------------
    //        MAIN DECORDER
    // -------------------------------

    op = 7'b0000011;  // lw
    #2;
    assert(
        RegWrite == 1 &&
        ImmSrc == 2'b00 &&
        ALUSrc == 1 &&
        MemWrite == 0 &&
        ResultSrc == 2'b01 &&
        ALUControl == 3'b000 &&
        PCSrc == 0  // Set expected_PCSrc to the expected value
    )
    else $error("lw: is broken");

    op   = 7'b0100011;  // sw
    Zero = 0;
    #2;
    assert (
      RegWrite == 0 &&
      ImmSrc == 2'b01 &&
      ALUSrc == 1 &&
      MemWrite == 1 &&
      ALUControl == 3'b000 &&
      PCSrc == 0)
    else $error("sw: is broken");

    op = 7'b0110011;  // R add
    funct3 = 3'b000;
    funct7 = 0;
    #2;
    assert (
      RegWrite == 1 &&
      ALUSrc == 0 &&
      MemWrite == 0 &&
      ResultSrc == 2'b00 &&
      PCSrc == 0 &&
      ALUControl == 3'b000
      )
    else $error("R ADD: is broken");

    op = 7'b0110011;  // R sub
    funct3 = 3'b000;
    funct7 = 1;
    #2;
    assert (
      RegWrite == 1 &&
      ALUSrc == 0 &&
      MemWrite == 0 &&
      ResultSrc == 2'b00 &&
      PCSrc == 0 &&
      ALUControl == 3'b001
      )
    else $error("R SUB: is broken");

    op = 7'b0110011;  // R slt
    funct3 = 3'b010;
    #2;
    assert (
      RegWrite == 1 &&
      ALUSrc == 0 &&
      MemWrite == 0 &&
      ResultSrc == 2'b00 &&
      PCSrc == 0 &&
      ALUControl == 3'b101
      )
    else $error("R SLT: is broken");

    op = 7'b0110011;  // R sub
    funct3 = 3'b000;
    funct7 = 1;
    #2;
    assert (
      RegWrite == 1 &&
      ALUSrc == 0 &&
      MemWrite == 0 &&
      ResultSrc == 2'b00 &&
      PCSrc == 0 &&
      ALUControl == 3'b001
      )
    else $error("R SUB: is broken");

    op = 7'b0110011;  // R sub
    funct3 = 3'b000;
    funct7 = 1;
    #2;
    assert (
      RegWrite == 1 &&
      ALUSrc == 0 &&
      MemWrite == 0 &&
      ResultSrc == 2'b00 &&
      PCSrc == 0 &&
      ALUControl == 3'b001
      )
    else $error("R SUB: is broken");


    op = 7'b0010011;  // i-type
    funct3 = 3'b000;
    #2;
    assert (RegWrite == 1 && ImmSrc == 2'b00 && ALUSrc == 1 && MemWrite == 0 && ResultSrc == 2'b00)
    else $error("i-type: is broken");

    op   = 7'b1101111;  // jal
    Zero = 0;
    #2;
    assert (RegWrite == 1 && ImmSrc == 2'b11 && MemWrite == 0 && ResultSrc == 2'b10)
    else $error("jal: is broken");

    op   = 7'b1100011;  // beq
    Zero = 1;
    #2;
    assert (RegWrite == 0 && ImmSrc == 2'b10 && ALUSrc == 0 && MemWrite == 0)
    else $error("beq: is broken");


    op = 7'b0010011;  // addi
    funct3 = 3'b000;
    funct7 = 1;
    assert (ALUControl == 3'b000 && funct7 == 1) $finish;

    $finish;
  end
endmodule
