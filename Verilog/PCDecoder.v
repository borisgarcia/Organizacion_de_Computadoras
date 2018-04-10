/* verilator lint_off UNSIGNED */

module PCDecoder(
  input [31:0] VPC,
  output [12:0] PPC,
  output IPC
);

reg[12:0] o_ppc;
reg o_ipc;
assign PPC = o_ppc;
assign IPC = o_ipc;

always @ (VPC)
    begin
        if(VPC >= 32'h000000 && VPC <= 32'h401000) 
            begin
                o_ppc = VPC[12:0];
                o_ipc = 1'b0;
                
            end
        else
            begin
                o_ppc = 13'dx;
                o_ipc = 1'b1;
            end     
    end
endmodule
