module AsyncROM//Test
#(
    parameter Bits = 8,
    parameter AddrBits = 4
)
(
  input [(AddrBits-1):0] addr,
  input en,
  output [(Bits -1):0] dout
);
  reg [(Bits-1):0] memory[0:((1 << AddrBits) - 1)];

  assign dout = en? memory[addr] : 'hz;
  
  initial begin
    $readmemh("code.mif", memory, 0, ((1 << AddrBits) - 1));
  end
endmodule 
 
