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
    output integer d_generated
    );
    
    integer d_gen_last;
    
    ARR backpropogated_error;
    integer error_term_hidden;
    integer d_gen_hidden;


    assign d_gen_last = y_out[neuron_index] - desired[neuron_index];
    
    pointwise_mult mult_unit3(
        .vector1(wT),
        .vector2(d_in),
        .out(backpropogated_error)
    );
    
    accumulator accumulator_unit(
        .vector1(backpropogated_error),
        .out(d_gen_hidden)
    );
    
    always @(posedge CLK)
    begin
        if(read)
        begin
            if(layer_index >=0 && layer_index < `MAX_DEPTH)
            begin
                if(layer_index == `MAX_DEPTH - 1)
                begin
                    if(d_gen_last < 0)
                        d_generated <= d_gen_last / `LEAKY_RELU_SLOPE_DIVIDER;
                    else
                        d_generated <= d_gen_last;
                end
                else
                begin
                    if(d_gen_hidden < 0)
                        d_generated <= d_gen_hidden / `LEAKY_RELU_SLOPE_DIVIDER;
                    else
                        d_generated <= d_gen_hidden;
                end
            end
        end
    end
endmodule
