module bound_flash (
    input flick,
    input clk,
    input rst,
    output reg lamps
);
    reg [2:0] state,next;
    reg [15:0] signal;
    reg [1:0] opcode;
    wire mdelay;
	 wire [15:0]A;


    parameter IDLE = 3'b000;
    parameter S1 = 3'b001;
    parameter S2 = 3'b010;
    parameter S3 = 3'b011;
    parameter S4 = 3'b100;
    parameter S5 = 3'b101;
    parameter S6 = 3'b110;

    clock_delay my_delay(clk, mdelay);
	 
	 
	 
	 always @(posedge clk or negedge rst) begin
		if (!rst) signal <= 0;
		else signal <= A;
	end




    // need to review
    // state transfer
    always @(posedge clk or negedge rst) begin
        if (!rst) state <= IDLE;
        else state <= next;
    end

    // start the state machine
    always @ (posedge clk) begin
        // default value
        next = IDLE;
        opcode = 1'bx;
        case(state)
            IDLE: if (flick == 1) next = S1;

            S1: if (signal[15] == 1) next = S2;
                else opcode = 1'b0;

            S2: if (signal[5] == 0 && flick == 1) next = S1; // đèn 6 vừa tắt và flick = 1
                else if (signal[5] == 0) next = S3; // đèn 6 đã tắt
                else opcode = 1'b1;

            S3: if (signal[10] == 1) next = S4; // đèn 11 sáng
                else opcode = 1'b0;

            S4: if ( (signal[5] == 0  || signal[0] == 0) && flick == 1) next = S3; // đền 6 tắt hoặc đèn 0 tắt và có flick
                else if (signal[0] == 0) next = S5; // đèn
                else opcode = 1'b1;

            S5: if (signal[5] == 0) next = S6;
                else opcode = 1'b0;

            S6: if (signal[0] == 0) next = IDLE;

            default: state = next;
        endcase
    end

    //alu_led (lamps, clk, rst, opcode, accum);
    alu_led led(A, clk, rst, opcode);

    assign out = state;

endmodule //bound_flash
