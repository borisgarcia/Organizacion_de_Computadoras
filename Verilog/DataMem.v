/*!
 * MIPS32SOC data memory (2048 words)
 * @type ram
 * @size 2048
 * @data_bits 32
 */
 /* verilator lint_off UNUSED */
module DataMem(
	input clk, //! Clock input
	input en, //! Enable
	input [3:0] we, //! Per byte write enable
	input [10:0] addr, //! Address
	input [31:0] wd, //! Write data
	output reg [31:0] rd //! Read data
);

	reg [31:0] memory[0:2047];
	always @(posedge clk)
	begin
		if (en) begin
			if (we[3]) memory[addr][7:0] <= wd[7:0];
			if (we[2]) memory[addr][15:8] <= wd[15:8];
			if (we[1]) memory[addr][23:16] <= wd[23:16];
			if (we[0]) memory[addr][31:24] <= wd[31:24];

			rd <= memory[addr];
		end
	end

`ifndef DIGITAL
	initial begin
		$readmemh("data.mif", memory, 0, 2047);
	end
`endif	
endmodule
