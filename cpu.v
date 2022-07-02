module alu (
  input clk,
  input mod,
  input [31:0] a,
  input [31:0] b,
  input [2:0] funct3,
  output [31:0] n,
);
  always @(posedge clk) begin
    case (funct3)
      3'b000: begin // add & sub
        n <= mod ? a - b : a + b; 
      end

      3'b001: begin // sll
        n <= a << b;
      end

      3'b010: begin // slt. Not done
        n <= a < b ? 1 : 0;
      end

      3'b011: begin // sltu. Not done
      
      end

      3'b100: begin // xor
        n <= a ^ b;
      end

      3'b101: begin // srl & sra
      n <= mod ? a >> b :  a >>> b
      end
      
      3'b110: begin // or
        n <= a | b;
      end

      3'b111: begin // and
        n <= a & b;
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
  input [2:0] funct3,
  output reg n,
);
  always @(posedge clk) begin
    case (con)

      3'b000: begin // beq
        n <= a == b 
      end

      3'b001: begin // bne
        n <= a != b
      end

      3'b100: begin // blt
        n <= a < b
      end

      3'b101: begin // bge
        n <= a >=b
      end

      3'b110: begin // bltu. Needs to be zero extended
        n <= a < b
      end

      3'b111: begin // bgeu. Needs to be zero extended
        n <= a >= b
      end
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


