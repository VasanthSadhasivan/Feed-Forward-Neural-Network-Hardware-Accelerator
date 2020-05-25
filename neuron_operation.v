`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/18/2020 02:59:05 AM
// Design Name: 
// Module Name: neuron_operation
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

module neuron_operation(
    input ARR w,
    input ARR y_out,
    output integer neuron_value
    );
    
    ARR scaled_vector;
    
    integer activation_input;
    
    initial
    begin
        activation_input = 0;
    end
    
    pointwise_mult mult_unit1(
        .vector1(w),
        .vector2(y_out),
        .out(scaled_vector)
    );
    
   accumulator accumulator_unit(
        .vector1(scaled_vector),
        .out(activation_input)
    );
    
    always @(*)
    begin
        if(activation_input < 0)
            neuron_value = activation_input / `LEAKY_RELU_SLOPE_DIVIDER;
        else
            neuron_value = activation_input / `RELU_SLOPE_DIVIDER;
    end
        
endmodule
