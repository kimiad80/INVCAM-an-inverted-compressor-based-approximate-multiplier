module inverted_partial_product_generator(input [7:0] A, B, output [63:0] Pf);
	wire [7:0] P [7:0];

    // P[0]
    nand n00(P[0][0], A[0], B[0]);
    nand n01(P[0][1], A[1], B[0]);
    nand n02(P[0][2], A[2], B[0]);
    nand n03(P[0][3], A[3], B[0]);
    nand n04(P[0][4], A[4], B[0]);
    nand n05(P[0][5], A[5], B[0]);
    nand n06(P[0][6], A[6], B[0]);
    nand n07(P[0][7], A[7], B[0]);

    // P[1]
    nand n10(P[1][0], A[0], B[1]);
    nand n11(P[1][1], A[1], B[1]);
    nand n12(P[1][2], A[2], B[1]);
    nand n13(P[1][3], A[3], B[1]);
    nand n14(P[1][4], A[4], B[1]);
    nand n15(P[1][5], A[5], B[1]);
    nand n16(P[1][6], A[6], B[1]);
    nand n17(P[1][7], A[7], B[1]);

    // P[2]
    nand n20(P[2][0], A[0], B[2]);
    nand n21(P[2][1], A[1], B[2]);
    nand n22(P[2][2], A[2], B[2]);
    nand n23(P[2][3], A[3], B[2]);
    nand n24(P[2][4], A[4], B[2]);
    nand n25(P[2][5], A[5], B[2]);
    nand n26(P[2][6], A[6], B[2]);
    nand n27(P[2][7], A[7], B[2]);

    // P[3]
    nand n30(P[3][0], A[0], B[3]);
    nand n31(P[3][1], A[1], B[3]);
    nand n32(P[3][2], A[2], B[3]);
    nand n33(P[3][3], A[3], B[3]);
    nand n34(P[3][4], A[4], B[3]);
    nand n35(P[3][5], A[5], B[3]);
    nand n36(P[3][6], A[6], B[3]);
    nand n37(P[3][7], A[7], B[3]);

    // P[4]
    nand n40(P[4][0], A[0], B[4]);
    nand n41(P[4][1], A[1], B[4]);
    nand n42(P[4][2], A[2], B[4]);
    nand n43(P[4][3], A[3], B[4]);
    nand n44(P[4][4], A[4], B[4]);
    nand n45(P[4][5], A[5], B[4]);
    nand n46(P[4][6], A[6], B[4]);
    nand n47(P[4][7], A[7], B[4]);

    // P[5]
    nand n50(P[5][0], A[0], B[5]);
    nand n51(P[5][1], A[1], B[5]);
    nand n52(P[5][2], A[2], B[5]);
    nand n53(P[5][3], A[3], B[5]);
    nand n54(P[5][4], A[4], B[5]);
    nand n55(P[5][5], A[5], B[5]);
    nand n56(P[5][6], A[6], B[5]);
    nand n57(P[5][7], A[7], B[5]);

    // P[6]
    nand n60(P[6][0], A[0], B[6]);
    nand n61(P[6][1], A[1], B[6]);
    nand n62(P[6][2], A[2], B[6]);
    nand n63(P[6][3], A[3], B[6]);
    nand n64(P[6][4], A[4], B[6]);
    nand n65(P[6][5], A[5], B[6]);
    nand n66(P[6][6], A[6], B[6]);
    nand n67(P[6][7], A[7], B[6]);

    // P[7]
    nand n70(P[7][0], A[0], B[7]);
    nand n71(P[7][1], A[1], B[7]);
    nand n72(P[7][2], A[2], B[7]);
    nand n73(P[7][3], A[3], B[7]);
    nand n74(P[7][4], A[4], B[7]);
    nand n75(P[7][5], A[5], B[7]);
    nand n76(P[7][6], A[6], B[7]);
    nand n77(P[7][7], A[7], B[7]);
	
	assign Pf = {P[7], P[6], P[5], P[4], P[3], P[2], P[1], P[0]};
endmodule

///////////////////////////////////////////////////////////////////////

module carry_lookahead_adder3 (input [2:0] iA, input [2:0] iB, input C0, output Cout, output [2:0] Sum);
    wire G[2:0], P[2:0];
    wire C[3:0];

    nor nG0 (G[0], iA[0], iB[0]);
	nor nG1 (G[1], iA[1], iB[1]);
	nor nG2 (G[2], iA[2], iB[2]);
	
	xor xP0 (P[0], iA[0], iB[0]);
    xor xP1 (P[1], iA[1], iB[1]);
    xor xP2 (P[2], iA[2], iB[2]);
    
    assign C[0] = C0;
    assign C[1] = G[0] | (P[0] & C0);
    assign C[2] = G[1] | (P[1] & (G[0] | (P[0] & C0)));
    assign Cout = G[2] | (P[2] & (G[1] | (P[1] & (G[0] | (P[0] & C0)))));

    xor xS0 (Sum[0], P[0], C0);
    xor xS1 (Sum[1], P[1], C[1]);
    xor xS2 (Sum[2], P[2], C[2]);

