`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/18/2020 01:53:31 AM
// Design Name: 
// Module Name: pointwise_mult
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
`include "library_file.v" 


module pointwise_add(
    input ARR vector1,
    input ARR vector2,
    output ARR out
    );
    genvar i;
    generate
        for (i = 0; i < `MAX_NEURONS; i++) begin
            qadd fixed_add_unit(
                .a(vector1[i]),
                .b(vector2[i]),
                .c(out[i]));
            //out[i] = vector1[i] + vector2[i];
        end
    endgenerate
endmodule
