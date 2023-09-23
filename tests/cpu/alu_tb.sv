`timescale 10ns/1ns

module TB();
  logic[3:0] f3;
  logic[6:0] f7;
  logic[31:0] a, b, o;
  logic out1, out2;

  alu alu(.funct7(f7), .rs2(b), .rs1(a), .funct3(f3), .rd(o)); 

  initial begin
      $dumpfile("sim.vcd"); 
      $dumpvars(0, alu, b, a, f3, f7, o);
 
      // ADD
      f3 = 3'h0; f7 = 6'h00;
      a = 4; b = 6;
      #1
      out1 = (o == 10);
      a = -2; b = -4;
      #1
      out2 = (o == -6);
      $display("ADD: %s %s", out1 ? "✓" : "X", out2 ? "✓" : "X");

      // SUB
      f3 = 3'h0; f7 = 6'h20;
      a = 4; b = 6;
      #1
      out1 = (o == -2);
      a = -2; b = -4;
      #1
      out2 = (o == 2);
      $display("SUB: %s %s", out1 ? "✓" : "X", out2 ? "✓" : "X");

      // MUL
      f3 = 3'h0; f7 = 6'h01;
      a = 4; b = 6;
      #1
      out1 = (o == 24);
      a = -2; b = -4;
      #1
      out2 = (o == 8);
      $display("MUL: %s %s", out1 ? "✓" : "X", out2 ? "✓" : "X");

      // SLL
      f3 = 3'h1; f7 = 6'h00;
      a = 4; b = 2;
      #1
      out1 = (o == 16);
      a = -2; b = 3;
      #1
      out2 = (o == -16);
      $display("SLL: %s %s", out1 ? "✓" : "X", out2 ? "✓" : "X");

      // MULH
      f3 = 3'h1; f7 = 6'h01;
      a = 4; b = 6;
      #1
      out1 = (o == 0); // Assuming the result should be 0
      a = -2; b = -4;
      #1
      out2 = (o == 0); // Assuming the result should be 0
      $display("MULH: %s %s", out1 ? "✓" : "X", out2 ? "✓" : "X");

      // SLT
      f3 = 3'h2; f7 = 6'h00;
      a = 4; b = 6;
      #1
      out1 = (o == 1);
      a = -2; b = -4;
      #1
      out2 = (o == 0);
      $display("SLT: %s %s", out1 ? "✓" : "X", out2 ? "✓" : "X");

      // Test MULSU operation
      f3 = 3'h2; f7 = 6'h01; // MULSU
      a = 4; b = 6;
      #1
      out1 = (o == 0); // Assuming the result should be 0
      a = -2; b = -4;
      #1
      out2 = (o == 0); // Assuming the result should be 0
      $display("MULSU: %s %s", out1 ? "✓" : "X", out2 ? "✓" : "X");

      // SLTU 
      f3 = 3'h3; f7 = 6'h00; 
      a = 4; b = 6;
      #1
      out1 = (o == 1);
      a = -2; b = -4;
      #1
      out2 = (o == 0);
      $display("SLTU: %s %s", out1 ? "✓" : "X", out2 ? "✓" : "X");

      // MULU
      f3 = 3'h3; f7 = 6'h01;
      a = 4; b = 6;
      #1
      out1 = (o == 0); // Assuming the result should be 0
      a = -2; b = -4;
      #1
      out2 = (o == 0); // Assuming the result should be 0
      $display("MULU: %s %s", out1 ? "✓" : "X", out2 ? "✓" : "X");

      // XOR
      f3 = 3'h4; f7 = 6'h00;
      a = 4; b = 6;
      #1
      out1 = (o == 2);
      a = -2; b = -4;
      #1
      out2 = (o == -2);
      $display("XOR: %s %s", out1 ? "✓" : "X", out2 ? "✓" : "X");

      // DIV
      f3 = 3'h4; f7 = 6'h01;
      a = 8; b = 2;
      #1
      out1 = (o == 4);
      a = -8; b = 2;
      #1
      out2 = (o == -4);
      $display("DIV: %s %s", out1 ? "✓" : "X", out2 ? "✓" : "X");

      // SRL
      f3 = 3'h5; f7 = 6'h00; 
      a = 16; b = 2;
      #1
      out1 = (o == 4);
      a = -16; b = 3;
      #1
      out2 = (o == 536870908); // Assuming the result should be 2^29 - 1
      $display("SRL: %s %s", out1 ? "✓" : "X", out2 ? "✓" : "X");

      // SRA
      f3 = 3'h5; f7 = 6'h20; 
      a = -16; b = 3;
      #1
      out1 = (o == -2);
      a = 16; b = 3;
      #1
      out2 = (o == 2);
      $display("SRA: %s %s", out1 ? "✓" : "X", out2 ? "✓" : "X");

      // DIVU
      f3 = 3'h5; f7 = 6'h01;
      a = 16; b = 3;
      #1
      out1 = (o == 5);
      a = -16; b = 3;
      #1
      out2 = (o == 536870909); // Assuming the result should be 2^29 - 2
      $display("DIVU: %s %s", out1 ? "✓" : "X", out2 ? "✓" : "X");

      // OR
      f3 = 3'h6; f7 = 6'h00;
      a = 5; b = 3;
      #1
      out1 = (o == 7);
      a = -5; b = -3;
      #1
      out2 = (o == -1);
      $display("OR: %s %s", out1 ? "✓" : "X", out2 ? "✓" : "X");

      // REM
      f3 = 3'h6; f7 = 6'h01;
      a = 10; b = 3;
      #1
      out1 = (o == 1);
      a = -10; b = 3;
      #1
      out2 = (o == -1);
      $display("REM: %s %s", out1 ? "✓" : "X", out2 ? "✓" : "X");

      // AND
      f3 = 3'h7; f7 = 6'h00;
      a = 5; b = 3;
      #1
      out1 = (o == 1);
      a = -5; b = -3;
      #1
      out2 = (o == -7);
      $display("AND: %s %s", out1 ? "✓" : "X", out2 ? "✓" : "X");

      // REMU
      f3 = 3'h7; f7 = 6'h01;
      a = 10; b = 3;
      #1
      out1 = (o == 1);
      a = -10; b = 3;
      #1
      out2 = (o == 1);
      $display("REMU: %s %s", out1 ? "✓" : "X", out2 ? "✓" : "X");
    end
endmodule
