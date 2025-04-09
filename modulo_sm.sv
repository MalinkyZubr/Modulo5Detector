`default_nettype none


module ModuloDetector (
    input logic input_bit,
    input logic reset,
    input logic clock,
    output logic [2:0] remainder,
);

logic [7:0] next_state, internal_buffer;

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
    .out(next_state)
);

Encoder_8_3 high_in_encoder(
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
    .out(next_state)
);


always_ff @(posedge clock or reset) begin
    if(reset) begin
        remainder <= 1'b0;
    end
    else begin
        remainder <= next_state;
    end
end


endmodule