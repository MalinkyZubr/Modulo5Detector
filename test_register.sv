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
logic[7:0] input_value = 0;

task pulse_reset(input time duration = 10);
    reset <= 1;
    #duration;
    reset <= 0;
endtask

task pulse_clock(input time duration = 10);
    clock <= 1;
    #duration;
    clock <= 0;
    #duration;
endtask

task pulse_catch(input time duration = 10);
    catch_in <= 1;
    pulse_clock();
    #duration;
    catch_in <= 0;
endtask

Register_8_Parallel_In dut2(
    .parallel_in(input_value),
    .catch_in(catch_in),
    .en(en),
    .clock(clock),
    .output_bit(input_bit)
);

ModuloDetector dut3(
    .input_bit(input_bit),
    .remainder(remainder),
    .en(en2),
    .reset(reset),
    .clock(clock)
);

initial begin : TestRegister
    $display("register modulo tests\n");
    en = 1;
    #10

    pulse_reset();

    for(int x = 0; x < 256; x++) begin
        input_value = x;

        pulse_reset();

        #10 en2 = 0;
        pulse_catch();
        #10 en2 = 1;
        pulse_clock();

        for(int y = 0; y < 8; y++) begin
            pulse_clock();
        end
        
        if(x % 5 != remainder) begin
            $display("Expected: %d, got %d", x % 5, remainder);
        end
    end
end

initial begin
    $dumpfile("db_tb_modulo.vcd");
    $dumpvars(1, tb_modulo);
    
end

endmodule