endmodule

module carry_lookahead_adder4 (input [3:0] iA, input [3:0] iB, input C0, output Cout, output [3:0] Sum);  
	wire G[3:0], P[3:0];
    wire C[4:0];

    nor nG0 (G[0], iA[0], iB[0]);
	nor nG1 (G[1], iA[1], iB[1]);
	nor nG2 (G[2], iA[2], iB[2]);
	nor nG3 (G[3], iA[3], iB[3]);
	
	xor xP0 (P[0], iA[0], iB[0]);
    xor xP1 (P[1], iA[1], iB[1]);
    xor xP2 (P[2], iA[2], iB[2]);
    xor xP3 (P[3], iA[3], iB[3]);
    
    assign C[0] = C0;
    assign C[1] = G[0] | (P[0] & C0);
    assign C[2] = G[1] | (P[1] & (G[0] | (P[0] & C0)));
    assign C[3] = G[2] | (P[2] & (G[1] | (P[1] & (G[0] | (P[0] & C0)))));
    assign Cout = G[3] | (P[3] & (G[2] | (P[2] & (G[1] | (P[1] & (G[0] | (P[0] & C0)))))));

    xor xS0 (Sum[0], P[0], C0);
    xor xS1 (Sum[1], P[1], C[1]);
    xor xS2 (Sum[2], P[2], C[2]);
	xor xS3 (Sum[3], P[3], C[3]);
	
endmodule

module AIHA (input iA, iB, output Sum);
	nand n (Sum, iA, iB);
endmodule

module FA (input iA, iB, iC, output iCarry, iSum);
	wire w1, w2, w3;
	xor x1 (w1, iA, iB);
	xor x2 (iSum, w1, iC);
	
	and a1 (w2, iC, w1);
	and a2 (w3, iA, iB);
	
	or o1 (iCarry, w2, w3);
endmodule

module AFA (input iA, iB, iC, output iCarry, iSum);
	and a1 (iSum, iA, iB, iC);
	or o1 (iCarry, iA, iB, iC);
endmodule

module IHA (input iA, iB, output iCarry, iSum);
	xnor x1 (iSum, iA, iB);
	or o1 (iCarry, iA, iB);
endmodule

module inverted_approximate_compressor (input ix1, ix2, ix3, ix4, output iCarry, iSum);
	wire n1, n2, n3, n4;
	nand no1 (n1, ix1, ix4);
    nand no2 (n2, ix2, ix3);
    nor no3 (iSum, n1, n2);
    nor no4 (n3, ix1, ix4);
    nor no5 (n4, ix2, ix3);
    nor no6 (iCarry, n3, n4);
endmodule

module inverted_exact_compressor (input ix1, ix2, ix3, ix4, iCin, output iCout, iCarry, iSum);
	wire is1;
	FA ifa1 (ix1, ix2, ix3, iCout, is1);
	FA ifa2 (is1, ix4, iCin, iCarry, iSum);
endmodule

