`default_nettype none

module tb_modulo();

logic[2:0] remainder;
logic reset = 0;
logic clock = 0;
logic input_bit = 0;
logic[7:0] input_value = 7

ModuloDetector dut(
    .input_bit(input_bit),
    .remainder(remainder),
    .reset(reset),
    .clock(clock)
);


initial begin    
    for(int x = 0; x < 255; x++) {
        input_value = x;
        
    }
end    

initial begin
    $dumpfile("db_tb_modulo.vcd");
    $dumpvars(1, tb_modulo);
    
end

endmodule