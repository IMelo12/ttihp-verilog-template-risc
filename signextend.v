module signextend #(parameter length, parameter WIDTH)
(
    input [WIDTH-1:0] a,
    output [length-1:0] b
);

assign b = {a,{length{1'b0}}};

endmodule