`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/18/2020 01:53:31 AM
// Design Name: 
// Module Name: scalar_mult
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


module scalar_mult(
    input ARR vector1,
    input data scalar,
    output ARR out
    );
    

    genvar i;
    generate
        for (i = 0; i < `MAX_NEURONS; i++) begin
            //out[i] = vector1[i] * scalar;
            qmult fixed_mult_unit(
                .i_multiplicand(vector1[i]),
                .i_multiplier(scalar),
                .o_result(out[i])
            );
        end
    endgenerate
endmodule
