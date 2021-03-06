`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/17/2020 11:39:50 PM
// Design Name: 
// Module Name: delta_w_gen
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

module delta_w_gen(
    input CLK,
    input ARR y_out,
    input data d,
    input data learning_rate,
    input gen,
    output ARR delta_w_out
    );
    
    ARR gradient;
    ARR delta_w_out_internal_opposite;
    ARR delta_w_out_internal;
    
    scalar_mult mult_unit1(
        .vector1(y_out),
        .scalar(d),
        .out(gradient)
    );
    
    scalar_mult mult_unit_2(
        .vector1(gradient),
        .scalar(learning_rate),
        .out(delta_w_out_internal_opposite)
    );
    
    scalar_mult mult_unit_3(
        .vector1(delta_w_out_internal_opposite),
        .scalar(`NEG_ONE),
        .out(delta_w_out_internal)
    );
    
    
    always @(posedge CLK)
    begin
        if(gen)
        begin
            delta_w_out <= delta_w_out_internal;
        end
    end
    
endmodule
