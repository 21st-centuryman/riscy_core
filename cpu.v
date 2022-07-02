module alu (
  input clk,
  input mod,
  input [31:0] a,
  input [31:0] b,
  input [2:0] con,
  output [31:0] n,
);
  always @(posedge clk) begin
    case (con)
      3'b000: begin // add, sub, addi, depending on the modification
        n <= mod ? a - b : a + b; 
      end

      3'b001: begin // and
        n <= a & b;
      end

      3'b010: begin // or
        n <= a | b;
      end

      3'b011: begin // xor
        n <= a ^ b;
      end

      3'b100: begin // slt, not correct need to update
        n <= a < b ? 1 : 0;
      end

      3'b101: begin
        
      end

      3'b110: begin 
      end
      
      3'b111: begin 
      end

      default: 
    endcase
    
  end

  
endmodule // alu

// Conditional statements, takes care of branching.
module cond (
  input clk,
  input [31:0] a,
  input [31:0] b,
  input [1:0] con,
  output reg n,
);
  always @(posedge clk) begin
    case (con)

      2'b00: begin // beq
        n <= a == b 
      end

      2'b01: begin // bne
        n <= a != b
      end

      2'b10: begin // blt
        n <= a < b
      end

      2'b11: begin // bge
        n <= a >=b
      end

      /*
      Future additions:

      3'b100: begin // bltu
      end

      3'b101: begin // bgeu
      end
      */
      default:
    endcase
    
  end
  
endmodule // cond



module ram(
  parameters
) (
  ports
);
  
endmodule // ram




//Very much a RISC-V core
module verycore ( 
  parameters
) (
  ports
);
  
endmodule // verycore


