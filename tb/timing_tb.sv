module timing_tb;

logic clk;
logic rst_n;
logic tick;

can_timing timing_inst(
    .clk(clk),
    .rst_n(rst_n),
    .tick(tick)
);

always begin
        #10 clk = ~clk;
    end

initial begin
    clk = 0;
    rst_n = 0;

    #50;
    rst_n = 1; // release reset after 20 time units

    #25000;

    $stop;
    
end

endmodule