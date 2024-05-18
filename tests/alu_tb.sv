module alu_tb ();
  logic [31:0] a, b, out;
  logic [2:0] funct3;
  logic funct7;
  logic z;

  reg clk;

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
    #1 clk <= ~clk;
  end

  initial begin
    $display("Starting simulation");
    $dumpfile("sim.vcd");
    $dumpvars(0, a, b, out, z, funct3, funct7);
    clk = 0;

    funct3 = 3'b000;  // ADD
    funct7 = 0;
    a = 20;
    b = 30;
    #2
    assert (out == (a + b))
    else $error("ADD: is broken");

    funct3 = 3'b000;  // SUB
    funct7 = 1;
    a = 8;
    b = 3;
    #2
    assert (out == (a - b))
    else $error("SUB: is broken");

    funct3 = 3'b001;  // SLL
    funct7 = 0;
    a = 8;
    b = 3;
    #2
    assert (out == (a << b))
    else $error("SLL: is broken");

    funct3 = 3'b010;  // SLT
    funct7 = 0;
    a = 8;
    b = 3;
    #2
    assert (out == (a < b ? 1 : 0))
    else $error("SLT: is broken");

    funct3 = 3'b010;  // SLTU
    funct7 = 0;
    a = 8;
    b = 3;
    #2
    assert (out == (a < b ? 1 : 0))
    else $error("SLTU: is broken");

    funct3 = 3'b010;  // XOR
    funct7 = 0;
    a = 8;
    b = 3;
    #2
    $display("out: %d", out);
    assert (out == (a ^ b))
    else $error("XOR: is broken");

    funct3 = 3'b101;  // SRL
    funct7 = 0;
    a = 8;
    b = 3;
    #2

    assert (out == (a >> b))
    else $error("SRL: is broken");

    funct3 = 3'b101;  // SRA
    funct7 = 1;
    a = 8;
    b = 3;
    #2
    assert (out == (a >> b))
    else $error("SRA: is broken");

    funct3 = 3'b110;  // OR
    a = 20;
    b = 30;
    #2
    assert (out == (a | b))
    else $error("OR: is broken");

    funct3 = 3'b111;  // AND
    a = 20;
    b = 30;
    #2
    assert (out == (a & b))
    else $error("AND: is broken");


    // -----------------------------
    // FLAGS TO BE IMPLEMENTED LATER
    // -----------------------------

    funct3 = 3'b000;  // SUB
    funct7 = 1;
    a = 20;
    b = 20;
    #2
    assert (z == 1)
    else $error("Zero flag is broken");

    $finish;
  end
endmodule
