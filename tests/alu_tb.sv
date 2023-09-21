`timescale 10ns/1ns

module TB();
  // ADD INPUTS

  /* --------------------------------- R TYPE -------------------------------- */
  r_type ALUR(.funct7(f7), .rs2(b), .rs1(a), .funct3(f3), .rd(o), .opcode(op)); 

  initial begin
    op = 7'b0110011 // Will not change
    
    f3 = 3'h0; f7 = 6'h00; // ADD
    a = 4; b = 6;
    out1 = (o == 10);
    a = -2; b = -4;
    out2 = (o == -6);
    $display("ADD: ", out1, " ", out2 );
    
    f3 = 3'h0; f7 = 6'h20; // SUB
    a = 4; b = 6;
    out1 = (o == -2);
    a = -2; b = -4;
    out2 = (o == 2);
    $display("SUB: ", out1, " ", out2 );
    
    f3 = 3'h0; f7 = 6'h01; // MUL
    a = 4; b = 6;
    out1 = (o == 24);
    a = -2; b = -4;
    out2 = (o == 8);
    $display("MUL: ", out1, " ", out2 );
    
    f3 = 3'h1; f7 = 6'h00; // SLL
    a = 4; b = 2;
    out1 = (o == 16);
    a = -2; b = 3;
    out2 = (o == -16);
    $display("SLL: ", out1, " ", out2 );
    
    f3 = 3'h1; f7 = 6'h01; // MULH
    a = 4; b = 6;
    out1 = (o == 0); // Since MULH only takes the upper 32 bits of the result
    a = -2; b = -4;
    out2 = (o == 0);
    $display("MULH: ", out1, " ", out2 );
  end

  /* Edit to make it work for I and other types
  r_type ALUR(.funct7(funct7), .rs2(rs2), .rs1(rs1), .rd(rd), .opcode(opcode)); 

  initial begin
   // Add
  end
  */
endmodule
