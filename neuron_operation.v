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
    output data neuron_value
    );
    
    ARR scaled_vector;
    
    data activation_input;
    data neuron_value_slope;
    data neuron_value_leaky_slope;
    
    pointwise_mult mult_unit1(
        .vector1(w),
        .vector2(y_out),
        .out(scaled_vector)
    );
    
   accumulator accumulator_unit(
        .vector1(scaled_vector),
        .out(activation_input)
    );
    
    qmult fixed_mult_unit1(
        .i_multiplicand(activation_input),
        .i_multiplier(`LEAKY_RELU_SLOPE),
        .o_result(neuron_value_leaky_slope)
    );
        
    qmult fixed_mult_unit2(
        .i_multiplicand(activation_input),
        .i_multiplier(`RELU_SLOPE),
        .o_result(neuron_value_slope)
    );
    
    always @(*)
    begin
        if(activation_input[`BITWIDTH - 1])
            neuron_value = neuron_value_leaky_slope;
        else
            neuron_value = neuron_value_slope;
    end
        
endmodule
