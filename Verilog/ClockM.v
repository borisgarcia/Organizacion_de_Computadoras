module ClockM (
    input clk,  //! Clock input. On MimasV2 this is 100mhz
    output cclk, //! CPU clock 50Mhz
    output vclk, //! VGA clock 25mhz
    output reg iclk //! Instruction Memory clock
);

`ifdef SYNTHESIS
    /*
     * During synthesis we use the Digital Clock Manager
     * of the FPGA to generate a stable cpu clock signal 
     * and a VGA clock signal
     */
    // CPU clock is 50mhz
    DCM_SP #(.CLKFX_DIVIDE(4), .CLKFX_MULTIPLY(2), .CLKIN_PERIOD(10))
            cpu_dcm (
                .CLKIN(clk),
                .CLKFX(cclk),
                .CLKFB(1'b0),
                .PSEN(1'b0),
                .RST(1'b0)
            );

    // VGA clock is 25mhz
    DCM_SP #(.CLKFX_DIVIDE(8), .CLKFX_MULTIPLY(2), .CLKIN_PERIOD(10))
            vga_dcm (
                .CLKIN(clk),
                .CLKFX(vclk),
                .CLKFB(1'b0),
                .PSEN(1'b0),
                .RST(1'b0)
            );

`else
    assign cclk = clk;
    assign vclk = clk;
`endif

always @ (posedge cclk)
    iclk <= !iclk;

initial
    iclk = 0;

endmodule
