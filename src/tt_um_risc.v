`default_nettype none

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

assign uio_oe = 8'h00;

wire input_we = ui_in[0];
wire [6:0] input_address = ui_in[7:1];
wire [7:0] input_data = uio_in;

(* dont_touch = "true" *) risc cpu(
    .clk(clk),
    .rst_n(rst_n),
    .inst_address(input_address),
    .inst_data(input_data),
    .ints_we(input_we),
    .memory_out(uo_out)
);


wire _unused = &{ena, 1'b0};

endmodule
