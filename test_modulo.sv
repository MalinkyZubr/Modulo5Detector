`default_nettype none
`include "encoder_8_3.sv"
`include "decoder_3_8.sv"
`include "register_8_parallel_in.sv"


module tb_modulo();


logic[2:0] remainder;
logic[2:0] remainder2;
logic reset = 0;
logic clock = 0;
logic input_bit = 0;
logic input_bit_reg;
logic catch_in = 0;
logic en = 0;
logic en2 = 0;
logic[7:0] input_value = 0;

ModuloDetector dut(
    .input_bit(input_bit),
    .remainder(remainder),
    .en(en2),
    .reset(reset),
    .clock(clock)
);

task pulse_reset(input time duration = 10);
    reset <= 1;
    #duration;
    reset <= 0;
endtask

task pulse_catch(input time duration = 10);
    catch_in <= 1;
    #duration;
    catch_in <= 0;
endtask

task pulse_clock(input time duration = 10);
    clock <= 1;
    #duration;
    clock <= 0;
    #duration;
endtask

initial begin : TestModulo 
    $display("Beginning basic modulo tests\n");
    #10 en2 = 1;
    for(int x = 0; x < 256; x++) begin
        input_value = x;

        pulse_reset();

        for(int y = 0; y < 8; y++) begin
            input_bit = input_value[7 - y];
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