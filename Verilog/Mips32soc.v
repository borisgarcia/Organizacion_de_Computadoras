/* verilator lint_off UNUSED */

module Mips32soc(
input clk,
input reset,
input [7:0] btns_state,
output err,
output invPC,
output hsync,
output invAddr,
output [2:0] red,
output [1:0] blue,
output invOp,
output [2:0] green,
output vsync,
output [2:0] mEn
);

/* Declarations (registers and wires) */
wire cclk;
wire iclk;
wire vclk;
wire [3:0] aluop;
wire [1:0] regdst;
wire bgtz;
wire jr;
wire zE;
wire [1:0] m2r;
wire jmp;
wire memr;
wire [1:0] asrc;
wire beq;
wire mw;
wire blez;
wire mbe;
wire jal;
wire bgez;
wire regw;
wire bne;
wire rd1sel;
wire [1:0] mds;
wire bltz;
wire [31:0] inst;
wire [12:0] pcdecoder0_PPC;
wire [12:0] memoryDecoder0_pAd;
wire [1:0] mB;
wire [2:0] mE;
wire [31:0] alu_r;
wire alu_z;
wire [31:0] rd2;
wire [31:0] rd1;
reg [4:0] mux0out;
wire [31:0] oD_RD;
wire [31:0] rd_DM;
wire [31:0] oD;
wire [3:0] owe;
wire [31:0] rd_VGA;
wire [31:0] io_od;
wire [31:0] msC;
reg [31:0] inD_DD;
reg [31:0] wd;
reg [31:0] mux1out;
wire [31:0] sE_OUT;
reg [31:0] mux2out;
reg mux3out;
wire im_en;
wire or0out;
wire [1:0] splitter0Out;
wire br_bt;
reg [31:0] pc_out;
reg [31:0] pc;
wire [31:0] pc_4;
wire rst;
wire [7:0] buttons_state;

