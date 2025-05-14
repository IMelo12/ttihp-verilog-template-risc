module forwarding
(
    input [4:0]rs1,
    input [4:0]rs2,
    input [4:0]rdwb,
    input [4:0]rdmem,
    input regwrite_wb, //MEM/WB.RegWrite
    input regwrite_mem, // EX/MEM.RegWrite
    input bubble,
    output [1:0]A,
    output [1:0]B
);

always @(*) 
    begin
        if( (rdmem == rs1) && (regwrite_mem != 0) && (rdmem !=0) ) A = 2'b10;
        else
            begin
                if( (rdwb == rs1) && (regwrite_wb !=0) && (rdwb !=0) && ~((rdmem == rs1) && (regwrite_mem != 0) && (rdmem != 0)) ) A = 2'b01; 
                else A = 2'b00;
            end
        if( (rdmem == rs2) && (regwrite_mem != 0) && (rdmem != 0) ) B = 2'b10;
        else
            begin
                if( (rdwb == rs2) && (regwrite_wb != 0) && (rdwb != 0) && ~((regwrite_mem != 0 && rdmem != 0) && (rdmem == rs2)) ) B = 2'b01;
                else B = 2'b00;
            end
    end


endmodule