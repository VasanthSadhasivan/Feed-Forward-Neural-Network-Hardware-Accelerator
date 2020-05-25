`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/17/2020 11:40:47 PM
// Design Name: 
// Module Name: w_new
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


module w_new(
    input ARR delta_w,
    input ARR w_old,
    output ARR w_new
    );
    
    pointwise_add add_unit(
        .vector1(w_old),
        .vector2(delta_w),
        .out(w_new)
    );
endmodule
