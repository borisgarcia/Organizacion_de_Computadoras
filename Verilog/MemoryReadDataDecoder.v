module MemoryReadDataDecoder(
    input[31:0] inD,
    input[1:0] ofs,
    input bitX,
    input[1:0] ds,
    output[31:0] oD    
);

reg[31:0] o_oD;
assign oD = o_oD;

always @ (inD or bitX or ofs or ds)
    begin
        if(ds == 2'd0)
                o_oD = inD;
        
        else if(ds == 2'd1 && (ofs == 2'd0 || ofs == 2'd1))
            begin 
                if(bitX)
                    o_oD = {16'b0,inD[31:16]};
                else
                    o_oD = {{16{inD[31]}},inD[31:16]};  
            end
            
        else if(ds == 2'd1 && (ofs == 2'd2 || ofs == 2'd3))
            begin
                if(bitX)
                    o_oD = {16'b0,inD[15:0]};
                else
                    o_oD = {{16{inD[15]}},inD[15:0]};  
            end
        
        
        else if(ds == 2'd2 && ofs == 2'd0)
            begin
                if(bitX)
                    o_oD = {24'b0,inD[31:24]};
                else
                    o_oD = {{24{inD[31]}},inD[31:24]};  
            end
            
        else if(ds == 2'd2 && ofs == 2'd1) 
            begin
                if(bitX)
                    o_oD = {24'b0,inD[23:16]};
                else
                    o_oD = {{24{inD[23]}},inD[23:16]};  
            end
            
        else if(ds == 2'd2 && ofs == 2'd2)
            begin
                if(bitX)
                    o_oD = {24'b0,inD[15:8]};
                else
                    o_oD = {{24{inD[15]}},inD[15:8]};  
            end
            
        else if(ds == 2'd2 && ofs == 2'd3)
            begin
                if(bitX)
                    o_oD = {24'b0,inD[7:0]};
                else
                    o_oD = {{24{inD[7]}},inD[7:0]};  
            end
        else
            o_oD = 32'dx;
    end

endmodule
