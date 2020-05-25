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
    input integer scalar,
    output ARR out
    );
    
    always @(*)
    begin
        for (integer i = 0; i < `MAX_NEURONS; i++) begin
            out[i] = vector1[i] * scalar;
        end
    end
endmodule
