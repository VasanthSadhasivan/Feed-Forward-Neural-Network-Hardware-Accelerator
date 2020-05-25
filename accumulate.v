`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/18/2020 01:53:31 AM
// Design Name: 
// Module Name: accumulate
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


module accumulator(
    input ARR vector1,
    output integer out
    );
    
    ARR sums;
    
    always @(*)
    begin
        sums[0] = vector1[0];
        
        for (integer i = 1; i < `MAX_NEURONS; i++) begin
            sums[i] = sums[i - 1] + vector1[i];
        end
        
        out = sums[`MAX_NEURONS - 1];
    end
endmodule