module INVCAM8_7 (input [7:0] A, input [7:0] B, output [15:0] out);
    
    wire [7:0] ip [7:0];
	wire [63:0] Pf;
	wire last_carry;
	
	inverted_partial_product_generator ippg (A, B, Pf);
	assign {ip[7], ip[6], ip[5], ip[4], ip[3], ip[2], ip[1], ip[0]} = Pf;
	
	wire [15:0] ts11, tc11, ts12, tc12, tcout1, tcout12;
	
	//Stage 1
	not n1 (out[0], ip[0][0]);
	AIHA h11 (ip[0][1], ip[1][0], out[1]);
	
	AFA f11 (ip[0][2], ip[1][1], ip[2][0], tc11[3], ts11[2]);
	
	inverted_approximate_compressor ic11 (ip[0][3], ip[1][2], ip[3][0], ip[2][1], tc11[4], ts11[3]);
	
	inverted_approximate_compressor ic12 (ip[0][4], ip[1][3], ip[2][2], ip[3][1], tc11[5], ts11[4]);
	
	inverted_approximate_compressor ic13 (ip[0][5], ip[2][3], ip[3][2], ip[1][4], tc11[6], ts11[5]);
	
	inverted_approximate_compressor ic14 (ip[0][6], ip[1][5], ip[3][3], ip[2][4], tc11[7], ts11[6]);
	AFA f12 (ip[4][2], ip[5][1], ip[6][0], tc12[7], ts12[6]);
	
	inverted_exact_compressor ic15 (ip[0][7], ip[2][5], ip[3][4], ip[1][6], ip[4][3], tcout1[8], tc11[8], ts11[7]);
	FA ic16 (ip[6][1], ip[7][0], ip[5][2], tc12[8], ts12[7]);
	
	inverted_exact_compressor ic17 (ip[1][7], ip[2][6], ip[3][5], ip[4][4], tcout1[8], tcout1[9], tc11[9], ts11[8]); 
	FA h12 (ip[5][3], ip[6][2], ip[7][1], tc12[9], ts12[8]);
	
	inverted_exact_compressor ic18 (ip[2][7], ip[3][6], ip[4][5], ip[5][4], tcout1[9], tcout1[10], tc11[10], ts11[9]);
	IHA h13 (ip[6][3], ip[7][2], tc12[10], ts12[9]);
	
	inverted_exact_compressor ic19 (ip[3][7], ip[4][6], ip[5][5], ip[6][4], tcout1[10], tcout1[11], tc11[11], ts11[10]);
	
	FA f13 (ip[4][7], ip[5][6], ip[6][5], tc11[12], ts11[11]);
	
	//Stage 2
	wire [15:0] ts21, tc21, tcout2;
	
	not n2 (out[2], ts11[2]);
	AIHA h21 (ts11[3], tc11[3], out[3]);
	
	AFA f21 (ts11[4], tc11[4], ip[4][0], tc21[5], ts21[4]);
	
	inverted_approximate_compressor ic21 (tc11[5], ip[5][0], ts11[5], ip[4][1], tc21[6], ts21[5]);
	
	AFA f22 (ts11[6], ts12[6], tc11[6], tc21[7], ts21[6]);
	
	inverted_exact_compressor ic22 (tc11[7], ts11[7], tc12[7], ts12[7], last_carry, tcout2[8], tc21[8], ts21[7]);
	inverted_exact_compressor ic23 (tc11[8], ts11[8], ts12[8], tc12[8], tcout2[8], tcout2[9], tc21[9], ts21[8]);
	inverted_exact_compressor ic24 (tc11[9], ts11[9], tc12[9], ts12[9], tcout2[9], tcout2[10], tc21[10], ts21[9]);
	inverted_exact_compressor ic25 (tc11[10], ts11[10], tc12[10], ip[7][3], tcout2[10], tcout2[11], tc21[11], ts21[10]);
	inverted_exact_compressor ic26 (tc11[11], ts11[11], ip[7][4], tcout1[11], tcout2[11], tcout2[12], tc21[12], ts21[11]);
	inverted_exact_compressor ic27 (ip[5][7], ip[6][6], ip[7][5], tc11[12], tcout2[12], tcout2[13], tc21[13], ts21[12]);
	FA f23 (ip[6][7], ip[7][6], tcout2[13], tc21[14], ts21[13]);
	
	//Stage 3
	wire [15:0] tc31;
	
	not n3 (out[4], ts21[4]);
	AIHA h31 (ts21[5], tc21[5], out[5]);
	AIHA h32 (ts21[6], tc21[6], out[6]);
	
	wire no1, no2, carr;
    nor nor1 (no1, ts21[5], tc21[5]);
	nor nor2 (no2, ts21[6], tc21[6]);
	nor nor3 (last_carry, no1, no2);
		
	carry_lookahead_adder4 cla41 (ts21[10:7], tc21[10:7], 1'b0, carr, out[10:7]);
	
	carry_lookahead_adder4 cla42 ({ip[7][7], ts21[13:11]}, tc21[14:11], carr, out[15], out[14:11]);
	
    
endmodule


///////////////////////////////////////////////////////////////////////

module M8_T2 (input [7:0] A, input [7:0] B, output [15:0] out);
    
	wire [7:0] ip [7:0];
	wire [63:0] Pf;
	
	inverted_partial_product_generator ippg (A, B, Pf);
	assign {ip[7], ip[6], ip[5], ip[4], ip[3], ip[2], ip[1], ip[0]} = Pf;
  
    //-----------------------------Output aasignment--------------------------------------------------
    assign out[0]  = ~ip[0][0];
	assign out[1]  = 1'b0;
	// Replace OR with NAND since inputs are inverted partial products
	assign out[2]  = ~(ip[0][1] & ip[1][0]);
	assign out[3]  = ~(ip[0][2] & ip[1][1] & ip[2][0]);
	assign out[4]  = ~(ip[0][3] & ip[1][2] & ip[2][1] & ip[3][0]);
	assign out[5]  = ~(ip[0][4] & ip[1][3] & ip[2][2] & ip[3][1] & ip[4][0]);
	assign out[6]  = ~(ip[0][5] & ip[1][4] & ip[2][3] & ip[3][2] & ip[4][1] & ip[5][0]);
	assign out[7]  = ~(ip[0][6] & ip[1][5] & ip[2][4] & ip[3][3] & ip[4][2] & ip[5][1] & ip[6][0]);
	assign out[8]  = ~(ip[0][7] & ip[1][6] & ip[2][5] & ip[3][4] & ip[4][3] & ip[5][2] & ip[6][1] & ip[7][0]);
	assign out[9]  = ~(ip[1][7] & ip[2][6] & ip[3][5] & ip[4][4] & ip[5][3] & ip[6][2] & ip[7][1]);
	assign out[10] = ~(ip[2][7] & ip[3][6] & ip[4][5] & ip[5][4] & ip[6][3] & ip[7][2]);
	assign out[11] = ~(ip[3][7] & ip[4][6] & ip[5][5] & ip[6][4] & ip[7][3]);
	assign out[12] = ~(ip[4][7] & ip[5][6] & ip[6][5] & ip[7][4]);
	assign out[13] = ~(ip[5][7] & ip[6][6] & ip[7][5]);
	assign out[14] = ~(ip[6][7] & ip[7][6]);
	assign out[15] = ~ip[7][7];

endmodule

///////////////////////////////////////////////////////////////////////

module M8_T1 (input [7:0] A, input [7:0] B, output [15:0] out);
    
	wire [7:0] ip [7:0];
	wire [63:0] Pf;
	
	inverted_partial_product_generator ippg (A, B, Pf);
	assign {ip[7], ip[6], ip[5], ip[4], ip[3], ip[2], ip[1], ip[0]} = Pf;
  
    //-----------------------------Output aasignment--------------------------------------------------
	assign out[0]  = ~ip[0][0];
	// Replace OR with NAND since inputs are inverted partial products
	assign out[1]  = ~(ip[0][1] & ip[1][0]);
	assign out[2]  = ~(ip[0][2] & ip[1][1] & ip[2][0]);
	assign out[3]  = ~(ip[0][3] & ip[1][2] & ip[2][1] & ip[3][0]);
	assign out[4]  = ~(ip[0][4] & ip[1][3] & ip[2][2] & ip[3][1] & ip[4][0]);
	assign out[5]  = ~(ip[0][5] & ip[1][4] & ip[2][3] & ip[3][2] & ip[4][1] & ip[5][0]);
	assign out[6]  = ~(ip[0][6] & ip[1][5] & ip[2][4] & ip[3][3] & ip[4][2] & ip[5][1] & ip[6][0]);
	assign out[7]  = ~(ip[0][7] & ip[1][6] & ip[2][5] & ip[3][4] & ip[4][3] & ip[5][2] & ip[6][1] & ip[7][0]);
	assign out[8]  = ~(ip[1][7] & ip[2][6] & ip[3][5] & ip[4][4] & ip[5][3] & ip[6][2] & ip[7][1]);
	assign out[9]  = ~(ip[2][7] & ip[3][6] & ip[4][5] & ip[5][4] & ip[6][3] & ip[7][2]);
	assign out[10] = ~(ip[3][7] & ip[4][6] & ip[5][5] & ip[6][4] & ip[7][3]);
	assign out[11] = ~(ip[4][7] & ip[5][6] & ip[6][5] & ip[7][4]);
	assign out[12] = ~(ip[5][7] & ip[6][6] & ip[7][5]);
	assign out[13] = ~(ip[6][7] & ip[7][6]);
	assign out[14] = ~ip[7][7];
	assign out[15] = 1'b0;
	    
endmodule

///////////////////////////////////////////////////////////////////////

module INVCAM16_7 (input [15:0] A, input [15:0] B, output [31:0] out);
    wire [7:0] AH, AL, BH, BL;
    wire [15:0] OLL, OLH, OHL, OHH;
	assign AL = A[7:0];
	assign AH = A[15:8];
	assign BL = B[7:0];
	assign BH = B[15:8];
	
	// Four multipliers
	INVCAM_7  M1 (.A(AH), .B(BH), .out(OHH));   // AH × BH under
    M8_T2     M2 (.A(AL), .B(BH), .out(OLH));   // AL × BH over
    M8_T2     M3 (.A(AH), .B(BL), .out(OHL));   // AH × BL over
    M8_T1     M4 (.A(AL), .B(BL), .out(OLL));   // AL × BL under
	
	// Combine Outputs
	assign out[7:0] = OLL[7:0];
	assign out[15:8] = (OLL[15:8] | OHL[7:0]) | OLH[7:0];
	assign out[23:16] = (OLH[15:8] | OHH[7:0]) | OHL[15:8];
	assign out[31:24] = OHH[15:8];
	
endmodule