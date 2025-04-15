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
logic[7:0] next_value;

always_comb begin
    next_value = current_value << 1;
end

always_ff @( posedge clock ) begin
    if(en) begin
        if(catch_in) begin
            current_value <= parallel_in;
        end
        else begin
            current_value <= next_value;
        end
        output_bit <= current_value[7];
    end
end

endmodule