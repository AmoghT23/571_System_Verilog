//This is the Sorter Module Self Checking Testbench
import fp::*;

module fp_sorter_tb;

    float a, b;
    float bign, smalln;

    fp_sorter dut (
        .a(a),
        .b(b),
        .bign(bign),
        .smalln(smalln)
    );

    task automatic create_float(
        output float f,
        input logic sign, 
        input logic [fp::EXPONENT_BITS-1:0] exp,
        input logic [fp::FRACTION_BITS-1:0] frac
    );
        f = fpnumberfromcomponents(sign, exp, frac);
    endtask

    task automatic check_sort(
        input string test_name,
        input float in_a,
        input float in_b,
        input float expected_big,
        input float expected_small
    );
        a = in_a;
        b = in_b;
        #1;

        $display("=== Test: %s ===", test_name);
        $display("Input A:"); printfp(a);
        $display("Input B:"); printfp(b);
        $display("--- Outputs ---");
        $display("Output Big:");printfp(bign);
        $display("Output Small:");printfp(smalln);


        if (bign.sign !== expected_big.sign ||
            bign.exp  !== expected_big.exp  ||
            bign.frac !== expected_big.frac) begin
            $display("ERROR: bign mismatch! Expected sign/exp/frac: %0d/0x%0h/0x%0h", expected_big.sign, expected_big.exp, expected_big.frac);
        end else begin
            $display("PASS: bign correct.");
        end

        if (smalln.sign !== expected_small.sign ||
            smalln.exp  !== expected_small.exp  ||
            smalln.frac !== expected_small.frac) begin
            $display("ERROR: smalln mismatch! Expected sign/exp/frac: %0d/0x%0h/0x%0h", expected_small.sign, expected_small.exp, expected_small.frac);
        end else begin
            $display("PASS: smalln correct.");
        end

        $display("------------------------------------\n");
    endtask

    initial begin

		$dumpfile("fp_sorter_tb.vcd");  
		$dumpvars(0, fp_sorter_tb);

        float f1, f2;

        create_float(f1, 0, 8'h85, 23'h123456); 
        create_float(f2, 0, 8'h80, 23'h654321); 
        check_sort("Test Case 1", f1, f2, f1, f2);
        
        create_float(f1, 0, 8'h7F, 23'h000001); 
        create_float(f2, 0, 8'h81, 23'h0AAAAA); 
        check_sort("Test Case 2", f1, f2, f2, f1);

        create_float(f1, 0, 8'h80, 23'h222222);
        create_float(f2, 0, 8'h80, 23'h111111);
        check_sort("Test Case 3", f1, f2, f1, f2);

        create_float(f1, 0, 8'h80, 23'h111111);
        create_float(f2, 0, 8'h80, 23'h222222);
        check_sort("Test Case 4", f1, f2, f2, f1);

        create_float(f1, 0, 8'h80, 23'h333333);
        create_float(f2, 0, 8'h80, 23'h333333);
        check_sort("Test Case 5", f1, f2, f1, f2);

        create_float(f1, 0, 8'h7F, 23'h000000); 
        create_float(f2, 1, 8'h80, 23'h000000); 
        check_sort("Test Case 6", f1, f2, f2, f1);

        $display("All fp_sorter tests completed.");
        $finish;
    end

endmodule
