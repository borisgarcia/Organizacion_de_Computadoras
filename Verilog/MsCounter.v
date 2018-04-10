/* verilator lint_off UNUSED */
/* verilator lint_off UNDRIVEN */
/*!
 * Milliseconds counter component.
 * @class MyCounter
 * @create msCounter_create
 * @eval msCounter_eval
 */
module MsCounter(
    input clk,
    input rst,
    output [31:0] out
);
    reg [15:0] cycle_count;		// CPU cycle counter
    reg [31:0] ms_count;	    // Millisecond counter

    assign out = ms_count;

`ifdef SYNTHESIS
    always @ (posedge clk) begin
        if (rst) begin
            cycle_count <= 16'h0;
            ms_count <= 32'h0;
        end
        else begin
            cycle_count <= cycle_count + 1;
            if (cycle_count == 16'd20000)
            begin
                ms_count <= ms_count + 1;
                cycle_count <= 'h0;
            end
        end
    end
`endif
endmodule
