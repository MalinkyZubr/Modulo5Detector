`default_nettype none


module Decoder_3_8(
    input logic en,
    input logic[2:0] in,
    output logic[7:0] out
);

always_comb begin
    if(en) begin
        out = 8'b0;
        out[in] = 1'b1;
    end
    else begin
        out = 8'b000;
    end
end

endmodule