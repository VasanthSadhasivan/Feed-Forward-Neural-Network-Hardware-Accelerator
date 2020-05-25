`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/17/2020 07:02:31 PM
// Design Name: 
// Module Name: ControlUnit
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

module ControlUnit(
    input CLK,
    input RST,
    input done,
    input train,
    output logic valid,
    output logic y_RAM_rw,
    output logic d_RAM_rw,
    output logic delta_w_gen_gen,
    output integer learning_rate,
    output logic d_gen_read,
    output logic w_RAM_rw,
    output logic wT_RAM_rw,
    output integer column_index,
    output integer y_RAM_layer_index,
    output integer d_RAM_layer_index,
    output integer d_gen_layer_index,
    output integer w_RAM_layer_index,
    output integer wT_RAM_layer_index,
    output integer y_RAM_neuron_index,
    output integer d_RAM_neuron_index,
    output integer d_gen_neuron_index,
    output integer w_RAM_neuron_index,
    output integer wT_RAM_neuron_index
    );
    
    typedef enum logic[3:0] {INIT, 
                         Read_Neurons, 
                         Write_Neurons, 
                         Next_Layer, 
                         d_Generation_INIT, 
                         d_Generation,
                         delta_W_Generation,
                         W_Update,
                         Previous_Layer,
                         Load_New_IO} state_t;
   
    state_t state = INIT;
    
    integer pass = 0;
    
    integer layer_index = 0;
    integer neuron_index = 0;
    


    always @ (posedge(CLK))
    begin
        if (RST)
            state <= INIT;
        else
            case (state)
                INIT:
                    if(done)
                    begin
                        state <= INIT;
                        layer_index <= 0;
                        neuron_index <= 0;
                    end
                    else
                        state <= Read_Neurons;
                Read_Neurons:
                    if(neuron_index < `MAX_NEURONS - 1)
                        state <= Write_Neurons;
                    else
                        state <= Next_Layer;
                Write_Neurons:
                begin
                    state <= Read_Neurons;
                    neuron_index <= neuron_index + 1;
                end
                Next_Layer:
                begin
                    if(layer_index < `MAX_DEPTH - 2)
                        state <= Read_Neurons;
                    else if(layer_index >= `MAX_DEPTH - 2 && train)
                        state <= d_Generation_INIT;
                    else
                        state <= Load_New_IO;
                    layer_index <= layer_index + 1;
                    neuron_index <= 0;
                end
                d_Generation_INIT:
                    if(neuron_index < `MAX_NEURONS - 1)
                        state <= d_Generation;
                    else
                        state <= Previous_Layer;
                d_Generation:
                    state <= delta_W_Generation;
                delta_W_Generation:
                    state <= W_Update;
                W_Update:
                begin
                    state <= d_Generation_INIT;
                    neuron_index <= neuron_index + 1;
                end
                Previous_Layer:
                begin
                    if(layer_index > 1)
                        state <= d_Generation_INIT;
                    else
                        state <= Load_New_IO;
                    layer_index <= layer_index - 1;
                    neuron_index <= 0;
                end
                Load_New_IO:
                begin
                    state <= INIT;
                    pass <= pass + 1;
                end
            endcase
    end

    always @ (state, layer_index)
    begin
        case (state)
            INIT:
            begin
                valid               =  0;
                y_RAM_rw            =  0;
                d_RAM_rw            =  0;
                delta_w_gen_gen     =  0;
                learning_rate       =  0;
                d_gen_read          =  0;
                w_RAM_rw            =  0;
                wT_RAM_rw           =  0;
                column_index        =  0;
                y_RAM_layer_index   =  0;
                d_RAM_layer_index   =  0;
                d_gen_layer_index   =  0;
                w_RAM_layer_index   =  0;
                wT_RAM_layer_index  =  0;
                y_RAM_neuron_index  =  0;
                d_RAM_neuron_index  =  0;
                d_gen_neuron_index  =  0;
                w_RAM_neuron_index  =  0;
                wT_RAM_neuron_index =  0;
            end
            Read_Neurons:
            begin
                valid               =  0;
                y_RAM_rw            =  0;
                d_RAM_rw            =  0;
                delta_w_gen_gen     =  0;
                learning_rate       =  0;
                d_gen_read          =  0;
                w_RAM_rw            =  0;
                wT_RAM_rw           =  0;
                column_index        =  0;
                y_RAM_layer_index   =  layer_index;
                d_RAM_layer_index   =  0;
                d_gen_layer_index   =  0;
                w_RAM_layer_index   =  layer_index;
                wT_RAM_layer_index  =  0;
                y_RAM_neuron_index  =  0;
                d_RAM_neuron_index  =  0;
                d_gen_neuron_index  =  0;
                w_RAM_neuron_index  =  neuron_index;
                wT_RAM_neuron_index =  0;
            end
            Write_Neurons:
            begin
                valid               =  0;
                y_RAM_rw            =  1;
                d_RAM_rw            =  0;
                delta_w_gen_gen     =  0;
                learning_rate       =  0;
                d_gen_read          =  0;
                w_RAM_rw            =  0;
                wT_RAM_rw           =  1;
                column_index        =  neuron_index;
                y_RAM_layer_index   =  layer_index + 1;
                d_RAM_layer_index   =  0;
                d_gen_layer_index   =  0;
                w_RAM_layer_index   =  0;
                wT_RAM_layer_index  =  layer_index;
                y_RAM_neuron_index  =  neuron_index;
                d_RAM_neuron_index  =  0;
                d_gen_neuron_index  =  0;
                w_RAM_neuron_index  =  0;
                wT_RAM_neuron_index =  0;
            end
            Next_Layer:
            begin
                valid               =  0;
                y_RAM_rw            =  0;
                d_RAM_rw            =  0;
                delta_w_gen_gen     =  0;
                learning_rate       =  0;
                d_gen_read          =  0;
                w_RAM_rw            =  0;
                wT_RAM_rw           =  0;
                column_index        =  0;
                y_RAM_layer_index   =  0;
                d_RAM_layer_index   =  0;
                d_gen_layer_index   =  0;
                w_RAM_layer_index   =  0;
                wT_RAM_layer_index  =  0;
                y_RAM_neuron_index  =  0;
                d_RAM_neuron_index  =  0;
                d_gen_neuron_index  =  0;
                w_RAM_neuron_index  =  0;
                wT_RAM_neuron_index =  0;
            end
            d_Generation_INIT:
            begin
                valid               =  0;
                y_RAM_rw            =  0;
                d_RAM_rw            =  0;
                delta_w_gen_gen     =  0;
                learning_rate       =  0;
                d_gen_read          =  0;
                w_RAM_rw            =  0;
                wT_RAM_rw           =  0;
                column_index        =  0;
                y_RAM_layer_index   =  layer_index;
                d_RAM_layer_index   =  layer_index + 1;
                d_gen_layer_index   =  0;
                w_RAM_layer_index   =  0;
                wT_RAM_layer_index  =  layer_index;
                y_RAM_neuron_index  =  0;
                d_RAM_neuron_index  =  0;
                d_gen_neuron_index  =  0;
                w_RAM_neuron_index  =  0;
                wT_RAM_neuron_index =  neuron_index;
            end
            d_Generation:
            begin
                valid               =  0;
                y_RAM_rw            =  0;              
                d_RAM_rw            =  0;              
                delta_w_gen_gen     =  0;              
                learning_rate       =  0;              
                d_gen_read          =  1;              
                w_RAM_rw            =  0;              
                wT_RAM_rw           =  0;              
                column_index        =  0;              
                y_RAM_layer_index   =  layer_index - 1;
                d_RAM_layer_index   =  0;              
                d_gen_layer_index   =  layer_index;    
                w_RAM_layer_index   =  0;              
                wT_RAM_layer_index  =  0;              
                y_RAM_neuron_index  =  0;              
                d_RAM_neuron_index  =  0;              
                d_gen_neuron_index  =  neuron_index;   
                w_RAM_neuron_index  =  0;              
                wT_RAM_neuron_index =  0;              
            end
            delta_W_Generation:
            begin
                valid               =  0;
                y_RAM_rw            =  0;
                d_RAM_rw            =  1;
                delta_w_gen_gen     =  1;
                learning_rate       =  `LEARNING_RATE_DIVIDER;
                d_gen_read          =  0;
                w_RAM_rw            =  0;
                wT_RAM_rw           =  0;
                column_index        =  0;
                y_RAM_layer_index   =  0;
                d_RAM_layer_index   =  layer_index;
                d_gen_layer_index   =  0;
                w_RAM_layer_index   =  layer_index - 1;
                wT_RAM_layer_index  =  0;
                y_RAM_neuron_index  =  0;
                d_RAM_neuron_index  =  neuron_index;
                d_gen_neuron_index  =  0;
                w_RAM_neuron_index  =  neuron_index;
                wT_RAM_neuron_index =  0;
            end
            W_Update:
            begin
                valid               =  0;
                y_RAM_rw            =  0;
                d_RAM_rw            =  0;
                delta_w_gen_gen     =  0;
                learning_rate       =  0;
                d_gen_read          =  0;
                w_RAM_rw            =  1;
                wT_RAM_rw           =  0;
                column_index        =  0;
                y_RAM_layer_index   =  0;
                d_RAM_layer_index   =  0;
                d_gen_layer_index   =  0;
                w_RAM_layer_index   =  layer_index - 1;
                wT_RAM_layer_index  =  0;
                y_RAM_neuron_index  =  0;
                d_RAM_neuron_index  =  0;
                d_gen_neuron_index  =  0;
                w_RAM_neuron_index  =  neuron_index;
                wT_RAM_neuron_index =  0;
            end
            Previous_Layer:
            begin
                valid               =  0;
                y_RAM_rw            =  0;
                d_RAM_rw            =  0;
                delta_w_gen_gen     =  0;
                learning_rate       =  0;
                d_gen_read          =  0;
                w_RAM_rw            =  0;
                wT_RAM_rw           =  0;
                column_index        =  0;
                y_RAM_layer_index   =  0;
                d_RAM_layer_index   =  0;
                d_gen_layer_index   =  0;
                w_RAM_layer_index   =  0;
                wT_RAM_layer_index  =  0;
                y_RAM_neuron_index  =  0;
                d_RAM_neuron_index  =  0;
                d_gen_neuron_index  =  0;
                w_RAM_neuron_index  =  0;
                wT_RAM_neuron_index =  0;
            end
            Load_New_IO:
            begin
                valid               =  1;
                y_RAM_rw            =  0;
                d_RAM_rw            =  0;
                delta_w_gen_gen     =  0;
                learning_rate       =  0;
                d_gen_read          =  0;
                w_RAM_rw            =  0;
                wT_RAM_rw           =  0;
                column_index        =  0;
                y_RAM_layer_index   =  0;
                d_RAM_layer_index   =  0;
                d_gen_layer_index   =  0;
                w_RAM_layer_index   =  0;
                wT_RAM_layer_index  =  0;
                y_RAM_neuron_index  =  0;
                d_RAM_neuron_index  =  0;
                d_gen_neuron_index  =  0;
                w_RAM_neuron_index  =  0;
                wT_RAM_neuron_index =  0;
            end
            default:
            begin
                valid               =  0;
                y_RAM_rw            =  0;
                d_RAM_rw            =  0;
                delta_w_gen_gen     =  0;
                learning_rate       =  0;
                d_gen_read          =  0;
                w_RAM_rw            =  0;
                wT_RAM_rw           =  0;
                column_index        =  0;
                y_RAM_layer_index   =  0;
                d_RAM_layer_index   =  0;
                d_gen_layer_index   =  0;
                w_RAM_layer_index   =  0;
                wT_RAM_layer_index  =  0;
                y_RAM_neuron_index  =  0;
                d_RAM_neuron_index  =  0;
                d_gen_neuron_index  =  0;
                w_RAM_neuron_index  =  0;
                wT_RAM_neuron_index =  0;
            end
        endcase
    end
   
endmodule
