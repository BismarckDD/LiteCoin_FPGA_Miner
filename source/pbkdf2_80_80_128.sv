// File name:   pbkdf2_80_80_128.sv
// Created:     07/18/2017
// Author:      Franklin
// Version:     1.1.0
// Description: First iteration of PBKDF2 for the scrypt algorithm
// Pass[80], Salt[80] => Hash[128]

module pbkdf2_80_80_128 (
    input wire clk,
    input wire n_rst,
    input wire[639:0] pass,
    input wire[639:0] salt,
    input wire enable,
    output reg[1023:0] hash,
    output reg hash_done
    );

    wire hash_done_1,hash_done_2,hash_done_3,hash_done_4;
    //hmac connections for i=1..4 (1-indexed)
    hmac_sha256_164 HMAC0 (.clk(clk),.n_rst(n_rst),.data({pass,salt,32'd1}),.enable(enable),.hash(hash[1023:768]),.hash_done(hash_done_1));
    hmac_sha256_164 HMAC1 (.clk(clk),.n_rst(n_rst),.data({pass,salt,32'd2}),.enable(enable),.hash(hash[767:512]),.hash_done(hash_done_2));
    hmac_sha256_164 HMAC2 (.clk(clk),.n_rst(n_rst),.data({pass,salt,32'd3}),.enable(enable),.hash(hash[511:256]),.hash_done(hash_done_3));
    hmac_sha256_164 HMAC3 (.clk(clk),.n_rst(n_rst),.data({pass,salt,32'd4}),.enable(enable),.hash(hash[255:0]),.hash_done(hash_done_4));

    assign hash_done = hash_done_1 & hash_done_2 & hash_done_3 & hash_done_4;

endmodule