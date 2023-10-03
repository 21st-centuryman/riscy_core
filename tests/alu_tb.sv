//`timescale 10ns/1ns

module alu_tb();
  logic [31:0] a, b, out;
  logic [2:0] ctrl;
  logic z, clk;

  alu alu(.clk(clk), .rs1(a), .rs2(b), .rd(out), .z(z), .ctrl(ctrl)); 

  always begin
    #1 clk = ~clk;
  end

  initial begin
      $dumpfile("sim.vcd"); 
      $dumpvars(0, a, b, out, z, ctrl);
      clk = 0;
      #1

      ctrl = 3'b000; // add
      a = 20; b = 30;
      #1;
      assert(out == (a + b)) else begin $display("ADD: is broken"); $finish(1); end

      #1
      ctrl = 3'b001; // sub
      a = 8; b = 3;
      #1;
      assert(out == (a + b)) else begin $display("SUB: is broken"); $finish(1); end

      #1
      ctrl = 3'b010; // and
      a = 20; b = 30;
      #1;
      assert(out == (a & b)) else begin $display("AND: is broken"); $finish(1); end

      #1
      ctrl = 3'b011; // or
      a = 20; b = 30;
      #1;
      assert(out == a | b) else begin $display("OR: is broken"); $finish(1); end
 
      #1
      ctrl = 3'b101; // slt
      a = 20; b = 30;
      #1;
      assert(out == (a < b)) else begin $display("SLT: is broken");$finish(1); end

      #1
      ctrl = 3'b001; // slt
      a = 20; b = 20;
      #1;
      assert(z) else begin $display("Zero flag is broken"); $finish(1); end

     $finish(0);
    end
endmodule
