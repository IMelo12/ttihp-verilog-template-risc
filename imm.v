module imm;

reg [31:0] inst;
wire [31:0] out;


immediateGenerator imm(
	.instrcution(inst),
	.immediate(out)
);

initial begin
	inst = 32'b1000000000010111100111110110011;
	#10
	$display ("%b",out);
	$finish;
end

endmodule