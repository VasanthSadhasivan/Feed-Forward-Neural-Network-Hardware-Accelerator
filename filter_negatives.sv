`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/20/2020 01:57:25 PM
// Design Name: 
// Module Name: filter_negatives
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

module filter_negatives(
    input ARR input_vector,
    output ARR output_vector
    );
    
    always_comb
    begin
        for (int i = 0; i < `MAX_NEURONS; i++) begin
            if(input_vector[i] < 0)
                output_vector[i] = 0;
            else
                output_vector[i]=input_vector[i];
        end
    end
endmodule
