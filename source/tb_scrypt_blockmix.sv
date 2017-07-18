// File name:   tb_scrypt_blockmix.sv
// Created:     07/18/2017
// Author:      Franklin
// Version:     1.0.0
// Description: test bench for scrpyt block mix.

`timescale 1ns / 10ps
module tb_scrypt_blockmix ();

    localparam CLK_PERIOD = 10;

    reg tb_clk, enable_in, n_rst_in;
    reg[1023:0] data_in, data_out;
    reg hash_done;

    scrypt_blockmix DUT(.clk(tb_clk),.n_rst(n_rst_in),.enable(enable_in),.data(data_in),.hash_out(data_out),.hash_done(hash_done));

    // Clock generation block
    always begin
        tb_clk = 1'b0;
        #(CLK_PERIOD/2.0);
        tb_clk = 1'b1;
        #(CLK_PERIOD/2.0);
    end

    initial begin
        enable_in=0;
        for(integer i=0;i<32;i=i+1) begin
            data_in[32*i +: 32]=i;
        end
        n_rst_in=0;
        #(CLK_PERIOD*1.5);
        n_rst_in=1;
        enable_in=1;
        #(CLK_PERIOD);
        enable_in=0;
    end

endmodule