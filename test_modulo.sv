`default_nettype none
`include "encoder_8_3.sv"
`include "decoder_3_8.sv"
`include "register_8_parallel_in.sv"

module tb_modulo();

logic[2:0] remainder;
logic reset = 0;
logic clock = 0;
logic input_bit;
logic catch_in = 0;
logic en = 0;
logic en2 = 0;
logic[7:0] input_value = 127;

ModuloDetector dut(
    .input_bit(input_bit),
    .remainder(remainder),
    .en(en2),
    .reset(reset),
    .clock(clock)
);

Register_8_Parallel_In dut2(
    .parallel_in(input_value),
    .catch_in(catch_in),
    .en(en),
    .clock(clock),
    .output_bit(input_bit)
);


initial begin    
    #10 en = 1;
    //for(int x = 0; x < 255; x++) begin
        #10 catch_in = 1;
        #10 clock = 1;
        #10 clock = 0;
        #10 catch_in = 0;
        #10 reset = 1;
        #10 reset = 0;

        #10 clock = 1;
        #10 clock = 0;
        #10 en2 = 1;
        
        for(int x = 0; x < 8; x++) begin 
            #10 clock = 1;
            #10 clock = 0;
            $display ("\n:%0d -> %0d", input_bit, remainder);
        end

        $display ("\n===For the value = %0d, %0d, expected %0d===\n", input_value, remainder, input_value % 5);
    //end
end    

initial begin
    $dumpfile("db_tb_modulo.vcd");
    $dumpvars(1, tb_modulo);
    
end

endmodule