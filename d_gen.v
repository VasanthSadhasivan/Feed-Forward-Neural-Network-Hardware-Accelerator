`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/17/2020 11:37:53 PM
// Design Name: 
// Module Name: d_gen
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

module d_gen(
    input CLK,
    input read,
    input ARR y_out,
    input ARR desired,
    input ARR d_in,
    input integer layer_index,
    input integer neuron_index,
    input ARR wT,
    output data d_generated
    );
    
    data d_gen_last;
    
    ARR backpropogated_error;
    
    data desired_negated;
    data error_term_hidden;
    data d_gen_hidden;
    data d_gen_last_leaky;
    data d_gen_hidden_leaky;
    
    //assign d_gen_last = y_out[neuron_index] - desired[neuron_index];

    assign desired_negated = 'h80000000 ^ desired[neuron_index];
    
    qadd fixed_add_unit(
                .a(y_out[neuron_index]),
                .b(desired_negated),
                .c(d_gen_last));
    
    pointwise_mult mult_unit3(
        .vector1(wT),
        .vector2(d_in),
        .out(backpropogated_error)
    );
    
    accumulator accumulator_unit(
        .vector1(backpropogated_error),
        .out(d_gen_hidden)
    );
    
    qmult fixed_mult_unit1(
        .i_multiplicand(d_gen_last),
        .i_multiplier(`LEAKY_RELU_SLOPE),
        .o_result(d_gen_last_leaky));
        
    qmult fixed_mult_unit2(
        .i_multiplicand(d_gen_hidden),
        .i_multiplier(`LEAKY_RELU_SLOPE),
        .o_result(d_gen_hidden_leaky));
        
    always @(posedge CLK)
    begin
        if(read)
        begin
            if(layer_index >=0 && layer_index < `MAX_DEPTH)
            begin
                if(layer_index == `MAX_DEPTH - 1)
                begin
                    if(y_out[neuron_index][`BITWIDTH - 1])
                        d_generated <= d_gen_last_leaky;
                    else
                        d_generated <= d_gen_last;
                end
                else
                begin
                    if(y_out[neuron_index][`BITWIDTH - 1])
                        d_generated <= d_gen_hidden_leaky;
                    else
                        d_generated <= d_gen_hidden;
                end
            end
        end
    end
endmodule
