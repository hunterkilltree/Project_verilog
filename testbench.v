module testbench;

    parameter HALF_CYCLE = 5;
    parameter CYCLE = HALF_CYCLE * 2;
    parameter MAX_LAMP = 16;
    reg clk, rst_n, flick;
    wire[MAX_LAMP-1:0] lamp;

    bound_flash MC(.clk(CLOCK_50),.flick(flick), .rst(rst), .lamps(lamp)); //(out, in, rst, enable, CLK50);

    always begin
        clk = 1'b0;
        #HALF_CYCLE clk = 1'b1;
        #HALF_CYCLE;
    end

    // display to check
    always @ (posedge clk) begin
        $strobe ("t= %d, rst_n = %b, clk= %b, flick= %b, lamp= %b",
                    %stime, rst_n, clk, flick, lamp);
    end

    initial begin
        rst_n = 1'b0;
        #(CYCLE*3) rst_n = 1'b1;
    end

    initial begin
        flick = 1'b1;

        #(CYCLE*60) $finish;
    end

    // initial begin
    //     #(20)
    //     $display ("----------------------------------");
    //     $display ("------------Active reset ---------");
    //     $display ("----------------------------------");
    //     rst_n = 1'b0;
    //
    //     #(300) rst_n = 1'b1;
    //     #(300) flick = 1'b1;
    //     #(300) flick = 1'b0;
    //
    //     #(300) $finish; // end simulation
    // end
    //
    // initial begin
    //     $recodefile ("wave");
    //     $recordvars ("depth=0", testbench);
    // end
endmodule
