/*!
 * MIPS32SOC instruction memory (2048 words)
 * @type ram
 * @size 2048
 * @data_bits 32
 */
 /* verilator lint_off UNUSED */
 /* verilator lint_off UNDRIVEN */
module InstMem(
	input clk, //! Clock
	input en, //! Enable
	input [10:0] addr, //! Address
	output reg [31:0] dout //! Data out
	);

	reg [31:0] memory[0:2047];

	always @ (posedge clk)
	begin
		if (en)
			dout <= memory[addr];
	end

//`ifndef DIGITAL
	initial begin
		$readmemh("code.mif", memory, 0, 2047);
	end
//`endif	
endmodule
