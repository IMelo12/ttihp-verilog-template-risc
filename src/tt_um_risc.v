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

assign uio_oe = 8'h00;              // Enable all IO outputs
wire [7:0] risc_output;

assign uio_out = risc_output;       // Drive RISC output to uio_out
assign uo_out = risc_output;        // Also map it to uo_out

wire input_we = ui_in[0];
wire [6:0] input_address = ui_in[7:1];
wire [7:0] input_data = uio_in;

(* dont_touch = "true" *) risc cpu(
    .clk(clk),
    .rst_n(rst_n),
    .inst_address(input_address),
    .inst_data(input_data),
    .inst_we(input_we),
    .memory_out(risc_output)
);

wire _unused = &{ena, 1'b0};

    always @(posedge clk or negedge rst_n) begin
        if(rst_n) begin
            uo_out <= 1'b0;
        end
        else if(ena) begin
            uo_out <= 1'b1;
        end
    end
    
        

endmodule
