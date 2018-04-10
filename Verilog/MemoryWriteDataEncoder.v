module MemoryWriteDataEncoder(
    input[31:0] inD,
    input[1:0] ofs,
    input iwe,
    input[1:0] ds,
    output[31:0] oD,
    output[3:0] owe
);

reg[31:0] o_oD;
reg[3:0] o_owe;
assign oD = o_oD;
assign owe = o_owe;

always @ (iwe or ofs or ds or inD)
    begin
        if(iwe)
            begin
                if(ds == 2'd0)
                    begin 
                        o_oD = inD;
                        o_owe = 4'b1111;
                    end
                else if(ds == 2'd1 && (ofs == 2'd0 || ofs == 2'd1))
                    begin 
                        o_oD = {{inD[15:0]},{16{1'b0}}};
                        o_owe = 4'b0011;
                    end
                    
                else if(ds == 2'd1 && (ofs == 2'd2 || ofs == 2'd3))
                    begin 
                        o_oD = {{16{1'b0}},{inD[15:0]}};
                        o_owe = 4'b1100;
                    end
                
                else if(ds == 2'd2 && ofs == 2'd0)
                    begin 
                        o_oD = {{inD[7:0]},{24{1'h0}}};
                        o_owe = 4'b0001;
                    end
                    
                else if(ds == 2'd2 && ofs == 2'd1)
                    begin 
                        o_oD =  {{8{1'h0}},{inD[7:0]},{16{1'h0}}};
                        o_owe = 4'b0010;
                    end
                else if(ds == 2'd2 && ofs == 2'd2)
                    begin 
                        o_oD = {{16{1'h0}},{inD[7:0]},{8{1'h0}}};
                        o_owe = 4'b0100;
                    end
                    
                else if(ds == 2'd2 && ofs == 2'd3)
                    begin 
                        o_oD = {{24{1'h0}},{inD[7:0]}};
                        o_owe = 4'b1000;
                    end
                else
                    begin
                        o_oD = 32'dx;
                        o_owe = 4'dx;
                    end
            end
        else
            begin 
                o_oD = 32'd0;
                o_owe = 4'd0;
            end
    end

endmodule
