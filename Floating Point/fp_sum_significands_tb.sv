//This is the Sum Significand Module Self Checking Testbench 
import fp::*;

module fp_sum_significands_tb;
    float bign;
    float smalln;
    logic [fp::FRACTION_BITS+1:0] sum; 

    fp_sum_significands dut (
        .bign(bign),
        .smalln(smalln),
        .sum(sum)
    );

    task automatic create_float(
        output float f,
        input bit sign,
        input [fp::EXPONENT_BITS-1:0] exp,
        input [fp::FRACTION_BITS-1:0] frac
    );
        f = fpnumberfromcomponents(sign, exp, frac);
    endtask

    task automatic print_float_format(input string label, input float f);
        $display("# %s:", label);
        $display("# float: sign=%0d exp=0x%0h frac=0x%0h", 
            f.sign, f.exp, f.frac);
    endtask

    function automatic logic [fp::FRACTION_BITS:0] get_sig(input float f);
        return { (f.exp != 0), f.frac };
    endfunction

    task automatic check_sum (
        input string test_name,
        input float in_big,
        input float in_small,
        input logic [fp::FRACTION_BITS+1:0] expected_sum
    );
        logic add_op;
        logic [fp::FRACTION_BITS:0] big_sig_in;
        logic [fp::FRACTION_BITS:0] small_sig_in;

        bign = in_big;
        smalln = in_small;

        add_op = (bign.sign == smalln.sign);
        big_sig_in= get_sig(bign);
        small_sig_in = get_sig(smalln);

        #1;

        $display("=== Test: %s ===", test_name);
        print_float_format("bign", bign);
        print_float_format("smalln", smalln);
        
        $display("# DUT Output Sum: 0x%0h", sum);
        $display("# Expected Sum: 0x%0h", expected_sum);
        
        if (sum !== expected_sum) begin
            $display("--- ERROR: Sum mismatch! ---");
            $display("# ERROR DETAIL: Big Sig: 0x%0h, Small Sig: 0x%0h, Op: %s", big_sig_in, small_sig_in, add_op ? "ADD" : "SUB");
        end else begin
            $display("--- PASS: Sum correct. ---");
        end
        $display("------------------------------------\n");
    endtask

    initial begin
        float f_big, f_small;

        localparam SIG_W = fp::FRACTION_BITS + 1;
        localparam E_MID = 8'h80; 
        localparam ONE_POINT_ZERO_SIG = {1'b1, {fp::FRACTION_BITS{1'b0}}}; 
        localparam ONE_POINT_FIVE_SIG = {1'b1, 23'h400000}; 

        create_float(f_big, 0, E_MID, ONE_POINT_ZERO_SIG[fp::FRACTION_BITS-1:0]);
        create_float(f_small, 0, E_MID, ONE_POINT_ZERO_SIG[fp::FRACTION_BITS-1:0]);
        check_sum("Test Case 1", f_big, f_small, 25'h1000000); 

        create_float(f_big, 0, E_MID, ONE_POINT_ZERO_SIG[fp::FRACTION_BITS-1:0]); 
        create_float(f_small, 0, E_MID, ONE_POINT_FIVE_SIG[fp::FRACTION_BITS-1:0]);
        check_sum("Test Case 2 (1.0 + 1.5)", f_big, f_small, 25'h1400000); 

        create_float(f_big, 0, E_MID, ONE_POINT_FIVE_SIG[fp::FRACTION_BITS-1:0]); 
        create_float(f_small, 1, E_MID, ONE_POINT_FIVE_SIG[fp::FRACTION_BITS-1:0]); 
        check_sum("Test Case 3 (1.5 - 1.5)", f_big, f_small, 25'h0000000); 

        create_float(f_big, 0, E_MID, ONE_POINT_ZERO_SIG[fp::FRACTION_BITS-1:0]);
        create_float(f_small, 1, E_MID, ONE_POINT_ZERO_SIG[fp::FRACTION_BITS-1:0]);
        check_sum("Test Case 4 (1.0 - 1.0)", f_big, f_small, 25'h0000000);

        create_float(f_big, 0, E_MID, ONE_POINT_FIVE_SIG[fp::FRACTION_BITS-1:0]); 
        create_float(f_small, 1, E_MID, ONE_POINT_ZERO_SIG[fp::FRACTION_BITS-1:0]); 
        check_sum("Test Case 5 (1.5 - 1.0)", f_big, f_small, 25'h200000); 

        $display("All fp_sum_significands tests completed.");
        $finish;
    end
endmodule
