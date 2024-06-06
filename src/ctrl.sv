/*
ControlUnit: Decodes the instruction and generates control signals for the rest of the CPU.
*/
module ctrl (
    // INPUTS
    input clk,
    input [31:0] inst,
    // OUTPUTS
    output reg [2:0] funct3,
    output reg [5:0] funct7,
    output reg [3:0] rs1,
    output reg [3:0] rs2,
    output reg [3:0] rd,
    output reg [19:0] imm
);

  always @(posedge clk) begin  // main_decoder
    case (inst[6:0])

      7'b0110011: begin  // r-type
        funct7 <= inst[31:25];
        rs2 <= inst[24:20];
        rs1 <= inst[19:15];
        funct3 <= inst[14:12];
        rd <= inst[11:7];
        imm <= 'x;
      end

      7'b0010011: begin  // i-type
        imm <= inst[31:20];  // Fix imm instruction, ie fix the benchmark and testing
        rs1 <= inst[19:15];
        funct3 <= inst[14:12];
        rd <= inst[11:7];
        rs2 <= 'x;
        funct7 <= 'x;
      end

      7'b0100011: begin  // s-type
        imm[11:5] <= inst[31:25];
        rs2 <= inst[34:20];
        rs1 <= inst[19:15];
        funct3 <= inst[14:12];
        imm[4:0] <= inst[11:7];
        imm[19:11] <= 'x;
        rd <= 'x;
        funct7 <= 'x;
      end

      7'b1100011: begin  // b-type
        imm[11:5] <= inst[31:25];
        rs2 <= inst[34:20];
        rs1 <= inst[19:15];
        funct3 <= inst[14:12];
        imm[4:0] <= inst[11:7];
        imm[19:11] <= 'x;
        rd <= 'x;
        funct7 <= 'x;
      end

      7'b1101111: begin  // u-type
        imm <= inst[31:12];
        rd <= inst[11:7];
        funct3 <= 'x;
        rs1 <= 'x;
        rs2 <= 'x;
        funct7 <= 'x;
      end

      7'b1101111: begin  // j-type
        imm <= inst[31:12];
        rd <= inst[11:7];
        funct3 <= 'x;
        rs1 <= 'x;
        rs2 <= 'x;
        funct7 <= 'x;
      end

      default: ;
    endcase
  end
endmodule
