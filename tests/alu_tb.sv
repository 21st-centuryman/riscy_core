//`timescale 10ns/1ns

module alu_tb();
  logic [31:0] a, b, out;
  logic [2:0] ctrl;
  logic z, clk;

  reg status;

  alu alu(.clk(clk), .rs1(a), .rs2(b), .rd(out), .z(z), .ctrl(ctrl)); 

  always begin
    #1 clk = ~clk;
  end

  initial begin
      $dumpfile("sim.vcd");
      $dumpvars(0, a, b, out, z, ctrl);
      clk = 0;
      #1

      status = 0;

      ctrl = 3'b000; // add
      a = 20; b = 30;
      #1;
      assert(out == (a + b)) else begin 
        $error("ADD: is broken"); 
        status = 1;
      end

      #1
      ctrl = 3'b001; // sub
      a = 8; b = 3;
      #1;
      assert(out == (a - b)) else begin 
        $error("SUB: is broken");
        status = 1;
      end

      #1
      ctrl = 3'b010; // and
      a = 20; b = 30;
      #1;
      assert(out == (a & b)) else begin 
        $error("AND: is broken"); 
        status = 1;
      end

      #1
      ctrl = 3'b011; // or
      a = 20; b = 30;
      #1;
      assert(out == a | b) else begin 
        $error("OR: is broken"); 
        status = 1;
      end

      #1
      ctrl = 3'b101; // slt
      a = 20; b = 30;
      #1;
      assert(out == (a < b)) else begin 
        $error("SLT: is broken"); 
        status = 1;
      end

      #1
      ctrl = 3'b001; // slt
      a = 20; b = 20;
      #1;
      assert(z) else begin 
        $error("Zero flag is broken"); 
        status = 1;
      end

      $stop(status);
    end
endmodule
