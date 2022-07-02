module alu (
  input clk,
  input [31:0] a,
  input [31:0] b,
  input [2:0] alucon,
  output [31:0] n
);
  always @(posedge clk) begin
    case (alucon)
      3'b000: begin // add
        n <= a + b; 
      end

      3'b001: begin // sub
        n <= a - b;
      end

      3'b010: begin // and
        n <= a & b;
      end

      3'b011: begin // or
        n <= a | b;
      end

      3'b100: begin // xor
        n <= a ^ b;
      end

      3'b101: begin // slt
        n <= a < b ? 1 : 0;
      end

      3'b110: begin // Future operations
        
      end

      3'b111: begin // Futire operations
      end

      default: 
    endcase
    
  end

  
endmodule // alu



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


