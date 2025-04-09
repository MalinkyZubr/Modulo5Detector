`default_nettype none


// shift the msb out first
module Register_8_Parallel_In(
    input logic[7:0] parallel_in,
    input logic catch_in,
    input logic en,
    input logic clock,
    output logic output_bit
);

logic[7:0] current_value;

always_ff @( posedge clock ) begin
    if(en) begin
        output_bit <= current_value[7];
        if(catch_in) begin
            current_value <= parallel_in;
            //output_bit <= current_value[7];
        end
        else begin
            current_value <= current_value << 1;
            //output_bit <= current_value[7];
        end
    end
end

endmodule