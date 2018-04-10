module Alu(
    input [31:0] a,
    input [31:0] b,
    input [3:0] op,
    output reg [31:0] r,
    output reg z
    );

    always @ (op or a or b)
    begin
        case (op)
            4'b0000: r = a + b; 
            4'b0001: r = a - b;
            4'b0010: r = a * b;
            4'b0011: r = a | b;
            4'b0100: r = a & b;
            4'b0101: r = a ^ b;
            4'b0110: r = ~(a & b);
            4'b0111: r = {31'd0,$signed(a) < $signed(b)};
            4'b1000: r = {31'd0,$unsigned(a) < $unsigned(b)};
            4'b1001: r = a<<b;
            4'b1010: r = a>>b;
            4'b1011: r = $signed(a)>>>$signed(b);
            default:
                    r = 32'hX;
        endcase
        z = (r == 0);
    end

endmodule
