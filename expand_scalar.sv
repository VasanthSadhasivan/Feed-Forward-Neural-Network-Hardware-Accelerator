`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/20/2020 01:29:52 PM
// Design Name: 
// Module Name: expand_scalar
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

module expand_scalar(
    input int scalar,
    output ARR vector
    );
    
    always_comb
    begin
        for (int i = 0; i < `MAX_NEURONS; i++) begin
            vector[i] = scalar;
        end
    end
endmodule
