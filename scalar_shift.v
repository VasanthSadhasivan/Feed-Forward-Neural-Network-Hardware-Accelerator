`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/20/2020 03:37:02 PM
// Design Name: 
// Module Name: scalar_shift
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

module scalar_shift(
    input ARR input_vector,
    input integer scalar,
    output ARR output_vector
    );
    
    always @(*)
    begin
        for (integer i = 0; i < `MAX_NEURONS; i++) begin
            output_vector[i] = input_vector[i] >> scalar;
        end
    end
    
endmodule
