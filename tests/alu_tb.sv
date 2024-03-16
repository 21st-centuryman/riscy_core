module alu_tb ();
  logic [31:0] a, b, out;
  logic [2:0] funct3;
  logic [6:0] funct7;
  logic z, clk;

  reg status;

  alu alu (
      .clk(clk),
      .rs1(a),
      .rs2(b),
      .rd(out),
      .z(z),
      .funct3(funct3),
      .funct7(funct7)
  );

  always begin
    #1 clk = ~clk;
  end

  initial begin
    $display("Starting simulation");
    $dumpfile("sim.vcd");
    $dumpvars(0, a, b, out, z, funct3, funct7);
    clk = 0;

    #1 funct3 = 3'b000;  // ADD
    funct7 = 7'h00;
    a = 20;
    b = 30;
    #1
    assert (out == (a + b))
    else $error("ADD: is broken");

    #1 funct3 = 3'b000;  // SUB
    funct7 = 7'h20;
    a = 8;
    b = 3;
    #1
    assert (out == (a - b))
    else $error("SUB: is broken");

    //funct3 = 3'b001;  // SLL FIX
    //funct7 = 7'h00;
    //a = 8;
    //b = 3;
    //assert (out == (a - b))
    //else $error("SLL: is broken");

    // funct3 = 3'b010;  // SLT FIX
    // funct7 = 7'h00;
    // a = 8;
    // b = 3;
    // assert (out == (a - b))
    // else $error("SLT: is broken");

    // funct3 = 3'b010;  // SLTU FIX
    // funct7 = 7'h00;
    // a = 8;
    // b = 3;
    // assert (out == (a - b))
    // else $error("SLTU: is broken");

    #1 funct3 = 3'b010;  // XOR FIX
    funct7 = 7'h00;
    a = 8;
    b = 3;
    #1
    assert (out == (a ^ b))
    else $error("XOR: is broken");

    // funct3 = 3'b101;  // SRL FIX
    // funct7 = 7'h00;
    // a = 8;
    // b = 3;
    // assert (out == (a - b))
    // else $error("SRL: is broken");

    // funct3 = 3'b101;  // SRA FIX
    // funct7 = 7'h20;
    // a = 8;
    // b = 3;
    // assert (out == (a - b))
    // else $error("SRA: is broken");

    #1 funct3 = 3'b110;  // OR
    a = 20;
    b = 30;
    #1
    assert (out == (a | b))
    else $error("OR: is broken");

    #1 funct3 = 3'b111;  // AND
    a = 20;
    b = 30;
    #1
    assert (out == (a & b))
    else $error("AND: is broken");


    // -----------------------------
    // FLAGS TO BE IMPLEMENTED LATER
    // -----------------------------

    //funct3 = 3'b001;  // slt
    //a = 20;
    //b = 20;
    //assert (z)
    //else $error("Zero flag is broken");

    $finish;
  end
endmodule
