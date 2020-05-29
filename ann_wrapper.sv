`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/20/2020 02:35:45 PM
// Design Name: 
// Module Name: ann_wrapper
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

module ann_wrapper(
    input CLK,
    input RST,
    input done,
    input train,
    input ARR input_vector,
    input ARR desired_output,
    output ARR test_output,
    output valid
    );
    
    bit y_RAM_rw;
    bit d_RAM_rw;
    bit delta_w_gen_gen;
    bit d_gen_read;
    bit w_RAM_rw;
    bit wT_RAM_rw;
    
    integer y_RAM_layer_index;
    integer d_RAM_layer_index;
    integer d_gen_layer_index;
    integer w_RAM_layer_index;
    integer wT_RAM_layer_index;
    
    integer y_RAM_neuron_index;
    integer d_RAM_neuron_index;
    integer d_gen_neuron_index;
    integer w_RAM_neuron_index;
    integer wT_RAM_neuron_index;
    
    integer wT_RAM_column_index;
        
    data learning_rate;
    
    data y_RAM_y_in;
    ARR y_RAM_y_out;
    
    data d_RAM_d_in;
    ARR d_RAM_d_out;
    
    ARR delta_w_out;
    
    ARR d_gen_wT;
        
    ARR w_new_w_new;
    
    ARR w_RAM_w_out;
        
    Y_RAM Y_RAM_unit(
        .CLK(CLK),
        .rw(y_RAM_rw),
        .neuron_index(y_RAM_neuron_index),
        .master_input(input_vector),
        .layer_index(y_RAM_layer_index),
        .y_in(y_RAM_y_in),
        .y_out(y_RAM_y_out),
        .last_layer(test_output)
    );
    
    d_RAM d_RAM_unit(
        .CLK(CLK),             
        .neuron_index(d_RAM_neuron_index),
        .layer_index(d_RAM_layer_index), 
        .rw(d_RAM_rw),              
        .d_in(d_RAM_d_in),       
        .d_out(d_RAM_d_out)       
    );
    
    delta_w_gen delta_w_gen_unit(
        .CLK(CLK),              
        .y_out(y_RAM_y_out),        
        .d(d_RAM_d_in),            
        .learning_rate(learning_rate),
        .gen(delta_w_gen_gen),              
        .delta_w_out(delta_w_out)
    );
    
    d_gen d_gen_unit(
        .CLK(CLK),
        .read(d_gen_read),
        .y_out(y_RAM_y_out),
        .desired(desired_output),
        .d_in(d_RAM_d_out),
        .layer_index(d_gen_layer_index),
        .neuron_index(d_gen_neuron_index),
        .wT(d_gen_wT),
        .d_generated(d_RAM_d_in)
    );
    
    neuron_operation neuron_operation_unit(
        .w(w_RAM_w_out),
        .y_out(y_RAM_y_out),
        .neuron_value(y_RAM_y_in)
    );
    
    w_new w_new_unit(
        .delta_w(delta_w_out),
        .w_old(w_RAM_w_out),  
        .w_new(w_new_w_new)
    );
    
    w_RAM w_RAM_unit(
        .CLK(CLK),
        .rw(w_RAM_rw),
        .layer_index(w_RAM_layer_index),
        .neuron_index(w_RAM_neuron_index),
        .w_in(w_new_w_new),
        .w_out(w_RAM_w_out)
    );
    
    wT_RAM wT_RAM_unit(
        .CLK(CLK),             
        .rw(wT_RAM_rw),
        .layer_index(wT_RAM_layer_index),
        .neuron_index(wT_RAM_neuron_index),
        .column_index(wT_RAM_column_index),
        .column(w_RAM_w_out),
        .wT_out(d_gen_wT)
    );
    
    ControlUnit ControlUnit_FSM(
        .CLK(CLK),               
        .RST(RST),   
        .done(done),
        .train(train),
        .valid(valid),            
        .y_RAM_rw(y_RAM_rw),         
        .d_RAM_rw(d_RAM_rw),         
        .delta_w_gen_gen(delta_w_gen_gen),  
        .learning_rate(learning_rate),
        .d_gen_read(d_gen_read),       
        .w_RAM_rw(w_RAM_rw),         
        .wT_RAM_rw(wT_RAM_rw),        
        .column_index(wT_RAM_column_index), 
        .y_RAM_layer_index(y_RAM_layer_index),
        .d_RAM_layer_index(d_RAM_layer_index),
        .d_gen_layer_index(d_gen_layer_index),
        .w_RAM_layer_index(w_RAM_layer_index),
        .wT_RAM_layer_index(wT_RAM_layer_index),
        .y_RAM_neuron_index(y_RAM_neuron_index),
        .d_RAM_neuron_index(d_RAM_neuron_index),
        .d_gen_neuron_index(d_gen_neuron_index),
        .w_RAM_neuron_index(w_RAM_neuron_index),
        .wT_RAM_neuron_index(wT_RAM_neuron_index)
    );
endmodule
