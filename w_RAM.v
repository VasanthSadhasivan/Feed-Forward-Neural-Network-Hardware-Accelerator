`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/17/2020 11:42:08 PM
// Design Name: 
// Module Name: w_RAM
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

module w_RAM(
    input CLK,
    input rw,
    input integer layer_index,
    input integer neuron_index,
    input ARR w_in,
    output ARR w_out
    );
    
    W_MATRIX_FILE main_ram;
    
    initial
    begin
        for (integer i = 0; i < `MAX_DEPTH; i++) begin
            for(integer j=0; j < `MAX_NEURONS; j++) begin
                for(integer k=0; k < `MAX_NEURONS; k++) begin
                    main_ram[i][j][k] = 1;
                end
            end
        end
    end

    always @(posedge CLK) 
    begin
        if(rw == 0)
        begin
            if(layer_index >= 0 && layer_index < `MAX_DEPTH &&
                neuron_index >= 0 && neuron_index <`MAX_NEURONS)
                w_out <= main_ram[layer_index][neuron_index];
        end
        else
        begin
            if(layer_index >= 0 && layer_index < `MAX_DEPTH &&
                neuron_index >= 0 && neuron_index <`MAX_NEURONS)
                main_ram[layer_index][neuron_index] <= w_in;
        end
    end
endmodule
