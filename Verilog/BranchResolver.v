module BranchResolver(
    input beq,
    input bne,
    input bgez,
    input bgtz,
    input blez,
    input bltz,
    input zero,
    input sign,
    output reg bt
);


always @ (beq or bne or bgez or bgtz or blez or bltz or zero or sign)
begin
    if(beq && zero)
        bt = 1'b1;
    
    else if(bne && ~zero)
        bt = 1'b1;
    
    else if(bgez && (~sign))
        bt = 1'b1;
    
    else if(bgtz && (~sign && ~zero))
        bt = 1'b1;
    
    else if(blez && (sign || zero))
        bt = 1'b1;

    else if(bltz && sign)
        bt = 1'b1;
    else
        bt = 1'b0;
end

endmodule
