module tb_can_tx_engine;

logic clk;
logic rst_n;
logic tick;
logic start_tx;
logic [10:0] id;
logic [3:0] data_length;
logic [63:0] data;
logic tx_line;
logic tx_busy;

can_tx_engine dut (
    .clk(clk),
    .rst_n(rst_n),
    .tick(tick),
    .start_tx(start_tx),
    .id(id),
    .data_length(data_length),
    .data(data),
    .tx_busy(tx_busy),
    .tx_line(tx_line)
);

always #10 clk = ~clk;

initial begin
    tick = 0;

    forever begin
        #200
        tick = 1;
        #20
        tick = 0;
    end
end

task reset_dut();
    begin
        rst_n = 0;
        repeat(5) @(posedge clk);
        rst_n = 1;
    end
endtask

task send_frame(input [10:0] frame_id, input [3:0] frame_dlc, input [63:0] frame_data);
    begin
        @(posedge clk);
        id = frame_id;
        data_length = frame_dlc;
        data = frame_data;

        start_tx = 1;

        @(posedge clk);
        start_tx = 0;

    end
endtask

initial begin
    clk = 0;
    start_tx = 0;
    id = 0;
    data_length = 0;
    data = 0;

    reset_dut();

    send_frame(
        11'h123,
        8,
        64'h1122334455667788
    );

    repeat(800)
        @(posedge clk);
    $stop;
end

always @(posedge clk)
begin

    if(tick)
        $display(
            "%0t  State=%0d  tx=%b",
            $time,
            dut.state,
            tx_line
        );

end



endmodule

