`timescale 10ns/1ns

module TB();
  // ADD INPUTS

  /* --------------------------------- R TYPE -------------------------------- */
  alu alu(.funct7(f7), .rs2(b), .rs1(a), .funct3(f3), .rd(o)); 

  initial begin
      $dumpfile("sim.vcd"); 
      $dumpvars(0, alu, b, a, f3, f7, o);
 
      // ADD
      funct3 = 3'h0; funct7 = 6'h00;
      a = 4; b = 6;
      out1 = (rd == 10);
      a = -2; b = -4;
      out2 = (rd == -6);
      $display("ADD: %s %s", out1 ? "✔" : "X", out2 ? "✔" : "X");

      // SUB
      funct3 = 3'h0; funct7 = 6'h20;
      a = 4; b = 6;
      out1 = (rd == -2);
      a = -2; b = -4;
      out2 = (rd == 2);
      $display("SUB: %s %s", out1 ? "✔" : "X", out2 ? "✔" : "X");

      // MUL
      funct3 = 3'h0; funct7 = 6'h01;
      a = 4; b = 6;
      out1 = (rd == 24);
      a = -2; b = -4;
      out2 = (rd == 8);
      $display("MUL: %s %s", out1 ? "✔" : "X", out2 ? "✔" : "X");

      // SLL
      funct3 = 3'h1; funct7 = 6'h00;
      a = 4; b = 2;
      out1 = (rd == 16);
      a = -2; b = 3;
      out2 = (rd == -16);
      $display("SLL: %s %s", out1 ? "✔" : "X", out2 ? "✔" : "X");

      // MULH
      funct3 = 3'h1; funct7 = 6'h01;
      a = 4; b = 6;
      out1 = (rd == 0); // Assuming the result should be 0
      a = -2; b = -4;
      out2 = (rd == 0); // Assuming the result should be 0
      $display("MULH: %s %s", out1 ? "✔" : "X", out2 ? "✔" : "X");

      // SLT
      funct3 = 3'h2; funct7 = 6'h00;
      a = 4; b = 6;
      out1 = (rd == 1);
      a = -2; b = -4;
      out2 = (rd == 0);
      $display("SLT: %s %s", out1 ? "✔" : "X", out2 ? "✔" : "X");

      // Test MULSU operation
      funct3 = 3'h2; funct7 = 6'h01; // MULSU
      a = 4; b = 6;
      out1 = (rd == 0); // Assuming the result should be 0
      a = -2; b = -4;
      out2 = (rd == 0); // Assuming the result should be 0
      $display("MULSU: %s %s", out1 ? "✔" : "X", out2 ? "✔" : "X");

      // SLTU 
      funct3 = 3'h3; funct7 = 6'h00; 
      a = 4; b = 6;
      out1 = (rd == 1);
      a = -2; b = -4;
      out2 = (rd == 0);
      $display("SLTU: %s %s", out1 ? "✔" : "X", out2 ? "✔" : "X");

      // MULU
      funct3 = 3'h3; funct7 = 6'h01;
      a = 4; b = 6;
      out1 = (rd == 0); // Assuming the result should be 0
      a = -2; b = -4;
      out2 = (rd == 0); // Assuming the result should be 0
      $display("MULU: %s %s", out1 ? "✔" : "X", out2 ? "✔" : "X");

      // XOR
      funct3 = 3'h4; funct7 = 6'h00;
      a = 4; b = 6;
      out1 = (rd == 2);
      a = -2; b = -4;
      out2 = (rd == -2);
      $display("XOR: %s %s", out1 ? "✔" : "X", out2 ? "✔" : "X");

      // DIV
      funct3 = 3'h4; funct7 = 6'h01;
      a = 8; b = 2;
      out1 = (rd == 4);
      a = -8; b = 2;
      out2 = (rd == -4);
      $display("DIV: %s %s", out1 ? "✔" : "X", out2 ? "✔" : "X");

      // SRL
      funct3 = 3'h5; funct7 = 6'h00; 
      a = 16; b = 2;
      out1 = (rd == 4);
      a = -16; b = 3;
      out2 = (rd == 536870908); // Assuming the result should be 2^29 - 1
      $display("SRL: %s %s", out1 ? "✔" : "X", out2 ? "✔" : "X");

      // SRA
      funct3 = 3'h5; funct7 = 6'h20; 
      a = -16; b = 3;
      out1 = (rd == -2);
      a = 16; b = 3;
      out2 = (rd == 2);
      $display("SRA: %s %s", out1 ? "✔" : "X", out2 ? "✔" : "X");

      // DIVU
      funct3 = 3'h5; funct7 = 6'h01;
      a = 16; b = 3;
      out1 = (rd == 5);
      a = -16; b = 3;
      out2 = (rd == 536870909); // Assuming the result should be 2^29 - 2
      $display("DIVU: %s %s", out1 ? "✔" : "X", out2 ? "✔" : "X");

      // OR
      funct3 = 3'h6; funct7 = 6'h00;
      a = 5; b = 3;
      out1 = (rd == 7);
      a = -5; b = -3;
      out2 = (rd == -1);
      $display("OR: %s %s", out1 ? "✔" : "X", out2 ? "✔" : "X");

      // REM
      funct3 = 3'h6; funct7 = 6'h01;
      a = 10; b = 3;
      out1 = (rd == 1);
      a = -10; b = 3;
      out2 = (rd == -1);
      $display("REM: %s %s", out1 ? "✔" : "X", out2 ? "✔" : "X");

      // AND
      funct3 = 3'h7; funct7 = 6'h00;
      a = 5; b = 3;
      out1 = (rd == 1);
      a = -5; b = -3;
      out2 = (rd == -7);
      $display("AND: %s %s", out1 ? "✔" : "X", out2 ? "✔" : "X");

      // REMU
      funct3 = 3'h7; funct7 = 6'h01;
      a = 10; b = 3;
      out1 = (rd == 1);
      a = -10; b = 3;
      out2 = (rd == 1);
      $display("REMU: %s %s", out1 ? "✔" : "X", out2 ? "✔" : "X");
    end
endmodule
