`timescale 1ns/1ps
module Testbench;
    parameter WIDTH = 8;
	parameter NUM_APPROX_BITS = 7;
	parameter NUM_SAMPLES = 1000000;

	localparam OUT_WIDTH = 2 * WIDTH;
	localparam integer MAX_INPUT = (1 << WIDTH) - 1;
	localparam integer TOTAL = (WIDTH == 8) ? (1 << (2 * WIDTH)) : NUM_SAMPLES;

	localparam real MAX_PRODUCT = 1.0 * MAX_INPUT * MAX_INPUT;

    reg  [WIDTH-1:0] A, B;
    wire [OUT_WIDTH-1:0] P_approx;

    generate
        if (WIDTH == 8) begin : gen_invcam8
            if (NUM_APPROX_BITS == 7) begin : gen_invcam8_7
				INVCAM8_7 invcam (
					.A(A),
					.B(B),
					.out(P_approx)
				);
			end
			else if (NUM_APPROX_BITS == 8) begin : gen_invcam8_8
				INVCAM8_8 invcam (
					.A(A),
					.B(B),
					.out(P_approx)
				);
			end
			else if (NUM_APPROX_BITS == 9) begin : gen_invcam8_9
				INVCAM8_9 invcam (
					.A(A),
					.B(B),
					.out(P_approx)
				);
			end
			else if (NUM_APPROX_BITS == 10) begin : gen_invcam8_10
				INVCAM8_10 invcam (
					.A(A),
					.B(B),
					.out(P_approx)
				);
			end
			else if (NUM_APPROX_BITS == 11) begin : gen_invcam8_11
				INVCAM8_11 invcam (
					.A(A),
					.B(B),
					.out(P_approx)
				);
			end
			else if (NUM_APPROX_BITS == 12) begin : gen_invcam8_12
				INVCAM8_12 invcam (
					.A(A),
					.B(B),
					.out(P_approx)
				);
			end
			else begin : gen_invcam8_invalid
				initial begin
					$display("ERROR: Unsupported NUM_APPROX_BITS = %0d", NUM_APPROX_BITS);
					$finish;
				end
			end
        end
		else if (WIDTH == 16) begin : gen_invcam16
            if (NUM_APPROX_BITS == 7) begin : gen_invcam16_7
				INVCAM16_7 invcam (
					.A(A),
					.B(B),
					.out(P_approx)
				);
			end
			else if (NUM_APPROX_BITS == 8) begin : gen_invcam16_8
				INVCAM16_8 invcam (
					.A(A),
					.B(B),
					.out(P_approx)
				);
			end
			else if (NUM_APPROX_BITS == 9) begin : gen_invcam16_9
				INVCAM16_9 invcam (
					.A(A),
					.B(B),
					.out(P_approx)
				);
			end
			else if (NUM_APPROX_BITS == 10) begin : gen_invcam16_10
				INVCAM16_10 invcam (
					.A(A),
					.B(B),
					.out(P_approx)
				);
			end
			else if (NUM_APPROX_BITS == 11) begin : gen_invcam16_11
				INVCAM16_11 invcam (
					.A(A),
					.B(B),
					.out(P_approx)
				);
			end
			else if (NUM_APPROX_BITS == 12) begin : gen_invcam16_12
				INVCAM16_12 invcam (
					.A(A),
					.B(B),
					.out(P_approx)
				);
			end
			else begin : gen_invcam16_invalid
				initial begin
					$display("ERROR: Unsupported NUM_APPROX_BITS = %0d", NUM_APPROX_BITS);
					$finish;
				end
			end
        end
		else begin : gen_invalid
			initial begin
				$display("ERROR: Unsupported WIDTH = %0d", WIDTH);
				$finish;
			end
		end
    endgenerate

    integer i, j;

	reg [OUT_WIDTH-1:0] exact_product;
	reg [OUT_WIDTH:0] error_distance;
	reg [OUT_WIDTH:0] ed_max;

	reg [63:0] error_count;
	reg [63:0] nonzero_count;

	real sum_ed;
	real sum_red;
	real er_percent;
	real mred_percent;
	real nmed_e3;
	
	task evaluate;
		begin
			#1;

			if (^P_approx === 1'bx) begin
				$display("ERROR: Unknown DUT output for A=%0d, B=%0d", A, B);
				$finish;
			end

			exact_product = A * B;

			if (P_approx >= exact_product)
				error_distance = {1'b0, P_approx} - {1'b0, exact_product};
			else
				error_distance = {1'b0, exact_product} - {1'b0, P_approx};

			if (error_distance != 0)
				error_count = error_count + 1;

			if (error_distance > ed_max)
				ed_max = error_distance;

			sum_ed = sum_ed + error_distance;

			if (exact_product != 0) begin
				sum_red = sum_red + (1.0 * error_distance / exact_product);
				nonzero_count = nonzero_count + 1;
			end
		end
	endtask
	
    initial begin
		A = 0;
		B = 0;
		
		error_count = 0;
		ed_max = 0;
		nonzero_count = 0;
		sum_ed = 0.0;
		sum_red = 0.0;

		if (WIDTH == 8) begin
			for (i = 0; i <= MAX_INPUT; i = i + 1) begin
				for (j = 0; j <= MAX_INPUT; j = j + 1) begin
					A = i;
					B = j;
					evaluate();
				end
			end
		end
		else if (WIDTH == 16) begin
			for (i = 0; i < NUM_SAMPLES; i = i + 1) begin
				A = $urandom;
				B = $urandom;
				evaluate();
			end
		end

		er_percent   = 100.0 * error_count / TOTAL;
		mred_percent = (nonzero_count > 0) ? 100.0 * sum_red / nonzero_count : 0.0;
		nmed_e3      = 1000.0 * (sum_ed / TOTAL) / MAX_PRODUCT;

		$display("-----------------------------------------------");
		$display("Input width               : %0d bits", WIDTH);
		$display("Number of Approximate Bits: %0d", NUM_APPROX_BITS);
		$display("Test vectors              : %0d", TOTAL);
		$display("ER (%%)                    : %0.1f", er_percent);
		$display("EDmax                     : %0d", ed_max);
		$display("MRED (%%)                  : %0.2f", mred_percent);
		$display("NMED (e-3)                : %0.2f", nmed_e3);
		$display("-----------------------------------------------");

		$finish;
	end
endmodule
