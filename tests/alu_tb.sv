`timescale 10ns/1ns

module alu_tb();
  logic [31:0] a, b, out;
  logic [2:0] ctrl;
  logic z;

  alu alu(.rs1(a), .rs2(b), .rd(out), .z(z), .ctrl(ctrl)); 

  initial begin
      $dumpfile("sim.vcd"); 
      $dumpvars(0, a, b, out, z, ctrl);

      #1
      ctrl = 3'b000; // add
      a = 20; b = 30;
      assert(out = (a + b)) else $display("ADD: is broken");

      #1;
      ctrl = 3'b001; // sub
      a = 20; b = 30;
      assert(out = (a - b)) else $display("SUB: is broken");

      #1;
      ctrl = 3'b010; // and
      a = 20; b = 30;
      assert(out = (a & b)) else $display("AND: is broken");

      #1;
      ctrl = 3'b011; // or
      a = 20; b = 30;
      assert(out = (a | b)) else $display("OR: is broken");

      #1;
      ctrl = 3'b101; // slt
      a = 20; b = 30;
      assert(out = (a < b)) else $display("SLT: is broken");
    end
endmodule