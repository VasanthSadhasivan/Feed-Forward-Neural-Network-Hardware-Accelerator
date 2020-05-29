`ifndef SVINCLUDES

   //define all macros here
   //define all functions here
    
    `define WEIGHT_INIT 'h1000
    `define DATA_INIT 'h8000
   
    `define NEG_ONE 'h80008000
   
    `define MAX_NEURONS 3
    `define MAX_DEPTH 3
    `define LEARNING_RATE 'h200 // 2^-6 in decimal
    `define LEAKY_RELU_SLOPE 'h0000
    `define RELU_SLOPE 'h8000 // 1 in decimal
    
    `define BITWIDTH 32
    
    typedef logic[`BITWIDTH - 1:0] data;
    
    typedef data ARR[`MAX_NEURONS];
    
    typedef ARR VAL_MATRIX[`MAX_DEPTH];
    typedef ARR W_MATRIX[`MAX_NEURONS];
    
    typedef VAL_MATRIX VAL_MATRIX_FILE[`MAX_DEPTH];
    typedef W_MATRIX W_MATRIX_FILE[`MAX_DEPTH-1];

    `define SVINCLUDES

`endif 