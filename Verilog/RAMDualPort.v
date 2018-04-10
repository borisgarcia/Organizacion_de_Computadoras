/*!
 * RAM 1 write port 1 read port.
 * @type ram
 * @size 256
 */
module RAMDualPort (
  input [7:0] A,
  input [31:0] D_in,
  input str,
  input C,
  input ld,
  output [31:0] D
);
  reg [31:0] memory[0:255];

  assign D = ld? memory[A] : 'hz;

  always @ (posedge C) begin
    if (str)
      memory[A] <= D_in;
  end

  initial begin
    $readmemh("data.hex", memory, 0, 255);
  end
endmodule 
