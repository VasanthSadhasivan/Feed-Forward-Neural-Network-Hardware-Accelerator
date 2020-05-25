`ifndef SVINCLUDES

   //define all macros here
   //define all functions here
   
    `define MAX_NEURONS 3
    `define MAX_DEPTH 3
    `define LEARNING_RATE_DIVIDER 1
    `define LEAKY_RELU_SLOPE_DIVIDER 16
    `define RELU_SLOPE_DIVIDER 1
    
    typedef integer ARR[`MAX_NEURONS];
    
    typedef ARR VAL_MATRIX[`MAX_DEPTH];
    typedef ARR W_MATRIX[`MAX_NEURONS];
    
    typedef VAL_MATRIX VAL_MATRIX_FILE[`MAX_DEPTH];
    typedef W_MATRIX W_MATRIX_FILE[`MAX_DEPTH-1];

    `define SVINCLUDES

`endif