`ifdef SYNTHESIS
assign rst = ~reset;
assign buttons_state = ~btns_state;
`else
assign rst = reset;
assign buttons_state = btns_state;
`endif

/* Assign expressions */
assign err = invPC | invOp | invAddr;
assign or0out = jmp | jal;
assign pc_4 = pc + 32'h4;
assign im_en = reset | mux3out;
assign splitter0Out = {jr, or0out};
assign mEn = mE;

/* Always blocks */
always @ (posedge iclk) begin
  pc <= pc_out;
end
always @ (*) begin
  case (err)
    1'h0: mux3out = 1'h1;
    1'h1: mux3out = 1'h0;
    default: mux3out = 1'hx;
  endcase
end
always @ (*) begin
  case (mB)
    2'h0: inD_DD = rd_DM;
    2'h1: inD_DD = rd_VGA;
    2'h2: inD_DD = io_od;
    2'h3: inD_DD = 32'h0;
    default: inD_DD = 32'hx;
  endcase
end
always @ (*) begin
  case (rd1sel)
    1'h0: mux1out = rd1;
    1'h1: mux1out = rd2;
    default: mux1out = 32'hx;
  endcase
end
always @ (*) begin
  case (reset)
    1'h0: begin
      case (splitter0Out)
        2'h0: begin
          case (br_bt)
            1'h0: pc_out = pc_4;
            1'h1: pc_out = pc_4 + {sE_OUT[29:0], 2'h0};
            default: pc_out = 32'hx;
          endcase
        end
        2'h1: pc_out = {pc_4[31:28], {inst[25:0], 2'h0}};
        2'h2: pc_out = rd1;
        2'h3: pc_out = 32'h0;
        default: pc_out = 32'hx;
      endcase
    end
    1'h1: pc_out = 32'h400000;
    default: pc_out = 32'hx;
  endcase
end
always @ (*) begin
  case (m2r)
    2'h0: wd = alu_r;
    2'h1: wd = oD_RD;
    2'h2: wd = {inst[15:0], 16'h0};
    2'h3: wd = pc_4;
    default: wd = 32'hx;
  endcase
end
always @ (*) begin
  case (asrc)
    2'h0: mux2out = rd2;
    2'h1: mux2out = sE_OUT;
    2'h2: mux2out = rd1;
    2'h3: mux2out = {27'h0, inst[10:6]};
    default: mux2out = 32'hx;
  endcase
end
always @ (*) begin
  case (regdst)
    2'h0: mux0out = inst[20:16];
    2'h1: mux0out = inst[15:11];
    2'h2: mux0out = 5'h1f;
    2'h3: mux0out = 5'h0;
    default: mux0out = 5'hx;
  endcase
end

/* Instances and always blocks */
/* ClockM
 */
ClockM clockM0(
  .clk(clk),
  .cclk(cclk),
  .iclk(iclk),
  .vclk(vclk)
);
/* PCDecoder
 */
PCDecoder pcdecoder0(
  .VPC(pc_out),
  .PPC(pcdecoder0_PPC),
  .IPC(invPC)
);
/* MemoryWriteDataEncoder
 */
MemoryWriteDataEncoder memoryWriteDataEncoder0(
  .iwe(mw),
  .ofs(memoryDecoder0_pAd[1:0]),
  .inD(rd2),
  .ds(mds),
  .oD(oD),
  .owe(owe)
);
/* DataMem
 * AddrBits=11
 * lastDataFile=/home/boris/Desktop/Orga/Proyecto/MIPS32SOC-Part4-tests/vga_kpad-build/vga_kpad_data.hex
 */
DataMem dataMem0(
  .clk(cclk),
  .en(mE[0]),
  .addr(memoryDecoder0_pAd[12:2]),
  .wd(oD),
  .we(owe),
  .rd(rd_DM)
);
/* VGATextCard
 * AddrBits=12
 * lastDataFile=/home/boris/Desktop/Orga/Proyecto/mips32soc_singlecycle/hexfiles/font_rom.hex
 */
VGATextCard vgatextCard0(
  .rst(reset),
  .clk(cclk),
  .en(mE[1]),
  .vclk(vclk),
  .addr(memoryDecoder0_pAd[12:2]),
  .wd(oD),
  .we(owe),
  .b(blue),
  .rd(rd_VGA),
  .r(red),
  .g(green),
  .hs(hsync),
  .vs(vsync)
);
/* MsCounter
 */
MsCounter msCounter0(
  .rst(reset),
  .clk(cclk),
  .out(msC)
);
/* IO
 */
IO io0(
  .ms(msC),
  .en(mE[2]),
  .addr(memoryDecoder0_pAd[12:2]),
  .btn(buttons_state),
  .out(io_od)
);
/* MemoryReadDataDecoder
 */
MemoryReadDataDecoder memoryReadDataDecoder0(
  .bitX(mbe),
  .ofs(memoryDecoder0_pAd[1:0]),
  .inD(inD_DD),
  .ds(mds),
  .oD(oD_RD)
);
/* RegFile
 * AddrBits=5
 * lastDataFile=/home/renanz/Desktop/OrgaCompus/Proyecto/MIPS32SOC/MIPS32SOC-Parte1-Tests/hex/RegFile.hex
 */
RegFile regFile0(
  .ra2(inst[20:16]),
  .c(iclk),
  .ra1(inst[25:21]),
  .wa(mux0out),
  .wd(wd),
  .we(regw),
  .rd2(rd2),
  .rd1(rd1)
);
/* SignExtender
 */
SignExtender signExtender0(
  .in(inst[15:0]),
  .zE(zE),
  .out(sE_OUT)
);
/* Alu
 */
Alu alu0(
  .op(aluop),
  .a(mux1out),
  .b(mux2out),
  .r(alu_r),
  .z(alu_z)
);
/* MemoryDecoder
 */
MemoryDecoder memoryDecoder0(
  .mR(memr),
  .vAd(alu_r),
  .mW(mw),
  .pAd(memoryDecoder0_pAd),
  .mB(mB),
  .mE(mE),
  .iAd(invAddr)
);
/* InstMem
 * AddrBits=11
 * lastDataFile=/home/boris/Desktop/Orga/Proyecto/MIPS32SOC-Part4-tests/vga_kpad-build/vga_kpad_code.hex
 * autoReload=true
 */
InstMem instMem0(
  .clk(iclk),
  .en(im_en),
  .addr(pcdecoder0_PPC[12:2]),
  .dout(inst)
);
/* ControlUnit
 */
ControlUnit controlUnit0(
  .op(inst[31:26]),
  .fn(inst[5:0]),
  .bgez_bltz(inst[20:16]),
  .aop(aluop),
  .regd(regdst),
  .bgtz(bgtz),
  .iO(invOp),
  .jr(jr),
  .zE(zE),
  .m2r(m2r),
  .jmp(jmp),
  .memr(memr),
  .asrc(asrc),
  .beq(beq),
  .memw(mw),
  .blez(blez),
  .mBE(mbe),
  .jal(jal),
  .bgez(bgez),
  .regw(regw),
  .bne(bne),
  .rd1sel(rd1sel),
  .mDS(mds),
  .bltz(bltz)
);
/* BranchResolver
 */
BranchResolver branchResolver0(
  .zero(alu_z),
  .blez(blez),
  .bgez(bgez),
  .bgtz(bgtz),
  .sign(alu_r[31]),
  .bne(bne),
  .bltz(bltz),
  .beq(beq),
  .bt(br_bt)
);

endmodule
