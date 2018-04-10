module SignExtender (
    input [15:0] in,
    input zE,
    output reg [31:0] out
);

    
always @(zE) begin
        if (zE) begin
            out = {16'b0, in}; 
        end
        else begin
            out = {{16{in[15]}}, in};  
        end
    end
endmodule

