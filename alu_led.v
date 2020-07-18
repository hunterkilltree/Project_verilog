module alu_led (lamps, clk, rst, opcode, accum);
    input clk, rst;
    input opcode;
    input [15:0]accum;
    output reg [15:0]lamps;

    // check the right condition for always @
    always @ (posedge clk, negedge rst) begin
        if (!rst)  // active-Low
            lamps <= 15'd0; // rst on board always == 1; press == 0
        else begin
            case(opcode)
                1'b0: lamps <= accum + 1'b1; // add
                1'b1: lamps <= accum - 1'b1; // minus
                default : lamps <= accum;
            endcase
        end
    end

endmodule //alu_led
