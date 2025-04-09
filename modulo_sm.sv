`default_nettype none


module ModuloDetector (
    input logic input_bit,
    input logic reset,
    input logic clock,
    input logic en,
    output logic [2:0] remainder
);

logic [7:0] internal_buffer;
logic [2:0] next_state_high, next_state_low;

Decoder_3_8 state_decoder(
    .en(1'b1),
    .in(remainder),
    .out(internal_buffer)
);

Encoder_8_3 high_in_encoder(
    .en(input_bit),
    .in({
            1'b0,
            1'b0,
            1'b0,
            internal_buffer[4],
            internal_buffer[1],
            internal_buffer[3],
            internal_buffer[0],
            internal_buffer[2]
        }),
    .out(next_state_high)
);

Encoder_8_3 low_in_encoder(
    .en(~input_bit),
    .in({
            1'b0,
            1'b0,
            1'b0,
            internal_buffer[2],
            internal_buffer[4],
            internal_buffer[1],
            internal_buffer[3],
            internal_buffer[0]
        }),
    .out(next_state_low)
);

always_ff @(posedge clock or posedge reset) begin
    if(en) begin
        if(reset) begin
            remainder <= 3'b000;
        end
        else begin
            if(input_bit == 1'b1) begin
                remainder <= next_state_high;
            end
            else begin
                remainder <= next_state_low;
            end
        end
    end
end


endmodule