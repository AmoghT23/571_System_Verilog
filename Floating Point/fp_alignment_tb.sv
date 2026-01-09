import fp::*;

module fp_alignment_tb;

    float bign, smalln;
    float aligned;

    fp_alignment dut (
        .bign(bign),
        .smalln(smalln),
        .aligned(aligned)
    );

    task automatic print_float (input float f); 
        $display("float: sign=%0d exp=0x%0h frac=0x%0h", f.sign, f.exp, f.frac);
    endtask

    logic [fp::FRACTION_BITS:0] temp_frac;
    logic [fp::FRACTION_BITS-1:0] aligned_frac;
    logic [fp::EXPONENT_BITS-1:0] exp_diff;

    task automatic create_float(
        output float f,
        input logic sign,
        input logic [fp::EXPONENT_BITS-1:0] exp, 
        input logic [fp::FRACTION_BITS-1:0] frac 
    );
        f = fpnumberfromcomponents(sign, exp, frac);
    endtask

    task automatic check_alignment(
        input string test_name,
        input float in_big,
        input float in_small,
        input float expected_aligned
    );
        bign= in_big;
        smalln = in_small;
        #1; 

        $display("=== Test: %s ===", test_name);
        $display("bign:"); print_float(bign);
        $display("smalln:"); print_float(smalln);
        $display("Exp Diff: %0d", bign.exp - smalln.exp); 
        $display("aligned:"); print_float(aligned);

        if (aligned.sign !== expected_aligned.sign ||
            aligned.exp  !== expected_aligned.exp ||
            aligned.frac !== expected_aligned.frac) begin
            $display("ERROR: Alignment mismatch! Expected sign/exp/frac: %0d/0x%0h/0x%0h", expected_aligned.sign, expected_aligned.exp, expected_aligned.frac);
        end else begin
            $display("PASS: Alignment correct.");
        end
        $display("\n");
    endtask

    initial begin
        float f_big, f_small, expected;

        // ---------------- Test case 1----------------
        create_float(f_big, 0, 8'h85, 23'h123456);
        create_float(f_small, 0, 8'h80, 23'h654321);
        exp_diff = f_big.exp - f_small.exp;
        temp_frac = {1'b1, f_small.frac} >> exp_diff; 
        
        aligned_frac = temp_frac[fp::FRACTION_BITS-1:0];
        expected= fpnumberfromcomponents(f_small.sign, f_big.exp, aligned_frac);
        check_alignment("Test Case 1", f_big, f_small, expected);

        // ---------------- Test case 2 ----------------
        create_float(f_big, 0, 8'h81, 23'h0AAAAA);
        create_float(f_small, 0, 8'h80, 23'h222222);
        exp_diff = f_big.exp - f_small.exp; 
        temp_frac= {1'b1, f_small.frac} >> exp_diff;
        
        aligned_frac = temp_frac[fp::FRACTION_BITS-1:0]; 
        expected= fpnumberfromcomponents(f_small.sign, f_big.exp, aligned_frac);
        check_alignment("Test Case 2", f_big, f_small, expected);

        // ---------------- Test case 3----------------
        create_float(f_big, 0, 8'h80, 23'h333333);
        create_float(f_small, 0, 8'h80, 23'h111111);
        exp_diff = f_big.exp - f_small.exp; 

        temp_frac= {1'b1, f_small.frac} >> exp_diff;
        
        aligned_frac = temp_frac[fp::FRACTION_BITS-1:0]; 
        expected= fpnumberfromcomponents(f_small.sign, f_big.exp, aligned_frac);
        check_alignment("Test Case 3 (Diff 0)", f_big, f_small, expected);

        // ---------------- Test case 4 ----------------
        create_float(f_big, 0, 8'h90, 23'h100000);
        create_float(f_small, 0, 8'h70, 23'h100000);
        exp_diff = f_big.exp - f_small.exp; 
        temp_frac= {1'b1, f_small.frac} >> exp_diff; 
        
        aligned_frac = temp_frac[fp::FRACTION_BITS-1:0]; 
        expected= fpnumberfromcomponents(f_small.sign, f_big.exp, 23'h0);
        check_alignment("Test Case 4 (Large Diff)", f_big, f_small, expected);

        $display("All alignment tests completed.");
        $finish;
    end

endmodule
