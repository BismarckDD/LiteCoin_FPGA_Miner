// File name:   pbkdf2_80_128_32.sv
// Created:     07/18/2017
// Author:      Franklin
// Version:     1.1.0
// Description: Second iteration of PBKDF2 for the scrypt algorithm
// Pass[80], Salt[128] => Hash[32]

module pbkdf2_80_128_32 (
    input wire clk,
    input wire n_rst,
    input wire[639:0] pass,
    input wire[1023:0] salt,
    input wire enable,
    output reg[255:0] hash,
    output reg hash_done
    );

    hmac_sha256_212 HMAC0 (.clk(clk),.n_rst(n_rst),.data({pass,salt,32'b1}),.enable(enable),.hash(hash),.hash_done(hash_done));

endmodule