`include "opcodes.vh" 

module ControlUnit(
    input [5:0] op, //! Opcode
    input [5:0] fn, //! Function
    input [4:0] bgez_bltz, // bgez or bltz
    output reg jmp, //! Jump signal
    output reg beq, //! BEQ signal
    output reg bne, //! BNE signal
    output reg memr, //! Memory Read
    output reg [1:0] m2r, //! Register File write data selection
    output reg memw, //! Memory Write
    output reg [1:0] asrc, //! ALU source
    output reg rd1sel, //rd1 selector
    output reg regw, //! Register Write
    output reg [1:0] regd, //! Register Destination Address selection
    output reg [3:0] aop, //! ALU operation
    output reg zE, //Sign or Zero extended
    output reg iO, //Invalid Opcode
    output reg [1:0] mDS, //Mem Data Size
    output reg mBE, //Mem Bit Extension
    output reg bgez,
    output reg bgtz,
    output reg blez,
    output reg bltz,
    output reg jr, 
    output reg jal
);

always @ (op or fn)
begin
    jmp = 1'b0;
    beq = 1'b0;
    bne = 1'b0;
    memr = 1'b0;
    m2r = 2'b0;
    memw = 1'b0;
    asrc = 2'b0;
    regw = 1'b0;
    regd = 2'b00;
    aop = 4'b0000;
    zE = 1'b0;
    iO = 1'b1;
    mBE = 1'b0;
    mDS = 2'dx;
    bgez = 1'b0;
    bgtz = 1'b0;
    blez = 1'b0;
    bltz = 1'b0;
    jr = 1'b0;
    jal = 1'b0;
    rd1sel = 1'd0;
    

    case (op)
        6'h0:
            case (fn)
            `ADD: 
                begin
                    regw = 1'b1;
                    asrc = 2'b00;
                    regd = 2'b01;
                    m2r = 2'b0;
                    aop = 4'b0000;
                    iO = 1'b0;
                end
            `ADDU: 
                begin
                    regw = 1'b1;
                    asrc = 2'b00;
                    regd = 2'b01;
                    m2r = 2'b0;
                    aop = 4'b0000;
                    iO = 1'b0;
                end
            `SUB: 
                begin
                    regw = 1'b1;
                    asrc = 2'b00;
                    regd = 2'b01;
                    m2r = 2'b0;
                    aop = 4'b0001;
                    iO = 1'b0;
                end
            `SUBU: 
            begin
                regw = 1'b1;
                asrc = 2'b00;
                regd = 2'b01;
                m2r = 2'b0;
                aop = 4'b0001;
                iO = 1'b0;
            end
            `AND: 
                begin
                    regw = 1'b1;
                    asrc = 2'b00;
                    regd = 2'b01;
                    m2r = 2'b0;
                    aop = 4'b0100;
                    iO = 1'b0;
                end
            `OR: 
                begin
                    regw = 1'b1;
                    asrc = 2'b00;
                    regd = 2'b01;
                    m2r = 2'b0;
                    aop = 4'b0011;
                    iO = 1'b0;
                end
            `SLT: 
                begin
                    regw = 1'b1;
                    asrc = 2'b00;
                    regd = 2'b01;
                    m2r = 2'b0;
                    aop = 4'b0111;
                    iO = 1'b0;
                end
            
            `SLL: 
                begin
                    regw = 1'b1;
                    aop = 4'b1001;
                    asrc = 2'd3;
                    rd1sel = 1'b1;
                    regd = 2'b01;
                    iO = 1'b0;
                end
            `SLLV: 
                begin
                    regw = 1'b1;
                    aop = 4'b1001;
                    asrc = 2'd2;
                    rd1sel = 1'b1;
                    regd = 2'b01;
                    iO = 1'b0;
                end
            `SRL: 
                begin
                    regw = 1'b1;
                    aop = 4'b1010;
                    asrc = 2'd3;
                    rd1sel = 1'b1;
                    regd = 2'b01;
                    iO = 1'b0;
                end
            `SRLV: 
                begin
                    regw = 1'b1;
                    aop = 4'b1010;
                    asrc = 2'd2;
                    rd1sel = 1'b1;
                    regd = 2'b01;
                    iO = 1'b0;
                end
            `SRA: 
                begin
                    regd = 2'b01;
                    regw = 1'b1;
                    asrc = 2'b11;
                    aop = 4'b1011;
                    rd1sel = 1'b1;
                    iO = 1'b0;
                end
            `SRAV: 
                begin
                    regd = 2'b01;
                    regw = 1'b1;
                    asrc = 2'd2;
                    aop = 4'b1011;
                    rd1sel = 1'b1   ;
                    iO = 1'b0;
                end
            `XOR: 
                begin
                    regw = 1'b1;
                    asrc = 2'b00;
                    regd = 2'b01;
                    m2r = 2'b0;
                    aop = 4'b0101;
                    iO = 1'b0;
                end
            `SLTU: 
                begin
                    regw = 1'b1;
                    asrc = 2'b00;
                    regd = 2'b01;
                    m2r = 2'b0;
                    aop = 4'b1000;
                    iO = 1'b0;
                end
            `JR:
                begin
                    jr = 1'b1;
                    iO = 1'b0;
                end
            
            default: begin
            end
            endcase
        
        6'h1:
            if(bgez_bltz == 5'b00001)
            begin 
                aop = 4'b0001;
                bgez = 1'b1;
                iO = 1'b0;
            end
            else if(bgez_bltz == 5'b00000)
            begin
                aop = 4'b0001;
                bltz = 1'b1;
                iO = 1'b0;
            end
        
        `JAL:
            begin
                regw = 1'b1;
                jal = 1'b1;
                regd = 2'b10;
                m2r = 2'b11;
                iO = 1'b0;
            end
        `XORI:
            begin
                regw = 1'b1;
                asrc = 2'b01;
                regd = 2'b00;
                m2r = 2'b00;
                aop = 4'b0101;
                zE = 1'b1;
                iO = 1'b0;
            end
        
        `SLTI:
            begin
                regw = 1'b1;
                asrc = 2'b01;
                regd = 2'b00;
                m2r = 2'b0;
                aop = 4'b0111;
                zE = 1'b1;
                iO = 1'b0;
            end
        
        `SLTIU:
            begin
                regw = 1'b1;
                asrc = 2'b01;
                regd = 2'b00;
                m2r = 2'b0;
                aop = 4'b1000;
                zE = 1'b1;
                iO = 1'b0;
            end
        
        `ADDI: 
            begin
                regw = 1'b1;
                asrc = 2'b01;
                regd = 2'b00;
                m2r = 2'b0;
                aop = 4'b0000;
                zE = 1'b0;
                iO = 1'b0;
                end
        `ADDIU: 
            begin
                regw = 1'b1;
                asrc = 2'b01;
                regd = 2'b00;
                m2r = 2'b0;
                aop = 4'b0000;
                iO = 1'b0;
            end
        `ORI: 
            begin
                regw = 1'b1;
                asrc = 2'b01;
                regd = 2'b00;
                m2r = 2'b00;
                aop = 4'b0011;
                zE = 1'b1;
                iO = 1'b0;
            end
        
        `ANDI: 
            begin
                regw = 1'b1;
                asrc = 2'b01;
                regd = 2'b00;
                m2r = 2'b00;
                aop = 4'b0100;
                zE = 1'b1;
                iO = 1'b0;
            end
        `LW:
            begin
                asrc = 2'b01;
                regd = 2'b00;
                regw = 1'b1;
                memr = 1'b1;
                m2r = 2'b1;
                aop = 4'b0000;
                iO = 1'b0;
                mDS = 2'b0;
            end
        
        `LUI:
            begin
                regw = 1'b1;
                asrc = 2'b01;
                regd = 2'b00;
                m2r = 2'b10;
                zE = 1'b1;
                iO = 1'b0;
            end
        `SW:
            begin
                asrc = 2'b01;
                regd = 2'b00;
                memw = 'b1;
                aop = 4'b0000;
                iO = 1'b0;
                mDS = 2'b0;
            end
        `JUMP:
            begin
              jmp = 1'b1;
              iO = 1'b0;
            end
            
         `LB:
            begin
                asrc = 2'b01;
                regd = 2'b00;
                regw = 1'b1;
                memr = 1'b1;
                m2r = 2'b1;
                aop = 4'b0000;
                iO = 1'b0;
                mDS = 2'b10;
            end
        `LBU:
            begin
                asrc = 2'b01;
                regd = 2'b00;
                regw = 1'b1;
                memr = 1'b1;
                m2r = 2'b1;
                aop = 4'b0000;
                iO = 1'b0;
                mDS = 2'b10;
                mBE = 1'b1;
            end
        `SB:
            begin
                asrc = 2'b01;
                regd = 2'b00;
                memw = 1'b1;
                aop = 4'b0000;
                iO = 1'b0;
                mDS = 2'd2;
            end
        `LH:
            begin
                asrc = 2'b01;
                regd = 2'b00;
                regw = 1'b1;
                memr = 1'b1;
                m2r = 2'b1;
                aop = 4'b0000;
                iO = 1'b0;
                mDS = 2'b1;
            end
        `LHU:
            begin
                asrc = 2'b01;
                regd = 2'b00;
                regw = 1'b1;
                memr = 1'b1;
                m2r = 2'b1;
                aop = 4'b0000;
                iO = 1'b0;
                mDS = 2'b1;
                mBE = 1'b1;
            end
        `SH:
            begin
                asrc = 2'b01;
                regd = 2'b00;
                memw = 1'b1;
                aop = 4'b0000;
                iO = 1'b0;
                mDS = 2'b1;
            end
        
        
        `BEQ:
            begin
              beq = 1'b1;
              aop = 4'b0001;
              iO = 1'b0;
            end
        `BNE:
            begin
                bne = 1'b1;
                aop = 4'b0001;
                iO = 1'b0;
            end
        
        `BGTZ:
            begin
                aop = 4'b0001;
                bgtz = 1'b1;
                iO = 1'b0;
            end
            
        `BLEZ:
            begin
                aop = 4'b0001;
                blez = 1'b1;
                iO = 1'b0;
            end


        default: begin
        end
    endcase
end

endmodule

