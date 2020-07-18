module clock_delay(input CLOCKin, output reg clk); // convert 50mhz to half-second CLOCK cycles
	reg [24:0]counter;

	initial begin
		counter = 0;
		clk = 0;
	end

	always @(posedge CLOCKin)
		if (counter ==  12500000) begin
			counter <= 0;
			clk <= ~clk;
		end
		else begin
			counter <= counter + 1;
			clk <= clk;
		end
endmodule
