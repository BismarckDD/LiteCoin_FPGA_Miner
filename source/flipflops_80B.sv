// File name:   flipflops_80B.sv
// Created:     07/18/2017
// Author:      Franklin
// Version:     1.0.0
// Description: 80B flip-flop array to hold hash data.

module flipflops_80B (
    input wire clk,
    input wire [7:0] rx_out,
    input wire [6:0] address,
    input wire load,
    output reg [639:0] hash_data
    );

/*
1, Generate: generate for, generate if, generate case.
2, Generate for must use the variable defined by "genvar".
3, for loop must use begin & end
4, for loop must have a name (???)
*/

genvar i;
generate
    for(i = 0;i < 80; i = i + 1) begin
        always_ff @ (posedge clk) begin
            if((load == 1'b1) && (i == address)) begin
                hash_data[8*i+7:8*i] <= rx_out;
            end // Get data from the receiver, seems need 80 clock cycles, optimize it.
            else begin
                hash_data[8*i+7:8*i] <= hash_data[8*i+7:8*i];
            end
        end
    end
endgenerate


endmodule