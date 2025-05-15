module tt_um_risc(
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // will go high when the design is enabled
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);


wire program_we;
wire [31:0] program_data;
wire [31:0] program_address;
wire [31:0] program_data_out;
reg [7:0] data_out;

wire instruction_we = ui_in[0];
wire [6:0] instruction_address = ui_in[7:1];
wire [7:0] instruciton_data = uio_in[7:0];
wire [31:0] instruciton_data_out;

assign uo_out[0] = data_out[0];
assign uo_out[1] = data_out[1];
assign uo_out[2] = data_out[2];
assign uo_out[3] = data_out[3];
assign uo_out[4] = data_out[4];
assign uo_out[5] = data_out[5];
assign uo_out[6] = data_out[6];
assign uo_out[7] = data_out[7];

//unused 
assign uio_out = 0;
assign uio_oe  = 0;

    wire _unused = &{ena, 1'b1};

risc cpu(
    .clk(clk),
    .rst_n(rst_n),
    .INSTRUCTION_MEM_OUT(instruciton_data_out),
    .RAM_OUT(program_data_out),
    .INSTRUCTION_MEM_IN(instruciton_data),
    .RAM_IN_DATA(program_data),
    .RAM_IN_ADDRESS(program_address),
    .RAM_IN_WRITE(program_we)
);


    RAM #(.DEPTH(7), .WIDTH(8)) instruction_mem(
    .clk(clk),
    .write_enable(instruction_we),
    .data(instruciton_data),
    .address(instruction_address),
    .data_out(instruciton_data_out)
);


    RAM #(.DEPTH(32), . WIDTH(32)) program_memory( //fix all of this
    .clk(clk),
    .write_enable(program_we),
    .data(program_data),
    .address(program_address),
    .data_out(program_data_out)
);

reg [31:0] temp;
reg [5:0] index_bot = 0;

always @(posedge clk) begin
    if(!program_we)
    begin
        temp <= program_data_out;
        data_out[index_bot +: 8] <= temp[index_bot +: 8];
        index_bot <= index_bot + 8;
        if(index_bot == 24) begin
            index_bot <= 0;
        end
    end
end

// we need to but the program data in temp reg
// on every clk cycle -> send 8 bits to data_out


endmodule
