// clk = 50MHz
// bit rate = 500Kbps
// can bit time = 100 clocks per bit

module can_timing(
    input logic clk,
    input logic rst_n,
    output logic tick
);

logic [6:0] bit_time_counter; // 7 bits to count up to 100

always_ff @(posedge clk or negedge rst_n) begin
    if(!rst_n) begin
    bit_time_counter <= 0;
    tick <= 0; // reset tick on reset
    end 

    else begin

        if(bit_time_counter == 99) begin
                bit_time_counter <= 0; // reset counter after reaching 100
                tick <= 1; // set tick high at the end of the bit time
        end 
        
        else begin
            bit_time_counter <= bit_time_counter + 1;
            tick <= 0;
        end 
    end
end

//     else begin 
//     bit_time_counter <= bit_time_counter + 1;
    
//         if(bit_time_counter == 99) begin
//             tick <= 1;
//             bit_time_counter <= 0; // reset counter after reaching 100
//         end else tick <= 0;
//     end
// end


endmodule
