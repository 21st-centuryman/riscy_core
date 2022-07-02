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
      3'b000: begin // ADDI & SUB
        n <= mod ? a - b : a + b; 
      end

      3'b001: begin // SLL
        n <= a << b[4:0];
      end

      3'b010: begin // SLT.
        n <= {31'b0, $signed(a) < $signed(b)};
      end

      3'b011: begin // SLTU
        n <= {31'b0, a < b};
      end

      3'b100: begin // XOR
        n <= a ^ b;
      end

      3'b101: begin // SRL & SRA
      n <= mod ? (a >>> b[4:0]) : (a >> b[4:0]);
      end
      
      3'b110: begin // OR
        n <= a | b;
      end

      3'b111: begin // AND
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

      3'b000: begin // BEQ
        n <= a == b;
      end

      3'b001: begin // BNE
        n <= a != b;
      end

      3'b100: begin // BLT
        n <= $signed(a) < $signed(b);
      end

      3'b101: begin // BEG
        n <= $signed(a) >= $signed(b);
      end

      3'b110: begin // BLTU.
        n <= a < b;
      end

      3'b111: begin // BGEU.
        n <= a >= b;
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


