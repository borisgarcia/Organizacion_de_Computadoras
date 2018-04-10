module MemoryDecoder(
  input [31:0] vAd,
  input mW,
  input mR,
  output [12:0] pAd,
  output [2:0] mE,
  output [1:0] mB,
  output iAd
);

reg[12:0] o_pAd;
reg[2:0] o_mE;
reg[1:0] o_mB;
reg o_iAd;

assign pAd = o_pAd;
assign mE = o_mE;
assign mB = o_mB;
assign iAd = o_iAd;

always @ (vAd or mW or mR)
    begin
        if(mW || mR)
            begin 
                if(vAd >= 32'h10010000 && vAd < 32'h10011000) 
                    begin
                        o_pAd = vAd[12:0];
                        o_mE = 3'b001;
                        o_mB = 2'b00;
                        o_iAd = 1'b0;
                    end
                
                else if(vAd >= 32'h7FFFEFFC && vAd < 32'h7FFFFFFC) 
                    begin
                        o_pAd = vAd[12:0] - 13'hEFFC + 13'd4096;
                        o_mE = 3'b001;
                        o_mB = 2'b00;
                        o_iAd = 1'b0;
                        
                    end
                
                else if(vAd >= 32'hB800 && vAd <= 32'hCABF) 
                    begin
                        o_pAd = vAd[12:0] - 13'hB800;
                        o_mE = 3'b010;
                        o_mB = 2'b01;
                        o_iAd = 1'b0;
                        
                    end
                
                else if(vAd >= 32'hFFFF0000 && vAd <= 32'hFFFF000F) 
                    begin
                        o_pAd = vAd[12:0] - 13'h0;
                        o_mE = 3'b100;
                        o_mB = 2'b10;
                        o_iAd = 1'b0;
                    end
                
                else
                    begin
                        o_pAd = 13'dx;
                        o_mE = 3'dx;
                        o_mB = 2'dx;
                        o_iAd = 1'b1;
                    end 
            end 
            else
                begin
                    o_pAd = 13'dx;
                    o_mE = 3'dx;
                    o_mB = 2'dx;
                    o_iAd = 1'b0;
                end
    end


endmodule
 
