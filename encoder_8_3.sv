`default_nettype none


module Encoder_8_3(
    input logic en,
    input logic[7:0] in,
    output logic [2:0] out
);

always_comb begin
    if(en) begin
        case(in) 
            128: out = 3'b111;
            64: out = 3'b110;
            32: out = 3'b101;
            16: out = 3'b100;
            8: out = 3'b011;
            4: out = 3'b010;
            2: out = 3'b001;
            1: out = 3'b000;
            default: out = 3'b00;
        endcase
    end
    else begin
        out = 3'b000;
    end
end

endmodule