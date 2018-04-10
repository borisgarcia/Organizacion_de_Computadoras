/* verilator lint_off UNDRIVEN */
module FontRom (
    input clk,
	input [11:0] addr,
	output reg [7:0] dout
    );

    reg[7:0] memory[0:4095];

    always @(posedge clk) begin
		dout <= memory[addr];
    end

`ifndef DIGITAL
    initial begin
        $readmemh("font_rom.mif", memory, 0, 4095);
    end
`endif

endmodule

