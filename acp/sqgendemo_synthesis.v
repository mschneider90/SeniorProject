////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995-2013 Xilinx, Inc.  All rights reserved.
////////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor: Xilinx
// \   \   \/     Version: P.20131013
//  \   \         Application: netgen
//  /   /         Filename: sqgendemo_synthesis.v
// /___/   /\     Timestamp: Thu Jul 31 21:10:23 2014
// \   \  /  \ 
//  \___\/\___\
//             
// Command	: -intstyle ise -insert_glbl true -w -dir netgen/synthesis -ofmt verilog -sim sqgendemo.ngc sqgendemo_synthesis.v 
// Device	: xc3s500e-4-fg320
// Input file	: sqgendemo.ngc
// Output file	: C:\Users\inevitable_disaster\Desktop\senior_proj\SeniorProject\acp\netgen\synthesis\sqgendemo_synthesis.v
// # of Modules	: 1
// Design Name	: sqgendemo
// Xilinx        : C:\Xilinx\14.7\ISE_DS\ISE\
//             
// Purpose:    
//     This verilog netlist is a verification model and uses simulation 
//     primitives which may not represent the true implementation of the 
//     device, however the netlist is functionally correct and should not 
//     be modified. This file cannot be synthesized and should only be used 
//     with supported simulation tools.
//             
// Reference:  
//     Command Line Tools User Guide, Chapter 23 and Synthesis and Simulation Design Guide, Chapter 6
//             
////////////////////////////////////////////////////////////////////////////////

`timescale 1 ns/1 ps

module sqgendemo (
  SECCTR, clk, butt_1, butt_2, butt_3, butt_4, audio_out, oct, volsel
);
  output SECCTR;
  input clk;
  input butt_1;
  input butt_2;
  input butt_3;
  input butt_4;
  output [7 : 0] audio_out;
  input [5 : 0] oct;
  input [1 : 0] volsel;
  wire \Madd_StateCtr_addsub0000_cy<10>_rt_2 ;
  wire \Madd_StateCtr_addsub0000_cy<11>_rt_4 ;
  wire \Madd_StateCtr_addsub0000_cy<12>_rt_6 ;
  wire \Madd_StateCtr_addsub0000_cy<13>_rt_8 ;
  wire \Madd_StateCtr_addsub0000_cy<14>_rt_10 ;
  wire \Madd_StateCtr_addsub0000_cy<15>_rt_12 ;
  wire \Madd_StateCtr_addsub0000_cy<16>_rt_14 ;
  wire \Madd_StateCtr_addsub0000_cy<17>_rt_16 ;
  wire \Madd_StateCtr_addsub0000_cy<18>_rt_18 ;
  wire \Madd_StateCtr_addsub0000_cy<19>_rt_20 ;
  wire \Madd_StateCtr_addsub0000_cy<1>_rt_22 ;
  wire \Madd_StateCtr_addsub0000_cy<20>_rt_24 ;
  wire \Madd_StateCtr_addsub0000_cy<21>_rt_26 ;
  wire \Madd_StateCtr_addsub0000_cy<22>_rt_28 ;
  wire \Madd_StateCtr_addsub0000_cy<23>_rt_30 ;
  wire \Madd_StateCtr_addsub0000_cy<24>_rt_32 ;
  wire \Madd_StateCtr_addsub0000_cy<25>_rt_34 ;
  wire \Madd_StateCtr_addsub0000_cy<26>_rt_36 ;
  wire \Madd_StateCtr_addsub0000_cy<27>_rt_38 ;
  wire \Madd_StateCtr_addsub0000_cy<28>_rt_40 ;
  wire \Madd_StateCtr_addsub0000_cy<29>_rt_42 ;
  wire \Madd_StateCtr_addsub0000_cy<2>_rt_44 ;
  wire \Madd_StateCtr_addsub0000_cy<30>_rt_46 ;
  wire \Madd_StateCtr_addsub0000_cy<3>_rt_48 ;
  wire \Madd_StateCtr_addsub0000_cy<4>_rt_50 ;
  wire \Madd_StateCtr_addsub0000_cy<5>_rt_52 ;
  wire \Madd_StateCtr_addsub0000_cy<6>_rt_54 ;
  wire \Madd_StateCtr_addsub0000_cy<7>_rt_56 ;
  wire \Madd_StateCtr_addsub0000_cy<8>_rt_58 ;
  wire \Madd_StateCtr_addsub0000_cy<9>_rt_60 ;
  wire \Madd_StateCtr_addsub0000_xor<31>_rt_62 ;
  wire \Mcompar_StateCtr_cmp_gt0000_cy<1>_rt_65 ;
  wire \Mcompar_StateCtr_cmp_gt0000_lut[0] ;
  wire \Mcompar_StateCtr_cmp_gt0000_lut[2] ;
  wire \Mcompar_StateCtr_cmp_gt0000_lut[3] ;
  wire \Mcompar_StateCtr_cmp_gt0000_lut[4] ;
  wire \Mcompar_StateCtr_cmp_gt0000_lut[5] ;
  wire \Mcompar_StateCtr_cmp_gt0000_lut[6] ;
  wire \Mcompar_StateCtr_cmp_gt0000_lut[7] ;
  wire \Mcompar_StateCtr_cmp_gt0000_lut[8] ;
  wire \Mcompar_StateCtr_cmp_gt0000_lut[9] ;
  wire \Mcompar_note_in_cmp_ge0000_cy<0>_rt_84 ;
  wire \Mcompar_note_in_cmp_ge0000_cy<2>_rt_88 ;
  wire \Mcompar_note_in_cmp_ge0000_lut[10] ;
  wire \Mcompar_note_in_cmp_ge0000_lut[11] ;
  wire \Mcompar_note_in_cmp_ge0000_lut[1] ;
  wire \Mcompar_note_in_cmp_ge0000_lut[3] ;
  wire \Mcompar_note_in_cmp_ge0000_lut[4] ;
  wire \Mcompar_note_in_cmp_ge0000_lut[5] ;
  wire \Mcompar_note_in_cmp_ge0000_lut[6] ;
  wire \Mcompar_note_in_cmp_ge0000_lut[7] ;
  wire \Mcompar_note_in_cmp_ge0000_lut[8] ;
  wire \Mcompar_note_in_cmp_ge0000_lut[9] ;
  wire \Mcount_SecondCtr_cy<10>_rt_108 ;
  wire \Mcount_SecondCtr_cy<11>_rt_110 ;
  wire \Mcount_SecondCtr_cy<12>_rt_112 ;
  wire \Mcount_SecondCtr_cy<13>_rt_114 ;
  wire \Mcount_SecondCtr_cy<14>_rt_116 ;
  wire \Mcount_SecondCtr_cy<15>_rt_118 ;
  wire \Mcount_SecondCtr_cy<16>_rt_120 ;
  wire \Mcount_SecondCtr_cy<17>_rt_122 ;
  wire \Mcount_SecondCtr_cy<18>_rt_124 ;
  wire \Mcount_SecondCtr_cy<19>_rt_126 ;
  wire \Mcount_SecondCtr_cy<1>_rt_128 ;
  wire \Mcount_SecondCtr_cy<20>_rt_130 ;
  wire \Mcount_SecondCtr_cy<21>_rt_132 ;
  wire \Mcount_SecondCtr_cy<22>_rt_134 ;
  wire \Mcount_SecondCtr_cy<23>_rt_136 ;
  wire \Mcount_SecondCtr_cy<24>_rt_138 ;
  wire \Mcount_SecondCtr_cy<25>_rt_140 ;
  wire \Mcount_SecondCtr_cy<26>_rt_142 ;
  wire \Mcount_SecondCtr_cy<27>_rt_144 ;
  wire \Mcount_SecondCtr_cy<28>_rt_146 ;
  wire \Mcount_SecondCtr_cy<29>_rt_148 ;
  wire \Mcount_SecondCtr_cy<2>_rt_150 ;
  wire \Mcount_SecondCtr_cy<30>_rt_152 ;
  wire \Mcount_SecondCtr_cy<3>_rt_154 ;
  wire \Mcount_SecondCtr_cy<4>_rt_156 ;
  wire \Mcount_SecondCtr_cy<5>_rt_158 ;
  wire \Mcount_SecondCtr_cy<6>_rt_160 ;
  wire \Mcount_SecondCtr_cy<7>_rt_162 ;
  wire \Mcount_SecondCtr_cy<8>_rt_164 ;
  wire \Mcount_SecondCtr_cy<9>_rt_166 ;
  wire \Mcount_SecondCtr_xor<31>_rt_168 ;
  wire N0;
  wire N01;
  wire N1;
  wire N11;
  wire N13;
  wire N15;
  wire N17;
  wire N19;
  wire N2;
  wire N23;
  wire N3;
  wire N35;
  wire N37;
  wire N39;
  wire N41;
  wire N43;
  wire N44;
  wire N45;
  wire N46;
  wire N47;
  wire N48;
  wire N49;
  wire N50;
  wire N51;
  wire N52;
  wire SECCTR_OBUF_227;
  wire SECCTR_mux0000;
  wire SecondCtr_or0000;
  wire audio_out_2_OBUF_366;
  wire audio_out_3_OBUF_367;
  wire audio_out_4_OBUF_368;
  wire audio_out_5_OBUF_369;
  wire audio_out_6_OBUF_370;
  wire audio_out_7_OBUF_371;
  wire buffreq1;
  wire buffreq2;
  wire buffreq3;
  wire buffreq4;
  wire butt_3_IBUF_377;
  wire butt_4_IBUF_379;
  wire clk_BUFGP_381;
  wire \freqgen/Mrom__old_base_freq_2 ;
  wire \freqgen/Mrom__old_base_freq_21_429 ;
  wire \freqgen/Mrom__old_base_freq_210_430 ;
  wire \freqgen/Mrom__old_base_freq_2101_431 ;
  wire \freqgen/Mrom__old_base_freq_2102_432 ;
  wire \freqgen/Mrom__old_base_freq_210_f5_433 ;
  wire \freqgen/Mrom__old_base_freq_210_f51_434 ;
  wire \freqgen/Mrom__old_base_freq_210_f6_435 ;
  wire \freqgen/Mrom__old_base_freq_211_436 ;
  wire \freqgen/Mrom__old_base_freq_212_437 ;
  wire \freqgen/Mrom__old_base_freq_213_438 ;
  wire \freqgen/Mrom__old_base_freq_214_439 ;
  wire \freqgen/Mrom__old_base_freq_217 ;
  wire \freqgen/Mrom__old_base_freq_21_f5_441 ;
  wire \freqgen/Mrom__old_base_freq_21_f51 ;
  wire \freqgen/Mrom__old_base_freq_21_f6_443 ;
  wire \freqgen/Mrom__old_base_freq_22_444 ;
  wire \freqgen/Mrom__old_base_freq_221_445 ;
  wire \freqgen/Mrom__old_base_freq_222_446 ;
  wire \freqgen/Mrom__old_base_freq_223_447 ;
  wire \freqgen/Mrom__old_base_freq_224_448 ;
  wire \freqgen/Mrom__old_base_freq_22_f5_449 ;
  wire \freqgen/Mrom__old_base_freq_22_f51 ;
  wire \freqgen/Mrom__old_base_freq_22_f6_451 ;
  wire \freqgen/Mrom__old_base_freq_23_452 ;
  wire \freqgen/Mrom__old_base_freq_231_453 ;
  wire \freqgen/Mrom__old_base_freq_232_454 ;
  wire \freqgen/Mrom__old_base_freq_233_455 ;
  wire \freqgen/Mrom__old_base_freq_234_456 ;
  wire \freqgen/Mrom__old_base_freq_23_f5_457 ;
  wire \freqgen/Mrom__old_base_freq_23_f51 ;
  wire \freqgen/Mrom__old_base_freq_23_f6_459 ;
  wire \freqgen/Mrom__old_base_freq_24_460 ;
  wire \freqgen/Mrom__old_base_freq_241_461 ;
  wire \freqgen/Mrom__old_base_freq_242_462 ;
  wire \freqgen/Mrom__old_base_freq_243_463 ;
  wire \freqgen/Mrom__old_base_freq_24_f5_464 ;
  wire \freqgen/Mrom__old_base_freq_24_f51 ;
  wire \freqgen/Mrom__old_base_freq_24_f6_466 ;
  wire \freqgen/Mrom__old_base_freq_25 ;
  wire \freqgen/Mrom__old_base_freq_251_468 ;
  wire \freqgen/Mrom__old_base_freq_252_469 ;
  wire \freqgen/Mrom__old_base_freq_253_470 ;
  wire \freqgen/Mrom__old_base_freq_25_f5_471 ;
  wire \freqgen/Mrom__old_base_freq_25_f51 ;
  wire \freqgen/Mrom__old_base_freq_25_f6_473 ;
  wire \freqgen/Mrom__old_base_freq_261_474 ;
  wire \freqgen/Mrom__old_base_freq_262_475 ;
  wire \freqgen/Mrom__old_base_freq_263_476 ;
  wire \freqgen/Mrom__old_base_freq_26_f5_477 ;
  wire \freqgen/Mrom__old_base_freq_26_f51 ;
  wire \freqgen/Mrom__old_base_freq_26_f6_479 ;
  wire \freqgen/Mrom__old_base_freq_27_480 ;
  wire \freqgen/Mrom__old_base_freq_271_481 ;
  wire \freqgen/Mrom__old_base_freq_272_482 ;
  wire \freqgen/Mrom__old_base_freq_273_483 ;
  wire \freqgen/Mrom__old_base_freq_27_f5_484 ;
  wire \freqgen/Mrom__old_base_freq_27_f51 ;
  wire \freqgen/Mrom__old_base_freq_27_f6_486 ;
  wire \freqgen/Mrom__old_base_freq_28_487 ;
  wire \freqgen/Mrom__old_base_freq_281_488 ;
  wire \freqgen/Mrom__old_base_freq_282_489 ;
  wire \freqgen/Mrom__old_base_freq_283_490 ;
  wire \freqgen/Mrom__old_base_freq_28_f5_491 ;
  wire \freqgen/Mrom__old_base_freq_28_f51 ;
  wire \freqgen/Mrom__old_base_freq_28_f6_493 ;
  wire \freqgen/Mrom__old_base_freq_29 ;
  wire \freqgen/Mrom__old_base_freq_291_495 ;
  wire \freqgen/Mrom__old_base_freq_292_496 ;
  wire \freqgen/Mrom__old_base_freq_29_f5_497 ;
  wire \freqgen/Mrom__old_base_freq_29_f51 ;
  wire \freqgen/Mrom__old_base_freq_29_f5_0_499 ;
  wire \freqgen/Mrom__old_base_freq_29_f6_500 ;
  wire \freqgen/Mrom__old_base_freq_2_f5_501 ;
  wire \freqgen/Mrom__old_base_freq_2_f51 ;
  wire \freqgen/Mrom__old_base_freq_2_f6_503 ;
  wire \freqgen/N2 ;
  wire \freqgen/N3 ;
  wire \freqgen/N4_mand_506 ;
  wire \freqgen/N4_mand1 ;
  wire \freqgen/freq_out_555 ;
  wire \freqgen/freq_out_cmp_eq0000 ;
  wire \freqgen/freq_out_cmp_eq000023_557 ;
  wire \freqgen/freq_out_cmp_eq000047_558 ;
  wire \freqgen/freq_out_cmp_eq000060_559 ;
  wire \freqgen/freq_out_cmp_gt0000 ;
  wire \freqgen/freq_out_not0001 ;
  wire \freqgen2/freq_out_655 ;
  wire \freqgen2/freq_out_cmp_gt0000 ;
  wire \freqgen2/freq_out_not0001 ;
  wire \mixer/Madd__old_tempresult_6_lut<5>_SW0 ;
  wire \mixer/Madd_old_tempresult_6_addsub0001C ;
  wire \mixer/Madd_old_tempresult_6_addsub0001C2 ;
  wire \mixer/Madd_old_tempresult_6_addsub0001C3 ;
  wire \mixer/Madd_old_tempresult_6_addsub0001_Madd_cy[4] ;
  wire \mixer/Madd_old_tempresult_6_addsub0001_Madd_cy[6] ;
  wire \mixer/Mmux_ch4_3_676 ;
  wire \mixer/Mmux_ch4_31_677 ;
  wire \mixer/Mmux_ch4_4_678 ;
  wire \mixer/Mmux_ch4_41_679 ;
  wire \mixer/ch4<4>1_685 ;
  wire \mixer/ch4<4>2_686 ;
  wire \mixer/ch4<4>_bdd4 ;
  wire note_in_and0000;
  wire note_in_cmp_ge0000;
  wire \note_in_mux0000<2>1_716 ;
  wire \note_in_mux0000<2>2_717 ;
  wire \porta1/Madd__old_count_1_cy<10>_rt_723 ;
  wire \porta1/Madd__old_count_1_cy<11>_rt_725 ;
  wire \porta1/Madd__old_count_1_cy<12>_rt_727 ;
  wire \porta1/Madd__old_count_1_cy<13>_rt_729 ;
  wire \porta1/Madd__old_count_1_cy<14>_rt_731 ;
  wire \porta1/Madd__old_count_1_cy<15>_rt_733 ;
  wire \porta1/Madd__old_count_1_cy<16>_rt_735 ;
  wire \porta1/Madd__old_count_1_cy<17>_rt_737 ;
  wire \porta1/Madd__old_count_1_cy<18>_rt_739 ;
  wire \porta1/Madd__old_count_1_cy<19>_rt_741 ;
  wire \porta1/Madd__old_count_1_cy<1>_rt_743 ;
  wire \porta1/Madd__old_count_1_cy<20>_rt_745 ;
  wire \porta1/Madd__old_count_1_cy<21>_rt_747 ;
  wire \porta1/Madd__old_count_1_cy<22>_rt_749 ;
  wire \porta1/Madd__old_count_1_cy<23>_rt_751 ;
  wire \porta1/Madd__old_count_1_cy<24>_rt_753 ;
  wire \porta1/Madd__old_count_1_cy<25>_rt_755 ;
  wire \porta1/Madd__old_count_1_cy<26>_rt_757 ;
  wire \porta1/Madd__old_count_1_cy<27>_rt_759 ;
  wire \porta1/Madd__old_count_1_cy<28>_rt_761 ;
  wire \porta1/Madd__old_count_1_cy<29>_rt_763 ;
  wire \porta1/Madd__old_count_1_cy<2>_rt_765 ;
  wire \porta1/Madd__old_count_1_cy<30>_rt_767 ;
  wire \porta1/Madd__old_count_1_cy<3>_rt_769 ;
  wire \porta1/Madd__old_count_1_cy<4>_rt_771 ;
  wire \porta1/Madd__old_count_1_cy<5>_rt_773 ;
  wire \porta1/Madd__old_count_1_cy<6>_rt_775 ;
  wire \porta1/Madd__old_count_1_cy<7>_rt_777 ;
  wire \porta1/Madd__old_count_1_cy<8>_rt_779 ;
  wire \porta1/Madd__old_count_1_cy<9>_rt_781 ;
  wire \porta1/Madd__old_count_1_xor<31>_rt_783 ;
  wire \porta1/Maddsub_note_out_share0000_cy<0>_rt_785 ;
  wire \porta1/Maddsub_note_out_share0000_cy<1>_rt_787 ;
  wire \porta1/Maddsub_note_out_share0000_cy<2>_rt_789 ;
  wire \porta1/Maddsub_note_out_share0000_cy<3>_rt_791 ;
  wire \porta1/Maddsub_note_out_share0000_cy<4>_rt_793 ;
  wire \porta1/Maddsub_note_out_share0000_xor<5>_rt_794 ;
  wire \porta1/Mcompar_count_cmp_ge0000_cy<0>_rt_796 ;
  wire \porta1/Mcompar_count_cmp_ge0000_cy<4>_rt_801 ;
  wire \porta1/Mcompar_count_cmp_ge0000_lut[10] ;
  wire \porta1/Mcompar_count_cmp_ge0000_lut[1] ;
  wire \porta1/Mcompar_count_cmp_ge0000_lut[2] ;
  wire \porta1/Mcompar_count_cmp_ge0000_lut[3] ;
  wire \porta1/Mcompar_count_cmp_ge0000_lut[5] ;
  wire \porta1/Mcompar_count_cmp_ge0000_lut[6] ;
  wire \porta1/Mcompar_count_cmp_ge0000_lut[7] ;
  wire \porta1/Mcompar_count_cmp_ge0000_lut[8] ;
  wire \porta1/Mcompar_count_cmp_ge0000_lut[9] ;
  wire \porta1/Mcount_count_cy<10>_rt_829 ;
  wire \porta1/Mcount_count_cy<11>_rt_831 ;
  wire \porta1/Mcount_count_cy<12>_rt_833 ;
  wire \porta1/Mcount_count_cy<13>_rt_835 ;
  wire \porta1/Mcount_count_cy<14>_rt_837 ;
  wire \porta1/Mcount_count_cy<15>_rt_839 ;
  wire \porta1/Mcount_count_cy<16>_rt_841 ;
  wire \porta1/Mcount_count_cy<17>_rt_843 ;
  wire \porta1/Mcount_count_cy<18>_rt_845 ;
  wire \porta1/Mcount_count_cy<19>_rt_847 ;
  wire \porta1/Mcount_count_cy<1>_rt_849 ;
  wire \porta1/Mcount_count_cy<20>_rt_851 ;
  wire \porta1/Mcount_count_cy<21>_rt_853 ;
  wire \porta1/Mcount_count_cy<22>_rt_855 ;
  wire \porta1/Mcount_count_cy<23>_rt_857 ;
  wire \porta1/Mcount_count_cy<24>_rt_859 ;
  wire \porta1/Mcount_count_cy<25>_rt_861 ;
  wire \porta1/Mcount_count_cy<26>_rt_863 ;
  wire \porta1/Mcount_count_cy<27>_rt_865 ;
  wire \porta1/Mcount_count_cy<28>_rt_867 ;
  wire \porta1/Mcount_count_cy<29>_rt_869 ;
  wire \porta1/Mcount_count_cy<2>_rt_871 ;
  wire \porta1/Mcount_count_cy<30>_rt_873 ;
  wire \porta1/Mcount_count_cy<3>_rt_875 ;
  wire \porta1/Mcount_count_cy<4>_rt_877 ;
  wire \porta1/Mcount_count_cy<5>_rt_879 ;
  wire \porta1/Mcount_count_cy<6>_rt_881 ;
  wire \porta1/Mcount_count_cy<7>_rt_883 ;
  wire \porta1/Mcount_count_cy<8>_rt_885 ;
  wire \porta1/Mcount_count_cy<9>_rt_887 ;
  wire \porta1/Mcount_count_xor<31>_rt_889 ;
  wire \porta1/count_cmp_ge0000 ;
  wire \porta1/en_flag_983 ;
  wire \porta1/en_flag_inv ;
  wire \porta1/en_inv ;
  wire \porta1/note_clk_986 ;
  wire \porta1/note_clk_not0001 ;
  wire \porta1/note_out_cmp_ge0000 ;
  wire \porta1/note_out_not0001 ;
  wire porta_en_1008;
  wire porta_en_mux0000_1009;
  wire \sqgen1/Madd_count_add0000_xor<1>11 ;
  wire \sqgen1/Madd_count_add0000_xor<2>11 ;
  wire \sqgen1/Madd_count_add0000_xor<4>11 ;
  wire \sqgen1/count_add0000[0] ;
  wire \sqgen1/count_add0000[3] ;
  wire \sqgen1/square_out_cmp_eq0000 ;
  wire \sqgen2/Madd_count_add0000_xor<1>11 ;
  wire \sqgen2/Madd_count_add0000_xor<2>11 ;
  wire \sqgen2/Madd_count_add0000_xor<4>11 ;
  wire \sqgen2/count_add0000[0] ;
  wire \sqgen2/count_add0000[3] ;
  wire \sqgen2/square_out_cmp_eq0000 ;
  wire \trgen1/_old_count_5<3>1_1038 ;
  wire \trgen1/_old_count_5<3>2_1039 ;
  wire \trgen1/triangle_out_mux0000<0>1 ;
  wire \trgen1/triangle_out_mux0000<1>1 ;
  wire \trgen1/triangle_out_mux0000<2>1 ;
  wire \trgen1/triangle_out_mux0000<3>1 ;
  wire \trgen2/_old_count_5<3>1_1060 ;
  wire \trgen2/_old_count_5<3>2_1061 ;
  wire \trgen2/triangle_out_mux0000<0>1 ;
  wire \trgen2/triangle_out_mux0000<1>1 ;
  wire \trgen2/triangle_out_mux0000<2>1 ;
  wire \trgen2/triangle_out_mux0000<3>1 ;
  wire volsel_0_IBUF_1080;
  wire volsel_1_IBUF_1081;
  wire [30 : 0] Madd_StateCtr_addsub0000_cy;
  wire [0 : 0] Madd_StateCtr_addsub0000_lut;
  wire [9 : 0] Mcompar_StateCtr_cmp_gt0000_cy;
  wire [10 : 0] Mcompar_note_in_cmp_ge0000_cy;
  wire [30 : 0] Mcount_SecondCtr_cy;
  wire [0 : 0] Mcount_SecondCtr_lut;
  wire [31 : 0] Result;
  wire [31 : 0] SecondCtr;
  wire [31 : 0] StateCtr;
  wire [31 : 0] StateCtr_addsub0000;
  wire [31 : 0] StateCtr_mux0000;
  wire [14 : 0] \freqgen/Madd_count_add0000_cy ;
  wire [0 : 0] \freqgen/Madd_count_add0000_lut ;
  wire [14 : 0] \freqgen/Mcompar_freq_out_cmp_gt0000_cy ;
  wire [14 : 0] \freqgen/Mcompar_freq_out_cmp_gt0000_lut ;
  wire [15 : 1] \freqgen/_old_count_3 ;
  wire [15 : 0] \freqgen/count ;
  wire [15 : 0] \freqgen/count_add0000 ;
  wire [14 : 0] \freqgen2/Madd_count_add0000_cy ;
  wire [0 : 0] \freqgen2/Madd_count_add0000_lut ;
  wire [14 : 0] \freqgen2/Mcompar_freq_out_cmp_gt0000_cy ;
  wire [14 : 0] \freqgen2/Mcompar_freq_out_cmp_gt0000_lut ;
  wire [15 : 1] \freqgen2/_old_count_3 ;
  wire [15 : 0] \freqgen2/count ;
  wire [15 : 0] \freqgen2/count_add0000 ;
  wire [6 : 2] \mixer/Madd__old_tempresult_6_cy ;
  wire [5 : 2] \mixer/Madd__old_tempresult_6_lut ;
  wire [5 : 3] \mixer/Madd_old_tempresult_6_addsub0001_Madd_lut ;
  wire [4 : 0] \mixer/ch4 ;
  wire [3 : 3] \mixer/ch4_addsub0000 ;
  wire [6 : 4] \mixer/old_tempresult_6_addsub0001 ;
  wire [5 : 0] note_in;
  wire [5 : 0] note_in_and0000_wg_cy;
  wire [6 : 0] note_in_and0000_wg_lut;
  wire [5 : 0] note_in_mux0000;
  wire [30 : 0] \porta1/Madd__old_count_1_cy ;
  wire [0 : 0] \porta1/Madd__old_count_1_lut ;
  wire [4 : 0] \porta1/Maddsub_note_out_share0000_cy ;
  wire [9 : 0] \porta1/Mcompar_count_cmp_ge0000_cy ;
  wire [4 : 0] \porta1/Mcompar_note_out_cmp_ge0000_cy ;
  wire [5 : 0] \porta1/Mcompar_note_out_cmp_ge0000_lut ;
  wire [30 : 0] \porta1/Mcount_count_cy ;
  wire [0 : 0] \porta1/Mcount_count_lut ;
  wire [31 : 0] \porta1/Result ;
  wire [31 : 4] \porta1/_old_count_1 ;
  wire [31 : 0] \porta1/count ;
  wire [5 : 0] \porta1/note_out ;
  wire [5 : 0] \porta1/note_out_mux0000 ;
  wire [5 : 0] \porta1/note_out_share0000 ;
  wire [4 : 0] \sqgen1/count ;
  wire [0 : 0] \sqgen1/square_out ;
  wire [4 : 0] \sqgen2/count ;
  wire [0 : 0] \sqgen2/square_out ;
  wire [5 : 0] \trgen1/_old_count_5 ;
  wire [5 : 0] \trgen1/count ;
  wire [3 : 0] \trgen1/triangle_out ;
  wire [5 : 0] \trgen2/_old_count_5 ;
  wire [5 : 0] \trgen2/count ;
  wire [3 : 0] \trgen2/triangle_out ;
  GND   XST_GND (
    .G(N0)
  );
  VCC   XST_VCC (
    .P(N1)
  );
  FDE #(
    .INIT ( 1'b0 ))
  SECCTR_3 (
    .C(clk_BUFGP_381),
    .CE(SecondCtr_or0000),
    .D(SECCTR_mux0000),
    .Q(SECCTR_OBUF_227)
  );
  FDE #(
    .INIT ( 1'b1 ))
  note_in_0 (
    .C(clk_BUFGP_381),
    .CE(note_in_cmp_ge0000),
    .D(note_in_mux0000[5]),
    .Q(note_in[0])
  );
  FDE #(
    .INIT ( 1'b1 ))
  note_in_1 (
    .C(clk_BUFGP_381),
    .CE(note_in_cmp_ge0000),
    .D(note_in_mux0000[4]),
    .Q(note_in[1])
  );
  FDE #(
    .INIT ( 1'b1 ))
  note_in_2 (
    .C(clk_BUFGP_381),
    .CE(note_in_cmp_ge0000),
    .D(note_in_mux0000[3]),
    .Q(note_in[2])
  );
  FDE #(
    .INIT ( 1'b1 ))
  note_in_3 (
    .C(clk_BUFGP_381),
    .CE(note_in_cmp_ge0000),
    .D(note_in_mux0000[2]),
    .Q(note_in[3])
  );
  FDE #(
    .INIT ( 1'b1 ))
  note_in_4 (
    .C(clk_BUFGP_381),
    .CE(note_in_cmp_ge0000),
    .D(note_in_mux0000[1]),
    .Q(note_in[4])
  );
  FDE #(
    .INIT ( 1'b0 ))
  note_in_5 (
    .C(clk_BUFGP_381),
    .CE(note_in_cmp_ge0000),
    .D(note_in_mux0000[0]),
    .Q(note_in[5])
  );
  FDE #(
    .INIT ( 1'b0 ))
  porta_en (
    .C(clk_BUFGP_381),
    .CE(note_in_cmp_ge0000),
    .D(porta_en_mux0000_1009),
    .Q(porta_en_1008)
  );
  FDE #(
    .INIT ( 1'b0 ))
  StateCtr_0 (
    .C(clk_BUFGP_381),
    .CE(SecondCtr_or0000),
    .D(StateCtr_mux0000[31]),
    .Q(StateCtr[0])
  );
  FDE #(
    .INIT ( 1'b0 ))
  StateCtr_1 (
    .C(clk_BUFGP_381),
    .CE(SecondCtr_or0000),
    .D(StateCtr_mux0000[30]),
    .Q(StateCtr[1])
  );
  FDE #(
    .INIT ( 1'b0 ))
  StateCtr_2 (
    .C(clk_BUFGP_381),
    .CE(SecondCtr_or0000),
    .D(StateCtr_mux0000[29]),
    .Q(StateCtr[2])
  );
  FDE #(
    .INIT ( 1'b0 ))
  StateCtr_3 (
    .C(clk_BUFGP_381),
    .CE(SecondCtr_or0000),
    .D(StateCtr_mux0000[28]),
    .Q(StateCtr[3])
  );
  FDE #(
    .INIT ( 1'b0 ))
  StateCtr_4 (
    .C(clk_BUFGP_381),
    .CE(SecondCtr_or0000),
    .D(StateCtr_mux0000[27]),
    .Q(StateCtr[4])
  );
  FDE #(
    .INIT ( 1'b0 ))
  StateCtr_5 (
    .C(clk_BUFGP_381),
    .CE(SecondCtr_or0000),
    .D(StateCtr_mux0000[26]),
    .Q(StateCtr[5])
  );
  FDE #(
    .INIT ( 1'b0 ))
  StateCtr_6 (
    .C(clk_BUFGP_381),
    .CE(SecondCtr_or0000),
    .D(StateCtr_mux0000[25]),
    .Q(StateCtr[6])
  );
  FDE #(
    .INIT ( 1'b0 ))
  StateCtr_7 (
    .C(clk_BUFGP_381),
    .CE(SecondCtr_or0000),
    .D(StateCtr_mux0000[24]),
    .Q(StateCtr[7])
  );
  FDE #(
    .INIT ( 1'b0 ))
  StateCtr_8 (
    .C(clk_BUFGP_381),
    .CE(SecondCtr_or0000),
    .D(StateCtr_mux0000[23]),
    .Q(StateCtr[8])
  );
  FDE #(
    .INIT ( 1'b0 ))
  StateCtr_9 (
    .C(clk_BUFGP_381),
    .CE(SecondCtr_or0000),
    .D(StateCtr_mux0000[22]),
    .Q(StateCtr[9])
  );
  FDE #(
    .INIT ( 1'b0 ))
  StateCtr_10 (
    .C(clk_BUFGP_381),
    .CE(SecondCtr_or0000),
    .D(StateCtr_mux0000[21]),
    .Q(StateCtr[10])
  );
  FDE #(
    .INIT ( 1'b0 ))
  StateCtr_11 (
    .C(clk_BUFGP_381),
    .CE(SecondCtr_or0000),
    .D(StateCtr_mux0000[20]),
    .Q(StateCtr[11])
  );
  FDE #(
    .INIT ( 1'b0 ))
  StateCtr_12 (
    .C(clk_BUFGP_381),
    .CE(SecondCtr_or0000),
    .D(StateCtr_mux0000[19]),
    .Q(StateCtr[12])
  );
  FDE #(
    .INIT ( 1'b0 ))
  StateCtr_13 (
    .C(clk_BUFGP_381),
    .CE(SecondCtr_or0000),
    .D(StateCtr_mux0000[18]),
    .Q(StateCtr[13])
  );
  FDE #(
    .INIT ( 1'b0 ))
  StateCtr_14 (
    .C(clk_BUFGP_381),
    .CE(SecondCtr_or0000),
    .D(StateCtr_mux0000[17]),
    .Q(StateCtr[14])
  );
  FDE #(
    .INIT ( 1'b0 ))
  StateCtr_15 (
    .C(clk_BUFGP_381),
    .CE(SecondCtr_or0000),
    .D(StateCtr_mux0000[16]),
    .Q(StateCtr[15])
  );
  FDE #(
    .INIT ( 1'b0 ))
  StateCtr_16 (
    .C(clk_BUFGP_381),
    .CE(SecondCtr_or0000),
    .D(StateCtr_mux0000[15]),
    .Q(StateCtr[16])
  );
  FDE #(
    .INIT ( 1'b0 ))
  StateCtr_17 (
    .C(clk_BUFGP_381),
    .CE(SecondCtr_or0000),
    .D(StateCtr_mux0000[14]),
    .Q(StateCtr[17])
  );
  FDE #(
    .INIT ( 1'b0 ))
  StateCtr_18 (
    .C(clk_BUFGP_381),
    .CE(SecondCtr_or0000),
    .D(StateCtr_mux0000[13]),
    .Q(StateCtr[18])
  );
  FDE #(
    .INIT ( 1'b0 ))
  StateCtr_19 (
    .C(clk_BUFGP_381),
    .CE(SecondCtr_or0000),
    .D(StateCtr_mux0000[12]),
    .Q(StateCtr[19])
  );
  FDE #(
    .INIT ( 1'b0 ))
  StateCtr_20 (
    .C(clk_BUFGP_381),
    .CE(SecondCtr_or0000),
    .D(StateCtr_mux0000[11]),
    .Q(StateCtr[20])
  );
  FDE #(
    .INIT ( 1'b0 ))
  StateCtr_21 (
    .C(clk_BUFGP_381),
    .CE(SecondCtr_or0000),
    .D(StateCtr_mux0000[10]),
    .Q(StateCtr[21])
  );
  FDE #(
    .INIT ( 1'b0 ))
  StateCtr_22 (
    .C(clk_BUFGP_381),
    .CE(SecondCtr_or0000),
    .D(StateCtr_mux0000[9]),
    .Q(StateCtr[22])
  );
  FDE #(
    .INIT ( 1'b0 ))
  StateCtr_23 (
    .C(clk_BUFGP_381),
    .CE(SecondCtr_or0000),
    .D(StateCtr_mux0000[8]),
    .Q(StateCtr[23])
  );
  FDE #(
    .INIT ( 1'b0 ))
  StateCtr_24 (
    .C(clk_BUFGP_381),
    .CE(SecondCtr_or0000),
    .D(StateCtr_mux0000[7]),
    .Q(StateCtr[24])
  );
  FDE #(
    .INIT ( 1'b0 ))
  StateCtr_25 (
    .C(clk_BUFGP_381),
    .CE(SecondCtr_or0000),
    .D(StateCtr_mux0000[6]),
    .Q(StateCtr[25])
  );
  FDE #(
    .INIT ( 1'b0 ))
  StateCtr_26 (
    .C(clk_BUFGP_381),
    .CE(SecondCtr_or0000),
    .D(StateCtr_mux0000[5]),
    .Q(StateCtr[26])
  );
  FDE #(
    .INIT ( 1'b0 ))
  StateCtr_27 (
    .C(clk_BUFGP_381),
    .CE(SecondCtr_or0000),
    .D(StateCtr_mux0000[4]),
    .Q(StateCtr[27])
  );
  FDE #(
    .INIT ( 1'b0 ))
  StateCtr_28 (
    .C(clk_BUFGP_381),
    .CE(SecondCtr_or0000),
    .D(StateCtr_mux0000[3]),
    .Q(StateCtr[28])
  );
  FDE #(
    .INIT ( 1'b0 ))
  StateCtr_29 (
    .C(clk_BUFGP_381),
    .CE(SecondCtr_or0000),
    .D(StateCtr_mux0000[2]),
    .Q(StateCtr[29])
  );
  FDE #(
    .INIT ( 1'b0 ))
  StateCtr_30 (
    .C(clk_BUFGP_381),
    .CE(SecondCtr_or0000),
    .D(StateCtr_mux0000[1]),
    .Q(StateCtr[30])
  );
  FDE #(
    .INIT ( 1'b0 ))
  StateCtr_31 (
    .C(clk_BUFGP_381),
    .CE(SecondCtr_or0000),
    .D(StateCtr_mux0000[0]),
    .Q(StateCtr[31])
  );
  FDR #(
    .INIT ( 1'b0 ))
  SecondCtr_0 (
    .C(clk_BUFGP_381),
    .D(Result[0]),
    .R(SecondCtr_or0000),
    .Q(SecondCtr[0])
  );
  FDR #(
    .INIT ( 1'b0 ))
  SecondCtr_1 (
    .C(clk_BUFGP_381),
    .D(Result[1]),
    .R(SecondCtr_or0000),
    .Q(SecondCtr[1])
  );
  FDR #(
    .INIT ( 1'b0 ))
  SecondCtr_2 (
    .C(clk_BUFGP_381),
    .D(Result[2]),
    .R(SecondCtr_or0000),
    .Q(SecondCtr[2])
  );
  FDR #(
    .INIT ( 1'b0 ))
  SecondCtr_3 (
    .C(clk_BUFGP_381),
    .D(Result[3]),
    .R(SecondCtr_or0000),
    .Q(SecondCtr[3])
  );
  FDR #(
    .INIT ( 1'b0 ))
  SecondCtr_4 (
    .C(clk_BUFGP_381),
    .D(Result[4]),
    .R(SecondCtr_or0000),
    .Q(SecondCtr[4])
  );
  FDR #(
    .INIT ( 1'b0 ))
  SecondCtr_5 (
    .C(clk_BUFGP_381),
    .D(Result[5]),
    .R(SecondCtr_or0000),
    .Q(SecondCtr[5])
  );
  FDR #(
    .INIT ( 1'b0 ))
  SecondCtr_6 (
    .C(clk_BUFGP_381),
    .D(Result[6]),
    .R(SecondCtr_or0000),
    .Q(SecondCtr[6])
  );
  FDR #(
    .INIT ( 1'b0 ))
  SecondCtr_7 (
    .C(clk_BUFGP_381),
    .D(Result[7]),
    .R(SecondCtr_or0000),
    .Q(SecondCtr[7])
  );
  FDR #(
    .INIT ( 1'b0 ))
  SecondCtr_8 (
    .C(clk_BUFGP_381),
    .D(Result[8]),
    .R(SecondCtr_or0000),
    .Q(SecondCtr[8])
  );
  FDR #(
    .INIT ( 1'b0 ))
  SecondCtr_9 (
    .C(clk_BUFGP_381),
    .D(Result[9]),
    .R(SecondCtr_or0000),
    .Q(SecondCtr[9])
  );
  FDR #(
    .INIT ( 1'b0 ))
  SecondCtr_10 (
    .C(clk_BUFGP_381),
    .D(Result[10]),
    .R(SecondCtr_or0000),
    .Q(SecondCtr[10])
  );
  FDR #(
    .INIT ( 1'b0 ))
  SecondCtr_11 (
    .C(clk_BUFGP_381),
    .D(Result[11]),
    .R(SecondCtr_or0000),
    .Q(SecondCtr[11])
  );
  FDR #(
    .INIT ( 1'b0 ))
  SecondCtr_12 (
    .C(clk_BUFGP_381),
    .D(Result[12]),
    .R(SecondCtr_or0000),
    .Q(SecondCtr[12])
  );
  FDR #(
    .INIT ( 1'b0 ))
  SecondCtr_13 (
    .C(clk_BUFGP_381),
    .D(Result[13]),
    .R(SecondCtr_or0000),
    .Q(SecondCtr[13])
  );
  FDR #(
    .INIT ( 1'b0 ))
  SecondCtr_14 (
    .C(clk_BUFGP_381),
    .D(Result[14]),
    .R(SecondCtr_or0000),
    .Q(SecondCtr[14])
  );
  FDR #(
    .INIT ( 1'b0 ))
  SecondCtr_15 (
    .C(clk_BUFGP_381),
    .D(Result[15]),
    .R(SecondCtr_or0000),
    .Q(SecondCtr[15])
  );
  FDR #(
    .INIT ( 1'b0 ))
  SecondCtr_16 (
    .C(clk_BUFGP_381),
    .D(Result[16]),
    .R(SecondCtr_or0000),
    .Q(SecondCtr[16])
  );
  FDR #(
    .INIT ( 1'b0 ))
  SecondCtr_17 (
    .C(clk_BUFGP_381),
    .D(Result[17]),
    .R(SecondCtr_or0000),
    .Q(SecondCtr[17])
  );
  FDR #(
    .INIT ( 1'b0 ))
  SecondCtr_18 (
    .C(clk_BUFGP_381),
    .D(Result[18]),
    .R(SecondCtr_or0000),
    .Q(SecondCtr[18])
  );
  FDR #(
    .INIT ( 1'b0 ))
  SecondCtr_19 (
    .C(clk_BUFGP_381),
    .D(Result[19]),
    .R(SecondCtr_or0000),
    .Q(SecondCtr[19])
  );
  FDR #(
    .INIT ( 1'b0 ))
  SecondCtr_20 (
    .C(clk_BUFGP_381),
    .D(Result[20]),
    .R(SecondCtr_or0000),
    .Q(SecondCtr[20])
  );
  FDR #(
    .INIT ( 1'b0 ))
  SecondCtr_21 (
    .C(clk_BUFGP_381),
    .D(Result[21]),
    .R(SecondCtr_or0000),
    .Q(SecondCtr[21])
  );
  FDR #(
    .INIT ( 1'b0 ))
  SecondCtr_22 (
    .C(clk_BUFGP_381),
    .D(Result[22]),
    .R(SecondCtr_or0000),
    .Q(SecondCtr[22])
  );
  FDR #(
    .INIT ( 1'b0 ))
  SecondCtr_23 (
    .C(clk_BUFGP_381),
    .D(Result[23]),
    .R(SecondCtr_or0000),
    .Q(SecondCtr[23])
  );
  FDR #(
    .INIT ( 1'b0 ))
  SecondCtr_24 (
    .C(clk_BUFGP_381),
    .D(Result[24]),
    .R(SecondCtr_or0000),
    .Q(SecondCtr[24])
  );
  FDR #(
    .INIT ( 1'b0 ))
  SecondCtr_25 (
    .C(clk_BUFGP_381),
    .D(Result[25]),
    .R(SecondCtr_or0000),
    .Q(SecondCtr[25])
  );
  FDR #(
    .INIT ( 1'b0 ))
  SecondCtr_26 (
    .C(clk_BUFGP_381),
    .D(Result[26]),
    .R(SecondCtr_or0000),
    .Q(SecondCtr[26])
  );
  FDR #(
    .INIT ( 1'b0 ))
  SecondCtr_27 (
    .C(clk_BUFGP_381),
    .D(Result[27]),
    .R(SecondCtr_or0000),
    .Q(SecondCtr[27])
  );
  FDR #(
    .INIT ( 1'b0 ))
  SecondCtr_28 (
    .C(clk_BUFGP_381),
    .D(Result[28]),
    .R(SecondCtr_or0000),
    .Q(SecondCtr[28])
  );
  FDR #(
    .INIT ( 1'b0 ))
  SecondCtr_29 (
    .C(clk_BUFGP_381),
    .D(Result[29]),
    .R(SecondCtr_or0000),
    .Q(SecondCtr[29])
  );
  FDR #(
    .INIT ( 1'b0 ))
  SecondCtr_30 (
    .C(clk_BUFGP_381),
    .D(Result[30]),
    .R(SecondCtr_or0000),
    .Q(SecondCtr[30])
  );
  FDR #(
    .INIT ( 1'b0 ))
  SecondCtr_31 (
    .C(clk_BUFGP_381),
    .D(Result[31]),
    .R(SecondCtr_or0000),
    .Q(SecondCtr[31])
  );
  MUXCY   \Madd_StateCtr_addsub0000_cy<0>  (
    .CI(N0),
    .DI(N1),
    .S(Madd_StateCtr_addsub0000_lut[0]),
    .O(Madd_StateCtr_addsub0000_cy[0])
  );
  XORCY   \Madd_StateCtr_addsub0000_xor<0>  (
    .CI(N0),
    .LI(Madd_StateCtr_addsub0000_lut[0]),
    .O(StateCtr_addsub0000[0])
  );
  MUXCY   \Madd_StateCtr_addsub0000_cy<1>  (
    .CI(Madd_StateCtr_addsub0000_cy[0]),
    .DI(N0),
    .S(\Madd_StateCtr_addsub0000_cy<1>_rt_22 ),
    .O(Madd_StateCtr_addsub0000_cy[1])
  );
  XORCY   \Madd_StateCtr_addsub0000_xor<1>  (
    .CI(Madd_StateCtr_addsub0000_cy[0]),
    .LI(\Madd_StateCtr_addsub0000_cy<1>_rt_22 ),
    .O(StateCtr_addsub0000[1])
  );
  MUXCY   \Madd_StateCtr_addsub0000_cy<2>  (
    .CI(Madd_StateCtr_addsub0000_cy[1]),
    .DI(N0),
    .S(\Madd_StateCtr_addsub0000_cy<2>_rt_44 ),
    .O(Madd_StateCtr_addsub0000_cy[2])
  );
  XORCY   \Madd_StateCtr_addsub0000_xor<2>  (
    .CI(Madd_StateCtr_addsub0000_cy[1]),
    .LI(\Madd_StateCtr_addsub0000_cy<2>_rt_44 ),
    .O(StateCtr_addsub0000[2])
  );
  MUXCY   \Madd_StateCtr_addsub0000_cy<3>  (
    .CI(Madd_StateCtr_addsub0000_cy[2]),
    .DI(N0),
    .S(\Madd_StateCtr_addsub0000_cy<3>_rt_48 ),
    .O(Madd_StateCtr_addsub0000_cy[3])
  );
  XORCY   \Madd_StateCtr_addsub0000_xor<3>  (
    .CI(Madd_StateCtr_addsub0000_cy[2]),
    .LI(\Madd_StateCtr_addsub0000_cy<3>_rt_48 ),
    .O(StateCtr_addsub0000[3])
  );
  MUXCY   \Madd_StateCtr_addsub0000_cy<4>  (
    .CI(Madd_StateCtr_addsub0000_cy[3]),
    .DI(N0),
    .S(\Madd_StateCtr_addsub0000_cy<4>_rt_50 ),
    .O(Madd_StateCtr_addsub0000_cy[4])
  );
  XORCY   \Madd_StateCtr_addsub0000_xor<4>  (
    .CI(Madd_StateCtr_addsub0000_cy[3]),
    .LI(\Madd_StateCtr_addsub0000_cy<4>_rt_50 ),
    .O(StateCtr_addsub0000[4])
  );
  MUXCY   \Madd_StateCtr_addsub0000_cy<5>  (
    .CI(Madd_StateCtr_addsub0000_cy[4]),
    .DI(N0),
    .S(\Madd_StateCtr_addsub0000_cy<5>_rt_52 ),
    .O(Madd_StateCtr_addsub0000_cy[5])
  );
  XORCY   \Madd_StateCtr_addsub0000_xor<5>  (
    .CI(Madd_StateCtr_addsub0000_cy[4]),
    .LI(\Madd_StateCtr_addsub0000_cy<5>_rt_52 ),
    .O(StateCtr_addsub0000[5])
  );
  MUXCY   \Madd_StateCtr_addsub0000_cy<6>  (
    .CI(Madd_StateCtr_addsub0000_cy[5]),
    .DI(N0),
    .S(\Madd_StateCtr_addsub0000_cy<6>_rt_54 ),
    .O(Madd_StateCtr_addsub0000_cy[6])
  );
  XORCY   \Madd_StateCtr_addsub0000_xor<6>  (
    .CI(Madd_StateCtr_addsub0000_cy[5]),
    .LI(\Madd_StateCtr_addsub0000_cy<6>_rt_54 ),
    .O(StateCtr_addsub0000[6])
  );
  MUXCY   \Madd_StateCtr_addsub0000_cy<7>  (
    .CI(Madd_StateCtr_addsub0000_cy[6]),
    .DI(N0),
    .S(\Madd_StateCtr_addsub0000_cy<7>_rt_56 ),
    .O(Madd_StateCtr_addsub0000_cy[7])
  );
  XORCY   \Madd_StateCtr_addsub0000_xor<7>  (
    .CI(Madd_StateCtr_addsub0000_cy[6]),
    .LI(\Madd_StateCtr_addsub0000_cy<7>_rt_56 ),
    .O(StateCtr_addsub0000[7])
  );
  MUXCY   \Madd_StateCtr_addsub0000_cy<8>  (
    .CI(Madd_StateCtr_addsub0000_cy[7]),
    .DI(N0),
    .S(\Madd_StateCtr_addsub0000_cy<8>_rt_58 ),
    .O(Madd_StateCtr_addsub0000_cy[8])
  );
  XORCY   \Madd_StateCtr_addsub0000_xor<8>  (
    .CI(Madd_StateCtr_addsub0000_cy[7]),
    .LI(\Madd_StateCtr_addsub0000_cy<8>_rt_58 ),
    .O(StateCtr_addsub0000[8])
  );
  MUXCY   \Madd_StateCtr_addsub0000_cy<9>  (
    .CI(Madd_StateCtr_addsub0000_cy[8]),
    .DI(N0),
    .S(\Madd_StateCtr_addsub0000_cy<9>_rt_60 ),
    .O(Madd_StateCtr_addsub0000_cy[9])
  );
  XORCY   \Madd_StateCtr_addsub0000_xor<9>  (
    .CI(Madd_StateCtr_addsub0000_cy[8]),
    .LI(\Madd_StateCtr_addsub0000_cy<9>_rt_60 ),
    .O(StateCtr_addsub0000[9])
  );
  MUXCY   \Madd_StateCtr_addsub0000_cy<10>  (
    .CI(Madd_StateCtr_addsub0000_cy[9]),
    .DI(N0),
    .S(\Madd_StateCtr_addsub0000_cy<10>_rt_2 ),
    .O(Madd_StateCtr_addsub0000_cy[10])
  );
  XORCY   \Madd_StateCtr_addsub0000_xor<10>  (
    .CI(Madd_StateCtr_addsub0000_cy[9]),
    .LI(\Madd_StateCtr_addsub0000_cy<10>_rt_2 ),
    .O(StateCtr_addsub0000[10])
  );
  MUXCY   \Madd_StateCtr_addsub0000_cy<11>  (
    .CI(Madd_StateCtr_addsub0000_cy[10]),
    .DI(N0),
    .S(\Madd_StateCtr_addsub0000_cy<11>_rt_4 ),
    .O(Madd_StateCtr_addsub0000_cy[11])
  );
  XORCY   \Madd_StateCtr_addsub0000_xor<11>  (
    .CI(Madd_StateCtr_addsub0000_cy[10]),
    .LI(\Madd_StateCtr_addsub0000_cy<11>_rt_4 ),
    .O(StateCtr_addsub0000[11])
  );
  MUXCY   \Madd_StateCtr_addsub0000_cy<12>  (
    .CI(Madd_StateCtr_addsub0000_cy[11]),
    .DI(N0),
    .S(\Madd_StateCtr_addsub0000_cy<12>_rt_6 ),
    .O(Madd_StateCtr_addsub0000_cy[12])
  );
  XORCY   \Madd_StateCtr_addsub0000_xor<12>  (
    .CI(Madd_StateCtr_addsub0000_cy[11]),
    .LI(\Madd_StateCtr_addsub0000_cy<12>_rt_6 ),
    .O(StateCtr_addsub0000[12])
  );
  MUXCY   \Madd_StateCtr_addsub0000_cy<13>  (
    .CI(Madd_StateCtr_addsub0000_cy[12]),
    .DI(N0),
    .S(\Madd_StateCtr_addsub0000_cy<13>_rt_8 ),
    .O(Madd_StateCtr_addsub0000_cy[13])
  );
  XORCY   \Madd_StateCtr_addsub0000_xor<13>  (
    .CI(Madd_StateCtr_addsub0000_cy[12]),
    .LI(\Madd_StateCtr_addsub0000_cy<13>_rt_8 ),
    .O(StateCtr_addsub0000[13])
  );
  MUXCY   \Madd_StateCtr_addsub0000_cy<14>  (
    .CI(Madd_StateCtr_addsub0000_cy[13]),
    .DI(N0),
    .S(\Madd_StateCtr_addsub0000_cy<14>_rt_10 ),
    .O(Madd_StateCtr_addsub0000_cy[14])
  );
  XORCY   \Madd_StateCtr_addsub0000_xor<14>  (
    .CI(Madd_StateCtr_addsub0000_cy[13]),
    .LI(\Madd_StateCtr_addsub0000_cy<14>_rt_10 ),
    .O(StateCtr_addsub0000[14])
  );
  MUXCY   \Madd_StateCtr_addsub0000_cy<15>  (
    .CI(Madd_StateCtr_addsub0000_cy[14]),
    .DI(N0),
    .S(\Madd_StateCtr_addsub0000_cy<15>_rt_12 ),
    .O(Madd_StateCtr_addsub0000_cy[15])
  );
  XORCY   \Madd_StateCtr_addsub0000_xor<15>  (
    .CI(Madd_StateCtr_addsub0000_cy[14]),
    .LI(\Madd_StateCtr_addsub0000_cy<15>_rt_12 ),
    .O(StateCtr_addsub0000[15])
  );
  MUXCY   \Madd_StateCtr_addsub0000_cy<16>  (
    .CI(Madd_StateCtr_addsub0000_cy[15]),
    .DI(N0),
    .S(\Madd_StateCtr_addsub0000_cy<16>_rt_14 ),
    .O(Madd_StateCtr_addsub0000_cy[16])
  );
  XORCY   \Madd_StateCtr_addsub0000_xor<16>  (
    .CI(Madd_StateCtr_addsub0000_cy[15]),
    .LI(\Madd_StateCtr_addsub0000_cy<16>_rt_14 ),
    .O(StateCtr_addsub0000[16])
  );
  MUXCY   \Madd_StateCtr_addsub0000_cy<17>  (
    .CI(Madd_StateCtr_addsub0000_cy[16]),
    .DI(N0),
    .S(\Madd_StateCtr_addsub0000_cy<17>_rt_16 ),
    .O(Madd_StateCtr_addsub0000_cy[17])
  );
  XORCY   \Madd_StateCtr_addsub0000_xor<17>  (
    .CI(Madd_StateCtr_addsub0000_cy[16]),
    .LI(\Madd_StateCtr_addsub0000_cy<17>_rt_16 ),
    .O(StateCtr_addsub0000[17])
  );
  MUXCY   \Madd_StateCtr_addsub0000_cy<18>  (
    .CI(Madd_StateCtr_addsub0000_cy[17]),
    .DI(N0),
    .S(\Madd_StateCtr_addsub0000_cy<18>_rt_18 ),
    .O(Madd_StateCtr_addsub0000_cy[18])
  );
  XORCY   \Madd_StateCtr_addsub0000_xor<18>  (
    .CI(Madd_StateCtr_addsub0000_cy[17]),
    .LI(\Madd_StateCtr_addsub0000_cy<18>_rt_18 ),
    .O(StateCtr_addsub0000[18])
  );
  MUXCY   \Madd_StateCtr_addsub0000_cy<19>  (
    .CI(Madd_StateCtr_addsub0000_cy[18]),
    .DI(N0),
    .S(\Madd_StateCtr_addsub0000_cy<19>_rt_20 ),
    .O(Madd_StateCtr_addsub0000_cy[19])
  );
  XORCY   \Madd_StateCtr_addsub0000_xor<19>  (
    .CI(Madd_StateCtr_addsub0000_cy[18]),
    .LI(\Madd_StateCtr_addsub0000_cy<19>_rt_20 ),
    .O(StateCtr_addsub0000[19])
  );
  MUXCY   \Madd_StateCtr_addsub0000_cy<20>  (
    .CI(Madd_StateCtr_addsub0000_cy[19]),
    .DI(N0),
    .S(\Madd_StateCtr_addsub0000_cy<20>_rt_24 ),
    .O(Madd_StateCtr_addsub0000_cy[20])
  );
  XORCY   \Madd_StateCtr_addsub0000_xor<20>  (
    .CI(Madd_StateCtr_addsub0000_cy[19]),
    .LI(\Madd_StateCtr_addsub0000_cy<20>_rt_24 ),
    .O(StateCtr_addsub0000[20])
  );
  MUXCY   \Madd_StateCtr_addsub0000_cy<21>  (
    .CI(Madd_StateCtr_addsub0000_cy[20]),
    .DI(N0),
    .S(\Madd_StateCtr_addsub0000_cy<21>_rt_26 ),
    .O(Madd_StateCtr_addsub0000_cy[21])
  );
  XORCY   \Madd_StateCtr_addsub0000_xor<21>  (
    .CI(Madd_StateCtr_addsub0000_cy[20]),
    .LI(\Madd_StateCtr_addsub0000_cy<21>_rt_26 ),
    .O(StateCtr_addsub0000[21])
  );
  MUXCY   \Madd_StateCtr_addsub0000_cy<22>  (
    .CI(Madd_StateCtr_addsub0000_cy[21]),
    .DI(N0),
    .S(\Madd_StateCtr_addsub0000_cy<22>_rt_28 ),
    .O(Madd_StateCtr_addsub0000_cy[22])
  );
  XORCY   \Madd_StateCtr_addsub0000_xor<22>  (
    .CI(Madd_StateCtr_addsub0000_cy[21]),
    .LI(\Madd_StateCtr_addsub0000_cy<22>_rt_28 ),
    .O(StateCtr_addsub0000[22])
  );
  MUXCY   \Madd_StateCtr_addsub0000_cy<23>  (
    .CI(Madd_StateCtr_addsub0000_cy[22]),
    .DI(N0),
    .S(\Madd_StateCtr_addsub0000_cy<23>_rt_30 ),
    .O(Madd_StateCtr_addsub0000_cy[23])
  );
  XORCY   \Madd_StateCtr_addsub0000_xor<23>  (
    .CI(Madd_StateCtr_addsub0000_cy[22]),
    .LI(\Madd_StateCtr_addsub0000_cy<23>_rt_30 ),
    .O(StateCtr_addsub0000[23])
  );
  MUXCY   \Madd_StateCtr_addsub0000_cy<24>  (
    .CI(Madd_StateCtr_addsub0000_cy[23]),
    .DI(N0),
    .S(\Madd_StateCtr_addsub0000_cy<24>_rt_32 ),
    .O(Madd_StateCtr_addsub0000_cy[24])
  );
  XORCY   \Madd_StateCtr_addsub0000_xor<24>  (
    .CI(Madd_StateCtr_addsub0000_cy[23]),
    .LI(\Madd_StateCtr_addsub0000_cy<24>_rt_32 ),
    .O(StateCtr_addsub0000[24])
  );
  MUXCY   \Madd_StateCtr_addsub0000_cy<25>  (
    .CI(Madd_StateCtr_addsub0000_cy[24]),
    .DI(N0),
    .S(\Madd_StateCtr_addsub0000_cy<25>_rt_34 ),
    .O(Madd_StateCtr_addsub0000_cy[25])
  );
  XORCY   \Madd_StateCtr_addsub0000_xor<25>  (
    .CI(Madd_StateCtr_addsub0000_cy[24]),
    .LI(\Madd_StateCtr_addsub0000_cy<25>_rt_34 ),
    .O(StateCtr_addsub0000[25])
  );
  MUXCY   \Madd_StateCtr_addsub0000_cy<26>  (
    .CI(Madd_StateCtr_addsub0000_cy[25]),
    .DI(N0),
    .S(\Madd_StateCtr_addsub0000_cy<26>_rt_36 ),
    .O(Madd_StateCtr_addsub0000_cy[26])
  );
  XORCY   \Madd_StateCtr_addsub0000_xor<26>  (
    .CI(Madd_StateCtr_addsub0000_cy[25]),
    .LI(\Madd_StateCtr_addsub0000_cy<26>_rt_36 ),
    .O(StateCtr_addsub0000[26])
  );
  MUXCY   \Madd_StateCtr_addsub0000_cy<27>  (
    .CI(Madd_StateCtr_addsub0000_cy[26]),
    .DI(N0),
    .S(\Madd_StateCtr_addsub0000_cy<27>_rt_38 ),
    .O(Madd_StateCtr_addsub0000_cy[27])
  );
  XORCY   \Madd_StateCtr_addsub0000_xor<27>  (
    .CI(Madd_StateCtr_addsub0000_cy[26]),
    .LI(\Madd_StateCtr_addsub0000_cy<27>_rt_38 ),
    .O(StateCtr_addsub0000[27])
  );
  MUXCY   \Madd_StateCtr_addsub0000_cy<28>  (
    .CI(Madd_StateCtr_addsub0000_cy[27]),
    .DI(N0),
    .S(\Madd_StateCtr_addsub0000_cy<28>_rt_40 ),
    .O(Madd_StateCtr_addsub0000_cy[28])
  );
  XORCY   \Madd_StateCtr_addsub0000_xor<28>  (
    .CI(Madd_StateCtr_addsub0000_cy[27]),
    .LI(\Madd_StateCtr_addsub0000_cy<28>_rt_40 ),
    .O(StateCtr_addsub0000[28])
  );
  MUXCY   \Madd_StateCtr_addsub0000_cy<29>  (
    .CI(Madd_StateCtr_addsub0000_cy[28]),
    .DI(N0),
    .S(\Madd_StateCtr_addsub0000_cy<29>_rt_42 ),
    .O(Madd_StateCtr_addsub0000_cy[29])
  );
  XORCY   \Madd_StateCtr_addsub0000_xor<29>  (
    .CI(Madd_StateCtr_addsub0000_cy[28]),
    .LI(\Madd_StateCtr_addsub0000_cy<29>_rt_42 ),
    .O(StateCtr_addsub0000[29])
  );
  MUXCY   \Madd_StateCtr_addsub0000_cy<30>  (
    .CI(Madd_StateCtr_addsub0000_cy[29]),
    .DI(N0),
    .S(\Madd_StateCtr_addsub0000_cy<30>_rt_46 ),
    .O(Madd_StateCtr_addsub0000_cy[30])
  );
  XORCY   \Madd_StateCtr_addsub0000_xor<30>  (
    .CI(Madd_StateCtr_addsub0000_cy[29]),
    .LI(\Madd_StateCtr_addsub0000_cy<30>_rt_46 ),
    .O(StateCtr_addsub0000[30])
  );
  XORCY   \Madd_StateCtr_addsub0000_xor<31>  (
    .CI(Madd_StateCtr_addsub0000_cy[30]),
    .LI(\Madd_StateCtr_addsub0000_xor<31>_rt_62 ),
    .O(StateCtr_addsub0000[31])
  );
  MUXCY   \Mcompar_note_in_cmp_ge0000_cy<0>  (
    .CI(N1),
    .DI(N0),
    .S(\Mcompar_note_in_cmp_ge0000_cy<0>_rt_84 ),
    .O(Mcompar_note_in_cmp_ge0000_cy[0])
  );
  MUXCY   \Mcompar_note_in_cmp_ge0000_cy<1>  (
    .CI(Mcompar_note_in_cmp_ge0000_cy[0]),
    .DI(N1),
    .S(\Mcompar_note_in_cmp_ge0000_lut[1] ),
    .O(Mcompar_note_in_cmp_ge0000_cy[1])
  );
  MUXCY   \Mcompar_note_in_cmp_ge0000_cy<2>  (
    .CI(Mcompar_note_in_cmp_ge0000_cy[1]),
    .DI(N0),
    .S(\Mcompar_note_in_cmp_ge0000_cy<2>_rt_88 ),
    .O(Mcompar_note_in_cmp_ge0000_cy[2])
  );
  MUXCY   \Mcompar_note_in_cmp_ge0000_cy<3>  (
    .CI(Mcompar_note_in_cmp_ge0000_cy[2]),
    .DI(N1),
    .S(\Mcompar_note_in_cmp_ge0000_lut[3] ),
    .O(Mcompar_note_in_cmp_ge0000_cy[3])
  );
  LUT2 #(
    .INIT ( 4'h8 ))
  \Mcompar_note_in_cmp_ge0000_lut<4>  (
    .I0(SecondCtr[9]),
    .I1(SecondCtr[10]),
    .O(\Mcompar_note_in_cmp_ge0000_lut[4] )
  );
  MUXCY   \Mcompar_note_in_cmp_ge0000_cy<4>  (
    .CI(Mcompar_note_in_cmp_ge0000_cy[3]),
    .DI(N0),
    .S(\Mcompar_note_in_cmp_ge0000_lut[4] ),
    .O(Mcompar_note_in_cmp_ge0000_cy[4])
  );
  LUT4 #(
    .INIT ( 16'h0001 ))
  \Mcompar_note_in_cmp_ge0000_lut<5>  (
    .I0(SecondCtr[11]),
    .I1(SecondCtr[12]),
    .I2(SecondCtr[13]),
    .I3(SecondCtr[14]),
    .O(\Mcompar_note_in_cmp_ge0000_lut[5] )
  );
  MUXCY   \Mcompar_note_in_cmp_ge0000_cy<5>  (
    .CI(Mcompar_note_in_cmp_ge0000_cy[4]),
    .DI(N1),
    .S(\Mcompar_note_in_cmp_ge0000_lut[5] ),
    .O(Mcompar_note_in_cmp_ge0000_cy[5])
  );
  LUT2 #(
    .INIT ( 4'h8 ))
  \Mcompar_note_in_cmp_ge0000_lut<6>  (
    .I0(SecondCtr[15]),
    .I1(SecondCtr[16]),
    .O(\Mcompar_note_in_cmp_ge0000_lut[6] )
  );
  MUXCY   \Mcompar_note_in_cmp_ge0000_cy<6>  (
    .CI(Mcompar_note_in_cmp_ge0000_cy[5]),
    .DI(N0),
    .S(\Mcompar_note_in_cmp_ge0000_lut[6] ),
    .O(Mcompar_note_in_cmp_ge0000_cy[6])
  );
  LUT4 #(
    .INIT ( 16'h0001 ))
  \Mcompar_note_in_cmp_ge0000_lut<7>  (
    .I0(SecondCtr[17]),
    .I1(SecondCtr[18]),
    .I2(SecondCtr[19]),
    .I3(SecondCtr[20]),
    .O(\Mcompar_note_in_cmp_ge0000_lut[7] )
  );
  MUXCY   \Mcompar_note_in_cmp_ge0000_cy<7>  (
    .CI(Mcompar_note_in_cmp_ge0000_cy[6]),
    .DI(N1),
    .S(\Mcompar_note_in_cmp_ge0000_lut[7] ),
    .O(Mcompar_note_in_cmp_ge0000_cy[7])
  );
  LUT4 #(
    .INIT ( 16'h0001 ))
  \Mcompar_note_in_cmp_ge0000_lut<8>  (
    .I0(SecondCtr[21]),
    .I1(SecondCtr[22]),
    .I2(SecondCtr[23]),
    .I3(SecondCtr[24]),
    .O(\Mcompar_note_in_cmp_ge0000_lut[8] )
  );
  MUXCY   \Mcompar_note_in_cmp_ge0000_cy<8>  (
    .CI(Mcompar_note_in_cmp_ge0000_cy[7]),
    .DI(N1),
    .S(\Mcompar_note_in_cmp_ge0000_lut[8] ),
    .O(Mcompar_note_in_cmp_ge0000_cy[8])
  );
  LUT4 #(
    .INIT ( 16'h0001 ))
  \Mcompar_note_in_cmp_ge0000_lut<9>  (
    .I0(SecondCtr[25]),
    .I1(SecondCtr[26]),
    .I2(SecondCtr[27]),
    .I3(SecondCtr[28]),
    .O(\Mcompar_note_in_cmp_ge0000_lut[9] )
  );
  MUXCY   \Mcompar_note_in_cmp_ge0000_cy<9>  (
    .CI(Mcompar_note_in_cmp_ge0000_cy[8]),
    .DI(N1),
    .S(\Mcompar_note_in_cmp_ge0000_lut[9] ),
    .O(Mcompar_note_in_cmp_ge0000_cy[9])
  );
  LUT3 #(
    .INIT ( 8'h01 ))
  \Mcompar_note_in_cmp_ge0000_lut<10>  (
    .I0(SecondCtr[29]),
    .I1(SecondCtr[30]),
    .I2(SecondCtr[31]),
    .O(\Mcompar_note_in_cmp_ge0000_lut[10] )
  );
  MUXCY   \Mcompar_note_in_cmp_ge0000_cy<10>  (
    .CI(Mcompar_note_in_cmp_ge0000_cy[9]),
    .DI(N1),
    .S(\Mcompar_note_in_cmp_ge0000_lut[10] ),
    .O(Mcompar_note_in_cmp_ge0000_cy[10])
  );
  MUXCY   \Mcompar_note_in_cmp_ge0000_cy<11>  (
    .CI(Mcompar_note_in_cmp_ge0000_cy[10]),
    .DI(N0),
    .S(\Mcompar_note_in_cmp_ge0000_lut[11] ),
    .O(note_in_cmp_ge0000)
  );
  LUT3 #(
    .INIT ( 8'h01 ))
  \Mcompar_StateCtr_cmp_gt0000_lut<0>  (
    .I0(StateCtr[0]),
    .I1(StateCtr[1]),
    .I2(StateCtr[2]),
    .O(\Mcompar_StateCtr_cmp_gt0000_lut[0] )
  );
  MUXCY   \Mcompar_StateCtr_cmp_gt0000_cy<0>  (
    .CI(N1),
    .DI(N0),
    .S(\Mcompar_StateCtr_cmp_gt0000_lut[0] ),
    .O(Mcompar_StateCtr_cmp_gt0000_cy[0])
  );
  MUXCY   \Mcompar_StateCtr_cmp_gt0000_cy<1>  (
    .CI(Mcompar_StateCtr_cmp_gt0000_cy[0]),
    .DI(N1),
    .S(\Mcompar_StateCtr_cmp_gt0000_cy<1>_rt_65 ),
    .O(Mcompar_StateCtr_cmp_gt0000_cy[1])
  );
  LUT4 #(
    .INIT ( 16'h0001 ))
  \Mcompar_StateCtr_cmp_gt0000_lut<2>  (
    .I0(StateCtr[4]),
    .I1(StateCtr[5]),
    .I2(StateCtr[6]),
    .I3(StateCtr[7]),
    .O(\Mcompar_StateCtr_cmp_gt0000_lut[2] )
  );
  MUXCY   \Mcompar_StateCtr_cmp_gt0000_cy<2>  (
    .CI(Mcompar_StateCtr_cmp_gt0000_cy[1]),
    .DI(N0),
    .S(\Mcompar_StateCtr_cmp_gt0000_lut[2] ),
    .O(Mcompar_StateCtr_cmp_gt0000_cy[2])
  );
  LUT4 #(
    .INIT ( 16'h0001 ))
  \Mcompar_StateCtr_cmp_gt0000_lut<3>  (
    .I0(StateCtr[8]),
    .I1(StateCtr[9]),
    .I2(StateCtr[10]),
    .I3(StateCtr[11]),
    .O(\Mcompar_StateCtr_cmp_gt0000_lut[3] )
  );
  MUXCY   \Mcompar_StateCtr_cmp_gt0000_cy<3>  (
    .CI(Mcompar_StateCtr_cmp_gt0000_cy[2]),
    .DI(N0),
    .S(\Mcompar_StateCtr_cmp_gt0000_lut[3] ),
    .O(Mcompar_StateCtr_cmp_gt0000_cy[3])
  );
  LUT4 #(
    .INIT ( 16'h0001 ))
  \Mcompar_StateCtr_cmp_gt0000_lut<4>  (
    .I0(StateCtr[12]),
    .I1(StateCtr[13]),
    .I2(StateCtr[14]),
    .I3(StateCtr[15]),
    .O(\Mcompar_StateCtr_cmp_gt0000_lut[4] )
  );
  MUXCY   \Mcompar_StateCtr_cmp_gt0000_cy<4>  (
    .CI(Mcompar_StateCtr_cmp_gt0000_cy[3]),
    .DI(N0),
    .S(\Mcompar_StateCtr_cmp_gt0000_lut[4] ),
    .O(Mcompar_StateCtr_cmp_gt0000_cy[4])
  );
  LUT4 #(
    .INIT ( 16'h0001 ))
  \Mcompar_StateCtr_cmp_gt0000_lut<5>  (
    .I0(StateCtr[16]),
    .I1(StateCtr[17]),
    .I2(StateCtr[18]),
    .I3(StateCtr[19]),
    .O(\Mcompar_StateCtr_cmp_gt0000_lut[5] )
  );
  MUXCY   \Mcompar_StateCtr_cmp_gt0000_cy<5>  (
    .CI(Mcompar_StateCtr_cmp_gt0000_cy[4]),
    .DI(N0),
    .S(\Mcompar_StateCtr_cmp_gt0000_lut[5] ),
    .O(Mcompar_StateCtr_cmp_gt0000_cy[5])
  );
  LUT4 #(
    .INIT ( 16'h0001 ))
  \Mcompar_StateCtr_cmp_gt0000_lut<6>  (
    .I0(StateCtr[20]),
    .I1(StateCtr[21]),
    .I2(StateCtr[22]),
    .I3(StateCtr[23]),
    .O(\Mcompar_StateCtr_cmp_gt0000_lut[6] )
  );
  MUXCY   \Mcompar_StateCtr_cmp_gt0000_cy<6>  (
    .CI(Mcompar_StateCtr_cmp_gt0000_cy[5]),
    .DI(N0),
    .S(\Mcompar_StateCtr_cmp_gt0000_lut[6] ),
    .O(Mcompar_StateCtr_cmp_gt0000_cy[6])
  );
  LUT4 #(
    .INIT ( 16'h0001 ))
  \Mcompar_StateCtr_cmp_gt0000_lut<7>  (
    .I0(StateCtr[24]),
    .I1(StateCtr[25]),
    .I2(StateCtr[26]),
    .I3(StateCtr[27]),
    .O(\Mcompar_StateCtr_cmp_gt0000_lut[7] )
  );
  MUXCY   \Mcompar_StateCtr_cmp_gt0000_cy<7>  (
    .CI(Mcompar_StateCtr_cmp_gt0000_cy[6]),
    .DI(N0),
    .S(\Mcompar_StateCtr_cmp_gt0000_lut[7] ),
    .O(Mcompar_StateCtr_cmp_gt0000_cy[7])
  );
  LUT4 #(
    .INIT ( 16'h0001 ))
  \Mcompar_StateCtr_cmp_gt0000_lut<8>  (
    .I0(StateCtr[28]),
    .I1(StateCtr[29]),
    .I2(StateCtr[30]),
    .I3(StateCtr[31]),
    .O(\Mcompar_StateCtr_cmp_gt0000_lut[8] )
  );
  MUXCY   \Mcompar_StateCtr_cmp_gt0000_cy<8>  (
    .CI(Mcompar_StateCtr_cmp_gt0000_cy[7]),
    .DI(N0),
    .S(\Mcompar_StateCtr_cmp_gt0000_lut[8] ),
    .O(Mcompar_StateCtr_cmp_gt0000_cy[8])
  );
  MUXCY   \Mcompar_StateCtr_cmp_gt0000_cy<9>  (
    .CI(Mcompar_StateCtr_cmp_gt0000_cy[8]),
    .DI(StateCtr[31]),
    .S(\Mcompar_StateCtr_cmp_gt0000_lut[9] ),
    .O(Mcompar_StateCtr_cmp_gt0000_cy[9])
  );
  MUXCY   \Mcount_SecondCtr_cy<0>  (
    .CI(N0),
    .DI(N1),
    .S(Mcount_SecondCtr_lut[0]),
    .O(Mcount_SecondCtr_cy[0])
  );
  XORCY   \Mcount_SecondCtr_xor<0>  (
    .CI(N0),
    .LI(Mcount_SecondCtr_lut[0]),
    .O(Result[0])
  );
  MUXCY   \Mcount_SecondCtr_cy<1>  (
    .CI(Mcount_SecondCtr_cy[0]),
    .DI(N0),
    .S(\Mcount_SecondCtr_cy<1>_rt_128 ),
    .O(Mcount_SecondCtr_cy[1])
  );
  XORCY   \Mcount_SecondCtr_xor<1>  (
    .CI(Mcount_SecondCtr_cy[0]),
    .LI(\Mcount_SecondCtr_cy<1>_rt_128 ),
    .O(Result[1])
  );
  MUXCY   \Mcount_SecondCtr_cy<2>  (
    .CI(Mcount_SecondCtr_cy[1]),
    .DI(N0),
    .S(\Mcount_SecondCtr_cy<2>_rt_150 ),
    .O(Mcount_SecondCtr_cy[2])
  );
  XORCY   \Mcount_SecondCtr_xor<2>  (
    .CI(Mcount_SecondCtr_cy[1]),
    .LI(\Mcount_SecondCtr_cy<2>_rt_150 ),
    .O(Result[2])
  );
  MUXCY   \Mcount_SecondCtr_cy<3>  (
    .CI(Mcount_SecondCtr_cy[2]),
    .DI(N0),
    .S(\Mcount_SecondCtr_cy<3>_rt_154 ),
    .O(Mcount_SecondCtr_cy[3])
  );
  XORCY   \Mcount_SecondCtr_xor<3>  (
    .CI(Mcount_SecondCtr_cy[2]),
    .LI(\Mcount_SecondCtr_cy<3>_rt_154 ),
    .O(Result[3])
  );
  MUXCY   \Mcount_SecondCtr_cy<4>  (
    .CI(Mcount_SecondCtr_cy[3]),
    .DI(N0),
    .S(\Mcount_SecondCtr_cy<4>_rt_156 ),
    .O(Mcount_SecondCtr_cy[4])
  );
  XORCY   \Mcount_SecondCtr_xor<4>  (
    .CI(Mcount_SecondCtr_cy[3]),
    .LI(\Mcount_SecondCtr_cy<4>_rt_156 ),
    .O(Result[4])
  );
  MUXCY   \Mcount_SecondCtr_cy<5>  (
    .CI(Mcount_SecondCtr_cy[4]),
    .DI(N0),
    .S(\Mcount_SecondCtr_cy<5>_rt_158 ),
    .O(Mcount_SecondCtr_cy[5])
  );
  XORCY   \Mcount_SecondCtr_xor<5>  (
    .CI(Mcount_SecondCtr_cy[4]),
    .LI(\Mcount_SecondCtr_cy<5>_rt_158 ),
    .O(Result[5])
  );
  MUXCY   \Mcount_SecondCtr_cy<6>  (
    .CI(Mcount_SecondCtr_cy[5]),
    .DI(N0),
    .S(\Mcount_SecondCtr_cy<6>_rt_160 ),
    .O(Mcount_SecondCtr_cy[6])
  );
  XORCY   \Mcount_SecondCtr_xor<6>  (
    .CI(Mcount_SecondCtr_cy[5]),
    .LI(\Mcount_SecondCtr_cy<6>_rt_160 ),
    .O(Result[6])
  );
  MUXCY   \Mcount_SecondCtr_cy<7>  (
    .CI(Mcount_SecondCtr_cy[6]),
    .DI(N0),
    .S(\Mcount_SecondCtr_cy<7>_rt_162 ),
    .O(Mcount_SecondCtr_cy[7])
  );
  XORCY   \Mcount_SecondCtr_xor<7>  (
    .CI(Mcount_SecondCtr_cy[6]),
    .LI(\Mcount_SecondCtr_cy<7>_rt_162 ),
    .O(Result[7])
  );
  MUXCY   \Mcount_SecondCtr_cy<8>  (
    .CI(Mcount_SecondCtr_cy[7]),
    .DI(N0),
    .S(\Mcount_SecondCtr_cy<8>_rt_164 ),
    .O(Mcount_SecondCtr_cy[8])
  );
  XORCY   \Mcount_SecondCtr_xor<8>  (
    .CI(Mcount_SecondCtr_cy[7]),
    .LI(\Mcount_SecondCtr_cy<8>_rt_164 ),
    .O(Result[8])
  );
  MUXCY   \Mcount_SecondCtr_cy<9>  (
    .CI(Mcount_SecondCtr_cy[8]),
    .DI(N0),
    .S(\Mcount_SecondCtr_cy<9>_rt_166 ),
    .O(Mcount_SecondCtr_cy[9])
  );
  XORCY   \Mcount_SecondCtr_xor<9>  (
    .CI(Mcount_SecondCtr_cy[8]),
    .LI(\Mcount_SecondCtr_cy<9>_rt_166 ),
    .O(Result[9])
  );
  MUXCY   \Mcount_SecondCtr_cy<10>  (
    .CI(Mcount_SecondCtr_cy[9]),
    .DI(N0),
    .S(\Mcount_SecondCtr_cy<10>_rt_108 ),
    .O(Mcount_SecondCtr_cy[10])
  );
  XORCY   \Mcount_SecondCtr_xor<10>  (
    .CI(Mcount_SecondCtr_cy[9]),
    .LI(\Mcount_SecondCtr_cy<10>_rt_108 ),
    .O(Result[10])
  );
  MUXCY   \Mcount_SecondCtr_cy<11>  (
    .CI(Mcount_SecondCtr_cy[10]),
    .DI(N0),
    .S(\Mcount_SecondCtr_cy<11>_rt_110 ),
    .O(Mcount_SecondCtr_cy[11])
  );
  XORCY   \Mcount_SecondCtr_xor<11>  (
    .CI(Mcount_SecondCtr_cy[10]),
    .LI(\Mcount_SecondCtr_cy<11>_rt_110 ),
    .O(Result[11])
  );
  MUXCY   \Mcount_SecondCtr_cy<12>  (
    .CI(Mcount_SecondCtr_cy[11]),
    .DI(N0),
    .S(\Mcount_SecondCtr_cy<12>_rt_112 ),
    .O(Mcount_SecondCtr_cy[12])
  );
  XORCY   \Mcount_SecondCtr_xor<12>  (
    .CI(Mcount_SecondCtr_cy[11]),
    .LI(\Mcount_SecondCtr_cy<12>_rt_112 ),
    .O(Result[12])
  );
  MUXCY   \Mcount_SecondCtr_cy<13>  (
    .CI(Mcount_SecondCtr_cy[12]),
    .DI(N0),
    .S(\Mcount_SecondCtr_cy<13>_rt_114 ),
    .O(Mcount_SecondCtr_cy[13])
  );
  XORCY   \Mcount_SecondCtr_xor<13>  (
    .CI(Mcount_SecondCtr_cy[12]),
    .LI(\Mcount_SecondCtr_cy<13>_rt_114 ),
    .O(Result[13])
  );
  MUXCY   \Mcount_SecondCtr_cy<14>  (
    .CI(Mcount_SecondCtr_cy[13]),
    .DI(N0),
    .S(\Mcount_SecondCtr_cy<14>_rt_116 ),
    .O(Mcount_SecondCtr_cy[14])
  );
  XORCY   \Mcount_SecondCtr_xor<14>  (
    .CI(Mcount_SecondCtr_cy[13]),
    .LI(\Mcount_SecondCtr_cy<14>_rt_116 ),
    .O(Result[14])
  );
  MUXCY   \Mcount_SecondCtr_cy<15>  (
    .CI(Mcount_SecondCtr_cy[14]),
    .DI(N0),
    .S(\Mcount_SecondCtr_cy<15>_rt_118 ),
    .O(Mcount_SecondCtr_cy[15])
  );
  XORCY   \Mcount_SecondCtr_xor<15>  (
    .CI(Mcount_SecondCtr_cy[14]),
    .LI(\Mcount_SecondCtr_cy<15>_rt_118 ),
    .O(Result[15])
  );
  MUXCY   \Mcount_SecondCtr_cy<16>  (
    .CI(Mcount_SecondCtr_cy[15]),
    .DI(N0),
    .S(\Mcount_SecondCtr_cy<16>_rt_120 ),
    .O(Mcount_SecondCtr_cy[16])
  );
  XORCY   \Mcount_SecondCtr_xor<16>  (
    .CI(Mcount_SecondCtr_cy[15]),
    .LI(\Mcount_SecondCtr_cy<16>_rt_120 ),
    .O(Result[16])
  );
  MUXCY   \Mcount_SecondCtr_cy<17>  (
    .CI(Mcount_SecondCtr_cy[16]),
    .DI(N0),
    .S(\Mcount_SecondCtr_cy<17>_rt_122 ),
    .O(Mcount_SecondCtr_cy[17])
  );
  XORCY   \Mcount_SecondCtr_xor<17>  (
    .CI(Mcount_SecondCtr_cy[16]),
    .LI(\Mcount_SecondCtr_cy<17>_rt_122 ),
    .O(Result[17])
  );
  MUXCY   \Mcount_SecondCtr_cy<18>  (
    .CI(Mcount_SecondCtr_cy[17]),
    .DI(N0),
    .S(\Mcount_SecondCtr_cy<18>_rt_124 ),
    .O(Mcount_SecondCtr_cy[18])
  );
  XORCY   \Mcount_SecondCtr_xor<18>  (
    .CI(Mcount_SecondCtr_cy[17]),
    .LI(\Mcount_SecondCtr_cy<18>_rt_124 ),
    .O(Result[18])
  );
  MUXCY   \Mcount_SecondCtr_cy<19>  (
    .CI(Mcount_SecondCtr_cy[18]),
    .DI(N0),
    .S(\Mcount_SecondCtr_cy<19>_rt_126 ),
    .O(Mcount_SecondCtr_cy[19])
  );
  XORCY   \Mcount_SecondCtr_xor<19>  (
    .CI(Mcount_SecondCtr_cy[18]),
    .LI(\Mcount_SecondCtr_cy<19>_rt_126 ),
    .O(Result[19])
  );
  MUXCY   \Mcount_SecondCtr_cy<20>  (
    .CI(Mcount_SecondCtr_cy[19]),
    .DI(N0),
    .S(\Mcount_SecondCtr_cy<20>_rt_130 ),
    .O(Mcount_SecondCtr_cy[20])
  );
  XORCY   \Mcount_SecondCtr_xor<20>  (
    .CI(Mcount_SecondCtr_cy[19]),
    .LI(\Mcount_SecondCtr_cy<20>_rt_130 ),
    .O(Result[20])
  );
  MUXCY   \Mcount_SecondCtr_cy<21>  (
    .CI(Mcount_SecondCtr_cy[20]),
    .DI(N0),
    .S(\Mcount_SecondCtr_cy<21>_rt_132 ),
    .O(Mcount_SecondCtr_cy[21])
  );
  XORCY   \Mcount_SecondCtr_xor<21>  (
    .CI(Mcount_SecondCtr_cy[20]),
    .LI(\Mcount_SecondCtr_cy<21>_rt_132 ),
    .O(Result[21])
  );
  MUXCY   \Mcount_SecondCtr_cy<22>  (
    .CI(Mcount_SecondCtr_cy[21]),
    .DI(N0),
    .S(\Mcount_SecondCtr_cy<22>_rt_134 ),
    .O(Mcount_SecondCtr_cy[22])
  );
  XORCY   \Mcount_SecondCtr_xor<22>  (
    .CI(Mcount_SecondCtr_cy[21]),
    .LI(\Mcount_SecondCtr_cy<22>_rt_134 ),
    .O(Result[22])
  );
  MUXCY   \Mcount_SecondCtr_cy<23>  (
    .CI(Mcount_SecondCtr_cy[22]),
    .DI(N0),
    .S(\Mcount_SecondCtr_cy<23>_rt_136 ),
    .O(Mcount_SecondCtr_cy[23])
  );
  XORCY   \Mcount_SecondCtr_xor<23>  (
    .CI(Mcount_SecondCtr_cy[22]),
    .LI(\Mcount_SecondCtr_cy<23>_rt_136 ),
    .O(Result[23])
  );
  MUXCY   \Mcount_SecondCtr_cy<24>  (
    .CI(Mcount_SecondCtr_cy[23]),
    .DI(N0),
    .S(\Mcount_SecondCtr_cy<24>_rt_138 ),
    .O(Mcount_SecondCtr_cy[24])
  );
  XORCY   \Mcount_SecondCtr_xor<24>  (
    .CI(Mcount_SecondCtr_cy[23]),
    .LI(\Mcount_SecondCtr_cy<24>_rt_138 ),
    .O(Result[24])
  );
  MUXCY   \Mcount_SecondCtr_cy<25>  (
    .CI(Mcount_SecondCtr_cy[24]),
    .DI(N0),
    .S(\Mcount_SecondCtr_cy<25>_rt_140 ),
    .O(Mcount_SecondCtr_cy[25])
  );
  XORCY   \Mcount_SecondCtr_xor<25>  (
    .CI(Mcount_SecondCtr_cy[24]),
    .LI(\Mcount_SecondCtr_cy<25>_rt_140 ),
    .O(Result[25])
  );
  MUXCY   \Mcount_SecondCtr_cy<26>  (
    .CI(Mcount_SecondCtr_cy[25]),
    .DI(N0),
    .S(\Mcount_SecondCtr_cy<26>_rt_142 ),
    .O(Mcount_SecondCtr_cy[26])
  );
  XORCY   \Mcount_SecondCtr_xor<26>  (
    .CI(Mcount_SecondCtr_cy[25]),
    .LI(\Mcount_SecondCtr_cy<26>_rt_142 ),
    .O(Result[26])
  );
  MUXCY   \Mcount_SecondCtr_cy<27>  (
    .CI(Mcount_SecondCtr_cy[26]),
    .DI(N0),
    .S(\Mcount_SecondCtr_cy<27>_rt_144 ),
    .O(Mcount_SecondCtr_cy[27])
  );
  XORCY   \Mcount_SecondCtr_xor<27>  (
    .CI(Mcount_SecondCtr_cy[26]),
    .LI(\Mcount_SecondCtr_cy<27>_rt_144 ),
    .O(Result[27])
  );
  MUXCY   \Mcount_SecondCtr_cy<28>  (
    .CI(Mcount_SecondCtr_cy[27]),
    .DI(N0),
    .S(\Mcount_SecondCtr_cy<28>_rt_146 ),
    .O(Mcount_SecondCtr_cy[28])
  );
  XORCY   \Mcount_SecondCtr_xor<28>  (
    .CI(Mcount_SecondCtr_cy[27]),
    .LI(\Mcount_SecondCtr_cy<28>_rt_146 ),
    .O(Result[28])
  );
  MUXCY   \Mcount_SecondCtr_cy<29>  (
    .CI(Mcount_SecondCtr_cy[28]),
    .DI(N0),
    .S(\Mcount_SecondCtr_cy<29>_rt_148 ),
    .O(Mcount_SecondCtr_cy[29])
  );
  XORCY   \Mcount_SecondCtr_xor<29>  (
    .CI(Mcount_SecondCtr_cy[28]),
    .LI(\Mcount_SecondCtr_cy<29>_rt_148 ),
    .O(Result[29])
  );
  MUXCY   \Mcount_SecondCtr_cy<30>  (
    .CI(Mcount_SecondCtr_cy[29]),
    .DI(N0),
    .S(\Mcount_SecondCtr_cy<30>_rt_152 ),
    .O(Mcount_SecondCtr_cy[30])
  );
  XORCY   \Mcount_SecondCtr_xor<30>  (
    .CI(Mcount_SecondCtr_cy[29]),
    .LI(\Mcount_SecondCtr_cy<30>_rt_152 ),
    .O(Result[30])
  );
  XORCY   \Mcount_SecondCtr_xor<31>  (
    .CI(Mcount_SecondCtr_cy[30]),
    .LI(\Mcount_SecondCtr_xor<31>_rt_168 ),
    .O(Result[31])
  );
  MUXF5   \mixer/Mmux_ch4_2_f5_0  (
    .I0(\mixer/Mmux_ch4_41_679 ),
    .I1(\mixer/Mmux_ch4_31_677 ),
    .S(volsel_1_IBUF_1081),
    .O(\mixer/ch4 [3])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \mixer/Mmux_ch4_41  (
    .I0(volsel_0_IBUF_1080),
    .I1(\trgen2/triangle_out [3]),
    .I2(\trgen2/triangle_out [2]),
    .O(\mixer/Mmux_ch4_41_679 )
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \mixer/Mmux_ch4_31  (
    .I0(volsel_0_IBUF_1080),
    .I1(\trgen2/triangle_out [1]),
    .I2(\mixer/ch4_addsub0000 [3]),
    .O(\mixer/Mmux_ch4_31_677 )
  );
  MUXF5   \mixer/Mmux_ch4_2_f5  (
    .I0(\mixer/Mmux_ch4_4_678 ),
    .I1(\mixer/Mmux_ch4_3_676 ),
    .S(volsel_1_IBUF_1081),
    .O(\mixer/ch4 [2])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \mixer/Mmux_ch4_4  (
    .I0(volsel_0_IBUF_1080),
    .I1(\trgen2/triangle_out [2]),
    .I2(\trgen2/triangle_out [1]),
    .O(\mixer/Mmux_ch4_4_678 )
  );
  MUXCY   \mixer/Madd__old_tempresult_6_cy<2>  (
    .CI(N0),
    .DI(\mixer/ch4 [2]),
    .S(\mixer/Madd__old_tempresult_6_lut [2]),
    .O(\mixer/Madd__old_tempresult_6_cy [2])
  );
  XORCY   \mixer/Madd__old_tempresult_6_xor<2>  (
    .CI(N0),
    .LI(\mixer/Madd__old_tempresult_6_lut [2]),
    .O(audio_out_2_OBUF_366)
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  \mixer/Madd__old_tempresult_6_lut<3>  (
    .I0(\mixer/Madd_old_tempresult_6_addsub0001_Madd_lut [3]),
    .I1(\mixer/ch4 [3]),
    .O(\mixer/Madd__old_tempresult_6_lut [3])
  );
  MUXCY   \mixer/Madd__old_tempresult_6_cy<3>  (
    .CI(\mixer/Madd__old_tempresult_6_cy [2]),
    .DI(\mixer/ch4 [3]),
    .S(\mixer/Madd__old_tempresult_6_lut [3]),
    .O(\mixer/Madd__old_tempresult_6_cy [3])
  );
  XORCY   \mixer/Madd__old_tempresult_6_xor<3>  (
    .CI(\mixer/Madd__old_tempresult_6_cy [2]),
    .LI(\mixer/Madd__old_tempresult_6_lut [3]),
    .O(audio_out_3_OBUF_367)
  );
  MUXCY   \mixer/Madd__old_tempresult_6_cy<4>  (
    .CI(\mixer/Madd__old_tempresult_6_cy [3]),
    .DI(\mixer/old_tempresult_6_addsub0001 [4]),
    .S(\mixer/Madd__old_tempresult_6_lut [4]),
    .O(\mixer/Madd__old_tempresult_6_cy [4])
  );
  XORCY   \mixer/Madd__old_tempresult_6_xor<4>  (
    .CI(\mixer/Madd__old_tempresult_6_cy [3]),
    .LI(\mixer/Madd__old_tempresult_6_lut [4]),
    .O(audio_out_4_OBUF_368)
  );
  MUXCY   \mixer/Madd__old_tempresult_6_cy<5>  (
    .CI(\mixer/Madd__old_tempresult_6_cy [4]),
    .DI(\mixer/old_tempresult_6_addsub0001 [5]),
    .S(\mixer/Madd__old_tempresult_6_lut [5]),
    .O(\mixer/Madd__old_tempresult_6_cy [5])
  );
  XORCY   \mixer/Madd__old_tempresult_6_xor<5>  (
    .CI(\mixer/Madd__old_tempresult_6_cy [4]),
    .LI(\mixer/Madd__old_tempresult_6_lut [5]),
    .O(audio_out_5_OBUF_369)
  );
  MUXCY   \mixer/Madd__old_tempresult_6_cy<6>  (
    .CI(\mixer/Madd__old_tempresult_6_cy [5]),
    .DI(N0),
    .S(\mixer/old_tempresult_6_addsub0001 [6]),
    .O(\mixer/Madd__old_tempresult_6_cy [6])
  );
  XORCY   \mixer/Madd__old_tempresult_6_xor<6>  (
    .CI(\mixer/Madd__old_tempresult_6_cy [5]),
    .LI(\mixer/old_tempresult_6_addsub0001 [6]),
    .O(audio_out_6_OBUF_370)
  );
  XORCY   \mixer/Madd__old_tempresult_6_xor<7>  (
    .CI(\mixer/Madd__old_tempresult_6_cy [6]),
    .LI(\mixer/Madd_old_tempresult_6_addsub0001_Madd_cy[6] ),
    .O(audio_out_7_OBUF_371)
  );
  BUFG   freq1_bufg (
    .I(\freqgen/freq_out_555 ),
    .O(buffreq1)
  );
  BUFG   freq2_bufg (
    .I(\freqgen2/freq_out_655 ),
    .O(buffreq2)
  );
  BUFG   freq3_bufg (
    .I(\freqgen2/freq_out_655 ),
    .O(buffreq3)
  );
  BUFG   freq4_bufg (
    .I(\freqgen2/freq_out_655 ),
    .O(buffreq4)
  );
  MUXCY   \porta1/Mcompar_count_cmp_ge0000_cy<10>  (
    .CI(\porta1/Mcompar_count_cmp_ge0000_cy [9]),
    .DI(N0),
    .S(\porta1/Mcompar_count_cmp_ge0000_lut[10] ),
    .O(\porta1/count_cmp_ge0000 )
  );
  MUXCY   \porta1/Mcompar_count_cmp_ge0000_cy<9>  (
    .CI(\porta1/Mcompar_count_cmp_ge0000_cy [8]),
    .DI(N1),
    .S(\porta1/Mcompar_count_cmp_ge0000_lut[9] ),
    .O(\porta1/Mcompar_count_cmp_ge0000_cy [9])
  );
  LUT2 #(
    .INIT ( 4'h1 ))
  \porta1/Mcompar_count_cmp_ge0000_lut<9>  (
    .I0(\porta1/_old_count_1 [30]),
    .I1(\porta1/_old_count_1 [31]),
    .O(\porta1/Mcompar_count_cmp_ge0000_lut[9] )
  );
  MUXCY   \porta1/Mcompar_count_cmp_ge0000_cy<8>  (
    .CI(\porta1/Mcompar_count_cmp_ge0000_cy [7]),
    .DI(N1),
    .S(\porta1/Mcompar_count_cmp_ge0000_lut[8] ),
    .O(\porta1/Mcompar_count_cmp_ge0000_cy [8])
  );
  LUT4 #(
    .INIT ( 16'h0001 ))
  \porta1/Mcompar_count_cmp_ge0000_lut<8>  (
    .I0(\porta1/_old_count_1 [26]),
    .I1(\porta1/_old_count_1 [27]),
    .I2(\porta1/_old_count_1 [28]),
    .I3(\porta1/_old_count_1 [29]),
    .O(\porta1/Mcompar_count_cmp_ge0000_lut[8] )
  );
  MUXCY   \porta1/Mcompar_count_cmp_ge0000_cy<7>  (
    .CI(\porta1/Mcompar_count_cmp_ge0000_cy [6]),
    .DI(N1),
    .S(\porta1/Mcompar_count_cmp_ge0000_lut[7] ),
    .O(\porta1/Mcompar_count_cmp_ge0000_cy [7])
  );
  LUT4 #(
    .INIT ( 16'h0001 ))
  \porta1/Mcompar_count_cmp_ge0000_lut<7>  (
    .I0(\porta1/_old_count_1 [22]),
    .I1(\porta1/_old_count_1 [23]),
    .I2(\porta1/_old_count_1 [24]),
    .I3(\porta1/_old_count_1 [25]),
    .O(\porta1/Mcompar_count_cmp_ge0000_lut[7] )
  );
  MUXCY   \porta1/Mcompar_count_cmp_ge0000_cy<6>  (
    .CI(\porta1/Mcompar_count_cmp_ge0000_cy [5]),
    .DI(N1),
    .S(\porta1/Mcompar_count_cmp_ge0000_lut[6] ),
    .O(\porta1/Mcompar_count_cmp_ge0000_cy [6])
  );
  LUT4 #(
    .INIT ( 16'h0001 ))
  \porta1/Mcompar_count_cmp_ge0000_lut<6>  (
    .I0(\porta1/_old_count_1 [18]),
    .I1(\porta1/_old_count_1 [19]),
    .I2(\porta1/_old_count_1 [20]),
    .I3(\porta1/_old_count_1 [21]),
    .O(\porta1/Mcompar_count_cmp_ge0000_lut[6] )
  );
  MUXCY   \porta1/Mcompar_count_cmp_ge0000_cy<5>  (
    .CI(\porta1/Mcompar_count_cmp_ge0000_cy [4]),
    .DI(N1),
    .S(\porta1/Mcompar_count_cmp_ge0000_lut[5] ),
    .O(\porta1/Mcompar_count_cmp_ge0000_cy [5])
  );
  LUT4 #(
    .INIT ( 16'h0001 ))
  \porta1/Mcompar_count_cmp_ge0000_lut<5>  (
    .I0(\porta1/_old_count_1 [14]),
    .I1(\porta1/_old_count_1 [15]),
    .I2(\porta1/_old_count_1 [16]),
    .I3(\porta1/_old_count_1 [17]),
    .O(\porta1/Mcompar_count_cmp_ge0000_lut[5] )
  );
  MUXCY   \porta1/Mcompar_count_cmp_ge0000_cy<4>  (
    .CI(\porta1/Mcompar_count_cmp_ge0000_cy [3]),
    .DI(N0),
    .S(\porta1/Mcompar_count_cmp_ge0000_cy<4>_rt_801 ),
    .O(\porta1/Mcompar_count_cmp_ge0000_cy [4])
  );
  MUXCY   \porta1/Mcompar_count_cmp_ge0000_cy<3>  (
    .CI(\porta1/Mcompar_count_cmp_ge0000_cy [2]),
    .DI(N1),
    .S(\porta1/Mcompar_count_cmp_ge0000_lut[3] ),
    .O(\porta1/Mcompar_count_cmp_ge0000_cy [3])
  );
  LUT2 #(
    .INIT ( 4'h1 ))
  \porta1/Mcompar_count_cmp_ge0000_lut<3>  (
    .I0(\porta1/_old_count_1 [11]),
    .I1(\porta1/_old_count_1 [12]),
    .O(\porta1/Mcompar_count_cmp_ge0000_lut[3] )
  );
  MUXCY   \porta1/Mcompar_count_cmp_ge0000_cy<2>  (
    .CI(\porta1/Mcompar_count_cmp_ge0000_cy [1]),
    .DI(N0),
    .S(\porta1/Mcompar_count_cmp_ge0000_lut[2] ),
    .O(\porta1/Mcompar_count_cmp_ge0000_cy [2])
  );
  LUT3 #(
    .INIT ( 8'h80 ))
  \porta1/Mcompar_count_cmp_ge0000_lut<2>  (
    .I0(\porta1/_old_count_1 [8]),
    .I1(\porta1/_old_count_1 [9]),
    .I2(\porta1/_old_count_1 [10]),
    .O(\porta1/Mcompar_count_cmp_ge0000_lut[2] )
  );
  MUXCY   \porta1/Mcompar_count_cmp_ge0000_cy<1>  (
    .CI(\porta1/Mcompar_count_cmp_ge0000_cy [0]),
    .DI(N1),
    .S(\porta1/Mcompar_count_cmp_ge0000_lut[1] ),
    .O(\porta1/Mcompar_count_cmp_ge0000_cy [1])
  );
  LUT3 #(
    .INIT ( 8'h01 ))
  \porta1/Mcompar_count_cmp_ge0000_lut<1>  (
    .I0(\porta1/_old_count_1 [5]),
    .I1(\porta1/_old_count_1 [6]),
    .I2(\porta1/_old_count_1 [7]),
    .O(\porta1/Mcompar_count_cmp_ge0000_lut[1] )
  );
  MUXCY   \porta1/Mcompar_count_cmp_ge0000_cy<0>  (
    .CI(N1),
    .DI(N0),
    .S(\porta1/Mcompar_count_cmp_ge0000_cy<0>_rt_796 ),
    .O(\porta1/Mcompar_count_cmp_ge0000_cy [0])
  );
  XORCY   \porta1/Maddsub_note_out_share0000_xor<5>  (
    .CI(\porta1/Maddsub_note_out_share0000_cy [4]),
    .LI(\porta1/Maddsub_note_out_share0000_xor<5>_rt_794 ),
    .O(\porta1/note_out_share0000 [5])
  );
  XORCY   \porta1/Maddsub_note_out_share0000_xor<4>  (
    .CI(\porta1/Maddsub_note_out_share0000_cy [3]),
    .LI(\porta1/Maddsub_note_out_share0000_cy<4>_rt_793 ),
    .O(\porta1/note_out_share0000 [4])
  );
  MUXCY   \porta1/Maddsub_note_out_share0000_cy<4>  (
    .CI(\porta1/Maddsub_note_out_share0000_cy [3]),
    .DI(N0),
    .S(\porta1/Maddsub_note_out_share0000_cy<4>_rt_793 ),
    .O(\porta1/Maddsub_note_out_share0000_cy [4])
  );
  XORCY   \porta1/Maddsub_note_out_share0000_xor<3>  (
    .CI(\porta1/Maddsub_note_out_share0000_cy [2]),
    .LI(\porta1/Maddsub_note_out_share0000_cy<3>_rt_791 ),
    .O(\porta1/note_out_share0000 [3])
  );
  MUXCY   \porta1/Maddsub_note_out_share0000_cy<3>  (
    .CI(\porta1/Maddsub_note_out_share0000_cy [2]),
    .DI(N0),
    .S(\porta1/Maddsub_note_out_share0000_cy<3>_rt_791 ),
    .O(\porta1/Maddsub_note_out_share0000_cy [3])
  );
  XORCY   \porta1/Maddsub_note_out_share0000_xor<2>  (
    .CI(\porta1/Maddsub_note_out_share0000_cy [1]),
    .LI(\porta1/Maddsub_note_out_share0000_cy<2>_rt_789 ),
    .O(\porta1/note_out_share0000 [2])
  );
  MUXCY   \porta1/Maddsub_note_out_share0000_cy<2>  (
    .CI(\porta1/Maddsub_note_out_share0000_cy [1]),
    .DI(N0),
    .S(\porta1/Maddsub_note_out_share0000_cy<2>_rt_789 ),
    .O(\porta1/Maddsub_note_out_share0000_cy [2])
  );
  XORCY   \porta1/Maddsub_note_out_share0000_xor<1>  (
    .CI(\porta1/Maddsub_note_out_share0000_cy [0]),
    .LI(\porta1/Maddsub_note_out_share0000_cy<1>_rt_787 ),
    .O(\porta1/note_out_share0000 [1])
  );
  MUXCY   \porta1/Maddsub_note_out_share0000_cy<1>  (
    .CI(\porta1/Maddsub_note_out_share0000_cy [0]),
    .DI(N0),
    .S(\porta1/Maddsub_note_out_share0000_cy<1>_rt_787 ),
    .O(\porta1/Maddsub_note_out_share0000_cy [1])
  );
  XORCY   \porta1/Maddsub_note_out_share0000_xor<0>  (
    .CI(N0),
    .LI(\porta1/Maddsub_note_out_share0000_cy<0>_rt_785 ),
    .O(\porta1/note_out_share0000 [0])
  );
  MUXCY   \porta1/Maddsub_note_out_share0000_cy<0>  (
    .CI(N0),
    .DI(N0),
    .S(\porta1/Maddsub_note_out_share0000_cy<0>_rt_785 ),
    .O(\porta1/Maddsub_note_out_share0000_cy [0])
  );
  XORCY   \porta1/Mcount_count_xor<31>  (
    .CI(\porta1/Mcount_count_cy [30]),
    .LI(\porta1/Mcount_count_xor<31>_rt_889 ),
    .O(\porta1/Result [31])
  );
  XORCY   \porta1/Mcount_count_xor<30>  (
    .CI(\porta1/Mcount_count_cy [29]),
    .LI(\porta1/Mcount_count_cy<30>_rt_873 ),
    .O(\porta1/Result [30])
  );
  MUXCY   \porta1/Mcount_count_cy<30>  (
    .CI(\porta1/Mcount_count_cy [29]),
    .DI(N0),
    .S(\porta1/Mcount_count_cy<30>_rt_873 ),
    .O(\porta1/Mcount_count_cy [30])
  );
  XORCY   \porta1/Mcount_count_xor<29>  (
    .CI(\porta1/Mcount_count_cy [28]),
    .LI(\porta1/Mcount_count_cy<29>_rt_869 ),
    .O(\porta1/Result [29])
  );
  MUXCY   \porta1/Mcount_count_cy<29>  (
    .CI(\porta1/Mcount_count_cy [28]),
    .DI(N0),
    .S(\porta1/Mcount_count_cy<29>_rt_869 ),
    .O(\porta1/Mcount_count_cy [29])
  );
  XORCY   \porta1/Mcount_count_xor<28>  (
    .CI(\porta1/Mcount_count_cy [27]),
    .LI(\porta1/Mcount_count_cy<28>_rt_867 ),
    .O(\porta1/Result [28])
  );
  MUXCY   \porta1/Mcount_count_cy<28>  (
    .CI(\porta1/Mcount_count_cy [27]),
    .DI(N0),
    .S(\porta1/Mcount_count_cy<28>_rt_867 ),
    .O(\porta1/Mcount_count_cy [28])
  );
  XORCY   \porta1/Mcount_count_xor<27>  (
    .CI(\porta1/Mcount_count_cy [26]),
    .LI(\porta1/Mcount_count_cy<27>_rt_865 ),
    .O(\porta1/Result [27])
  );
  MUXCY   \porta1/Mcount_count_cy<27>  (
    .CI(\porta1/Mcount_count_cy [26]),
    .DI(N0),
    .S(\porta1/Mcount_count_cy<27>_rt_865 ),
    .O(\porta1/Mcount_count_cy [27])
  );
  XORCY   \porta1/Mcount_count_xor<26>  (
    .CI(\porta1/Mcount_count_cy [25]),
    .LI(\porta1/Mcount_count_cy<26>_rt_863 ),
    .O(\porta1/Result [26])
  );
  MUXCY   \porta1/Mcount_count_cy<26>  (
    .CI(\porta1/Mcount_count_cy [25]),
    .DI(N0),
    .S(\porta1/Mcount_count_cy<26>_rt_863 ),
    .O(\porta1/Mcount_count_cy [26])
  );
  XORCY   \porta1/Mcount_count_xor<25>  (
    .CI(\porta1/Mcount_count_cy [24]),
    .LI(\porta1/Mcount_count_cy<25>_rt_861 ),
    .O(\porta1/Result [25])
  );
  MUXCY   \porta1/Mcount_count_cy<25>  (
    .CI(\porta1/Mcount_count_cy [24]),
    .DI(N0),
    .S(\porta1/Mcount_count_cy<25>_rt_861 ),
    .O(\porta1/Mcount_count_cy [25])
  );
  XORCY   \porta1/Mcount_count_xor<24>  (
    .CI(\porta1/Mcount_count_cy [23]),
    .LI(\porta1/Mcount_count_cy<24>_rt_859 ),
    .O(\porta1/Result [24])
  );
  MUXCY   \porta1/Mcount_count_cy<24>  (
    .CI(\porta1/Mcount_count_cy [23]),
    .DI(N0),
    .S(\porta1/Mcount_count_cy<24>_rt_859 ),
    .O(\porta1/Mcount_count_cy [24])
  );
  XORCY   \porta1/Mcount_count_xor<23>  (
    .CI(\porta1/Mcount_count_cy [22]),
    .LI(\porta1/Mcount_count_cy<23>_rt_857 ),
    .O(\porta1/Result [23])
  );
  MUXCY   \porta1/Mcount_count_cy<23>  (
    .CI(\porta1/Mcount_count_cy [22]),
    .DI(N0),
    .S(\porta1/Mcount_count_cy<23>_rt_857 ),
    .O(\porta1/Mcount_count_cy [23])
  );
  XORCY   \porta1/Mcount_count_xor<22>  (
    .CI(\porta1/Mcount_count_cy [21]),
    .LI(\porta1/Mcount_count_cy<22>_rt_855 ),
    .O(\porta1/Result [22])
  );
  MUXCY   \porta1/Mcount_count_cy<22>  (
    .CI(\porta1/Mcount_count_cy [21]),
    .DI(N0),
    .S(\porta1/Mcount_count_cy<22>_rt_855 ),
    .O(\porta1/Mcount_count_cy [22])
  );
  XORCY   \porta1/Mcount_count_xor<21>  (
    .CI(\porta1/Mcount_count_cy [20]),
    .LI(\porta1/Mcount_count_cy<21>_rt_853 ),
    .O(\porta1/Result [21])
  );
  MUXCY   \porta1/Mcount_count_cy<21>  (
    .CI(\porta1/Mcount_count_cy [20]),
    .DI(N0),
    .S(\porta1/Mcount_count_cy<21>_rt_853 ),
    .O(\porta1/Mcount_count_cy [21])
  );
  XORCY   \porta1/Mcount_count_xor<20>  (
    .CI(\porta1/Mcount_count_cy [19]),
    .LI(\porta1/Mcount_count_cy<20>_rt_851 ),
    .O(\porta1/Result [20])
  );
  MUXCY   \porta1/Mcount_count_cy<20>  (
    .CI(\porta1/Mcount_count_cy [19]),
    .DI(N0),
    .S(\porta1/Mcount_count_cy<20>_rt_851 ),
    .O(\porta1/Mcount_count_cy [20])
  );
  XORCY   \porta1/Mcount_count_xor<19>  (
    .CI(\porta1/Mcount_count_cy [18]),
    .LI(\porta1/Mcount_count_cy<19>_rt_847 ),
    .O(\porta1/Result [19])
  );
  MUXCY   \porta1/Mcount_count_cy<19>  (
    .CI(\porta1/Mcount_count_cy [18]),
    .DI(N0),
    .S(\porta1/Mcount_count_cy<19>_rt_847 ),
    .O(\porta1/Mcount_count_cy [19])
  );
  XORCY   \porta1/Mcount_count_xor<18>  (
    .CI(\porta1/Mcount_count_cy [17]),
    .LI(\porta1/Mcount_count_cy<18>_rt_845 ),
    .O(\porta1/Result [18])
  );
  MUXCY   \porta1/Mcount_count_cy<18>  (
    .CI(\porta1/Mcount_count_cy [17]),
    .DI(N0),
    .S(\porta1/Mcount_count_cy<18>_rt_845 ),
    .O(\porta1/Mcount_count_cy [18])
  );
  XORCY   \porta1/Mcount_count_xor<17>  (
    .CI(\porta1/Mcount_count_cy [16]),
    .LI(\porta1/Mcount_count_cy<17>_rt_843 ),
    .O(\porta1/Result [17])
  );
  MUXCY   \porta1/Mcount_count_cy<17>  (
    .CI(\porta1/Mcount_count_cy [16]),
    .DI(N0),
    .S(\porta1/Mcount_count_cy<17>_rt_843 ),
    .O(\porta1/Mcount_count_cy [17])
  );
  XORCY   \porta1/Mcount_count_xor<16>  (
    .CI(\porta1/Mcount_count_cy [15]),
    .LI(\porta1/Mcount_count_cy<16>_rt_841 ),
    .O(\porta1/Result [16])
  );
  MUXCY   \porta1/Mcount_count_cy<16>  (
    .CI(\porta1/Mcount_count_cy [15]),
    .DI(N0),
    .S(\porta1/Mcount_count_cy<16>_rt_841 ),
    .O(\porta1/Mcount_count_cy [16])
  );
  XORCY   \porta1/Mcount_count_xor<15>  (
    .CI(\porta1/Mcount_count_cy [14]),
    .LI(\porta1/Mcount_count_cy<15>_rt_839 ),
    .O(\porta1/Result [15])
  );
  MUXCY   \porta1/Mcount_count_cy<15>  (
    .CI(\porta1/Mcount_count_cy [14]),
    .DI(N0),
    .S(\porta1/Mcount_count_cy<15>_rt_839 ),
    .O(\porta1/Mcount_count_cy [15])
  );
  XORCY   \porta1/Mcount_count_xor<14>  (
    .CI(\porta1/Mcount_count_cy [13]),
    .LI(\porta1/Mcount_count_cy<14>_rt_837 ),
    .O(\porta1/Result [14])
  );
  MUXCY   \porta1/Mcount_count_cy<14>  (
    .CI(\porta1/Mcount_count_cy [13]),
    .DI(N0),
    .S(\porta1/Mcount_count_cy<14>_rt_837 ),
    .O(\porta1/Mcount_count_cy [14])
  );
  XORCY   \porta1/Mcount_count_xor<13>  (
    .CI(\porta1/Mcount_count_cy [12]),
    .LI(\porta1/Mcount_count_cy<13>_rt_835 ),
    .O(\porta1/Result [13])
  );
  MUXCY   \porta1/Mcount_count_cy<13>  (
    .CI(\porta1/Mcount_count_cy [12]),
    .DI(N0),
    .S(\porta1/Mcount_count_cy<13>_rt_835 ),
    .O(\porta1/Mcount_count_cy [13])
  );
  XORCY   \porta1/Mcount_count_xor<12>  (
    .CI(\porta1/Mcount_count_cy [11]),
    .LI(\porta1/Mcount_count_cy<12>_rt_833 ),
    .O(\porta1/Result [12])
  );
  MUXCY   \porta1/Mcount_count_cy<12>  (
    .CI(\porta1/Mcount_count_cy [11]),
    .DI(N0),
    .S(\porta1/Mcount_count_cy<12>_rt_833 ),
    .O(\porta1/Mcount_count_cy [12])
  );
  XORCY   \porta1/Mcount_count_xor<11>  (
    .CI(\porta1/Mcount_count_cy [10]),
    .LI(\porta1/Mcount_count_cy<11>_rt_831 ),
    .O(\porta1/Result [11])
  );
  MUXCY   \porta1/Mcount_count_cy<11>  (
    .CI(\porta1/Mcount_count_cy [10]),
    .DI(N0),
    .S(\porta1/Mcount_count_cy<11>_rt_831 ),
    .O(\porta1/Mcount_count_cy [11])
  );
  XORCY   \porta1/Mcount_count_xor<10>  (
    .CI(\porta1/Mcount_count_cy [9]),
    .LI(\porta1/Mcount_count_cy<10>_rt_829 ),
    .O(\porta1/Result [10])
  );
  MUXCY   \porta1/Mcount_count_cy<10>  (
    .CI(\porta1/Mcount_count_cy [9]),
    .DI(N0),
    .S(\porta1/Mcount_count_cy<10>_rt_829 ),
    .O(\porta1/Mcount_count_cy [10])
  );
  XORCY   \porta1/Mcount_count_xor<9>  (
    .CI(\porta1/Mcount_count_cy [8]),
    .LI(\porta1/Mcount_count_cy<9>_rt_887 ),
    .O(\porta1/Result [9])
  );
  MUXCY   \porta1/Mcount_count_cy<9>  (
    .CI(\porta1/Mcount_count_cy [8]),
    .DI(N0),
    .S(\porta1/Mcount_count_cy<9>_rt_887 ),
    .O(\porta1/Mcount_count_cy [9])
  );
  XORCY   \porta1/Mcount_count_xor<8>  (
    .CI(\porta1/Mcount_count_cy [7]),
    .LI(\porta1/Mcount_count_cy<8>_rt_885 ),
    .O(\porta1/Result [8])
  );
  MUXCY   \porta1/Mcount_count_cy<8>  (
    .CI(\porta1/Mcount_count_cy [7]),
    .DI(N0),
    .S(\porta1/Mcount_count_cy<8>_rt_885 ),
    .O(\porta1/Mcount_count_cy [8])
  );
  XORCY   \porta1/Mcount_count_xor<7>  (
    .CI(\porta1/Mcount_count_cy [6]),
    .LI(\porta1/Mcount_count_cy<7>_rt_883 ),
    .O(\porta1/Result [7])
  );
  MUXCY   \porta1/Mcount_count_cy<7>  (
    .CI(\porta1/Mcount_count_cy [6]),
    .DI(N0),
    .S(\porta1/Mcount_count_cy<7>_rt_883 ),
    .O(\porta1/Mcount_count_cy [7])
  );
  XORCY   \porta1/Mcount_count_xor<6>  (
    .CI(\porta1/Mcount_count_cy [5]),
    .LI(\porta1/Mcount_count_cy<6>_rt_881 ),
    .O(\porta1/Result [6])
  );
  MUXCY   \porta1/Mcount_count_cy<6>  (
    .CI(\porta1/Mcount_count_cy [5]),
    .DI(N0),
    .S(\porta1/Mcount_count_cy<6>_rt_881 ),
    .O(\porta1/Mcount_count_cy [6])
  );
  XORCY   \porta1/Mcount_count_xor<5>  (
    .CI(\porta1/Mcount_count_cy [4]),
    .LI(\porta1/Mcount_count_cy<5>_rt_879 ),
    .O(\porta1/Result [5])
  );
  MUXCY   \porta1/Mcount_count_cy<5>  (
    .CI(\porta1/Mcount_count_cy [4]),
    .DI(N0),
    .S(\porta1/Mcount_count_cy<5>_rt_879 ),
    .O(\porta1/Mcount_count_cy [5])
  );
  XORCY   \porta1/Mcount_count_xor<4>  (
    .CI(\porta1/Mcount_count_cy [3]),
    .LI(\porta1/Mcount_count_cy<4>_rt_877 ),
    .O(\porta1/Result [4])
  );
  MUXCY   \porta1/Mcount_count_cy<4>  (
    .CI(\porta1/Mcount_count_cy [3]),
    .DI(N0),
    .S(\porta1/Mcount_count_cy<4>_rt_877 ),
    .O(\porta1/Mcount_count_cy [4])
  );
  XORCY   \porta1/Mcount_count_xor<3>  (
    .CI(\porta1/Mcount_count_cy [2]),
    .LI(\porta1/Mcount_count_cy<3>_rt_875 ),
    .O(\porta1/Result [3])
  );
  MUXCY   \porta1/Mcount_count_cy<3>  (
    .CI(\porta1/Mcount_count_cy [2]),
    .DI(N0),
    .S(\porta1/Mcount_count_cy<3>_rt_875 ),
    .O(\porta1/Mcount_count_cy [3])
  );
  XORCY   \porta1/Mcount_count_xor<2>  (
    .CI(\porta1/Mcount_count_cy [1]),
    .LI(\porta1/Mcount_count_cy<2>_rt_871 ),
    .O(\porta1/Result [2])
  );
  MUXCY   \porta1/Mcount_count_cy<2>  (
    .CI(\porta1/Mcount_count_cy [1]),
    .DI(N0),
    .S(\porta1/Mcount_count_cy<2>_rt_871 ),
    .O(\porta1/Mcount_count_cy [2])
  );
  XORCY   \porta1/Mcount_count_xor<1>  (
    .CI(\porta1/Mcount_count_cy [0]),
    .LI(\porta1/Mcount_count_cy<1>_rt_849 ),
    .O(\porta1/Result [1])
  );
  MUXCY   \porta1/Mcount_count_cy<1>  (
    .CI(\porta1/Mcount_count_cy [0]),
    .DI(N0),
    .S(\porta1/Mcount_count_cy<1>_rt_849 ),
    .O(\porta1/Mcount_count_cy [1])
  );
  XORCY   \porta1/Mcount_count_xor<0>  (
    .CI(N0),
    .LI(\porta1/Mcount_count_lut [0]),
    .O(\porta1/Result [0])
  );
  MUXCY   \porta1/Mcount_count_cy<0>  (
    .CI(N0),
    .DI(N1),
    .S(\porta1/Mcount_count_lut [0]),
    .O(\porta1/Mcount_count_cy [0])
  );
  MUXCY   \porta1/Mcompar_note_out_cmp_ge0000_cy<5>  (
    .CI(\porta1/Mcompar_note_out_cmp_ge0000_cy [4]),
    .DI(\porta1/note_out [5]),
    .S(\porta1/Mcompar_note_out_cmp_ge0000_lut [5]),
    .O(\porta1/note_out_cmp_ge0000 )
  );
  LUT2 #(
    .INIT ( 4'h9 ))
  \porta1/Mcompar_note_out_cmp_ge0000_lut<5>  (
    .I0(\porta1/note_out [5]),
    .I1(note_in[5]),
    .O(\porta1/Mcompar_note_out_cmp_ge0000_lut [5])
  );
  MUXCY   \porta1/Mcompar_note_out_cmp_ge0000_cy<4>  (
    .CI(\porta1/Mcompar_note_out_cmp_ge0000_cy [3]),
    .DI(\porta1/note_out [4]),
    .S(\porta1/Mcompar_note_out_cmp_ge0000_lut [4]),
    .O(\porta1/Mcompar_note_out_cmp_ge0000_cy [4])
  );
  LUT2 #(
    .INIT ( 4'h9 ))
  \porta1/Mcompar_note_out_cmp_ge0000_lut<4>  (
    .I0(\porta1/note_out [4]),
    .I1(note_in[4]),
    .O(\porta1/Mcompar_note_out_cmp_ge0000_lut [4])
  );
  MUXCY   \porta1/Mcompar_note_out_cmp_ge0000_cy<3>  (
    .CI(\porta1/Mcompar_note_out_cmp_ge0000_cy [2]),
    .DI(\porta1/note_out [3]),
    .S(\porta1/Mcompar_note_out_cmp_ge0000_lut [3]),
    .O(\porta1/Mcompar_note_out_cmp_ge0000_cy [3])
  );
  LUT2 #(
    .INIT ( 4'h9 ))
  \porta1/Mcompar_note_out_cmp_ge0000_lut<3>  (
    .I0(\porta1/note_out [3]),
    .I1(note_in[3]),
    .O(\porta1/Mcompar_note_out_cmp_ge0000_lut [3])
  );
  MUXCY   \porta1/Mcompar_note_out_cmp_ge0000_cy<2>  (
    .CI(\porta1/Mcompar_note_out_cmp_ge0000_cy [1]),
    .DI(\porta1/note_out [2]),
    .S(\porta1/Mcompar_note_out_cmp_ge0000_lut [2]),
    .O(\porta1/Mcompar_note_out_cmp_ge0000_cy [2])
  );
  LUT2 #(
    .INIT ( 4'h9 ))
  \porta1/Mcompar_note_out_cmp_ge0000_lut<2>  (
    .I0(\porta1/note_out [2]),
    .I1(note_in[2]),
    .O(\porta1/Mcompar_note_out_cmp_ge0000_lut [2])
  );
  MUXCY   \porta1/Mcompar_note_out_cmp_ge0000_cy<1>  (
    .CI(\porta1/Mcompar_note_out_cmp_ge0000_cy [0]),
    .DI(\porta1/note_out [1]),
    .S(\porta1/Mcompar_note_out_cmp_ge0000_lut [1]),
    .O(\porta1/Mcompar_note_out_cmp_ge0000_cy [1])
  );
  LUT2 #(
    .INIT ( 4'h9 ))
  \porta1/Mcompar_note_out_cmp_ge0000_lut<1>  (
    .I0(\porta1/note_out [1]),
    .I1(note_in[1]),
    .O(\porta1/Mcompar_note_out_cmp_ge0000_lut [1])
  );
  MUXCY   \porta1/Mcompar_note_out_cmp_ge0000_cy<0>  (
    .CI(N1),
    .DI(\porta1/note_out [0]),
    .S(\porta1/Mcompar_note_out_cmp_ge0000_lut [0]),
    .O(\porta1/Mcompar_note_out_cmp_ge0000_cy [0])
  );
  LUT2 #(
    .INIT ( 4'h9 ))
  \porta1/Mcompar_note_out_cmp_ge0000_lut<0>  (
    .I0(\porta1/note_out [0]),
    .I1(note_in[0]),
    .O(\porta1/Mcompar_note_out_cmp_ge0000_lut [0])
  );
  XORCY   \porta1/Madd__old_count_1_xor<31>  (
    .CI(\porta1/Madd__old_count_1_cy [30]),
    .LI(\porta1/Madd__old_count_1_xor<31>_rt_783 ),
    .O(\porta1/_old_count_1 [31])
  );
  XORCY   \porta1/Madd__old_count_1_xor<30>  (
    .CI(\porta1/Madd__old_count_1_cy [29]),
    .LI(\porta1/Madd__old_count_1_cy<30>_rt_767 ),
    .O(\porta1/_old_count_1 [30])
  );
  MUXCY   \porta1/Madd__old_count_1_cy<30>  (
    .CI(\porta1/Madd__old_count_1_cy [29]),
    .DI(N0),
    .S(\porta1/Madd__old_count_1_cy<30>_rt_767 ),
    .O(\porta1/Madd__old_count_1_cy [30])
  );
  XORCY   \porta1/Madd__old_count_1_xor<29>  (
    .CI(\porta1/Madd__old_count_1_cy [28]),
    .LI(\porta1/Madd__old_count_1_cy<29>_rt_763 ),
    .O(\porta1/_old_count_1 [29])
  );
  MUXCY   \porta1/Madd__old_count_1_cy<29>  (
    .CI(\porta1/Madd__old_count_1_cy [28]),
    .DI(N0),
    .S(\porta1/Madd__old_count_1_cy<29>_rt_763 ),
    .O(\porta1/Madd__old_count_1_cy [29])
  );
  XORCY   \porta1/Madd__old_count_1_xor<28>  (
    .CI(\porta1/Madd__old_count_1_cy [27]),
    .LI(\porta1/Madd__old_count_1_cy<28>_rt_761 ),
    .O(\porta1/_old_count_1 [28])
  );
  MUXCY   \porta1/Madd__old_count_1_cy<28>  (
    .CI(\porta1/Madd__old_count_1_cy [27]),
    .DI(N0),
    .S(\porta1/Madd__old_count_1_cy<28>_rt_761 ),
    .O(\porta1/Madd__old_count_1_cy [28])
  );
  XORCY   \porta1/Madd__old_count_1_xor<27>  (
    .CI(\porta1/Madd__old_count_1_cy [26]),
    .LI(\porta1/Madd__old_count_1_cy<27>_rt_759 ),
    .O(\porta1/_old_count_1 [27])
  );
  MUXCY   \porta1/Madd__old_count_1_cy<27>  (
    .CI(\porta1/Madd__old_count_1_cy [26]),
    .DI(N0),
    .S(\porta1/Madd__old_count_1_cy<27>_rt_759 ),
    .O(\porta1/Madd__old_count_1_cy [27])
  );
  XORCY   \porta1/Madd__old_count_1_xor<26>  (
    .CI(\porta1/Madd__old_count_1_cy [25]),
    .LI(\porta1/Madd__old_count_1_cy<26>_rt_757 ),
    .O(\porta1/_old_count_1 [26])
  );
  MUXCY   \porta1/Madd__old_count_1_cy<26>  (
    .CI(\porta1/Madd__old_count_1_cy [25]),
    .DI(N0),
    .S(\porta1/Madd__old_count_1_cy<26>_rt_757 ),
    .O(\porta1/Madd__old_count_1_cy [26])
  );
  XORCY   \porta1/Madd__old_count_1_xor<25>  (
    .CI(\porta1/Madd__old_count_1_cy [24]),
    .LI(\porta1/Madd__old_count_1_cy<25>_rt_755 ),
    .O(\porta1/_old_count_1 [25])
  );
  MUXCY   \porta1/Madd__old_count_1_cy<25>  (
    .CI(\porta1/Madd__old_count_1_cy [24]),
    .DI(N0),
    .S(\porta1/Madd__old_count_1_cy<25>_rt_755 ),
    .O(\porta1/Madd__old_count_1_cy [25])
  );
  XORCY   \porta1/Madd__old_count_1_xor<24>  (
    .CI(\porta1/Madd__old_count_1_cy [23]),
    .LI(\porta1/Madd__old_count_1_cy<24>_rt_753 ),
    .O(\porta1/_old_count_1 [24])
  );
  MUXCY   \porta1/Madd__old_count_1_cy<24>  (
    .CI(\porta1/Madd__old_count_1_cy [23]),
    .DI(N0),
    .S(\porta1/Madd__old_count_1_cy<24>_rt_753 ),
    .O(\porta1/Madd__old_count_1_cy [24])
  );
  XORCY   \porta1/Madd__old_count_1_xor<23>  (
    .CI(\porta1/Madd__old_count_1_cy [22]),
    .LI(\porta1/Madd__old_count_1_cy<23>_rt_751 ),
    .O(\porta1/_old_count_1 [23])
  );
  MUXCY   \porta1/Madd__old_count_1_cy<23>  (
    .CI(\porta1/Madd__old_count_1_cy [22]),
    .DI(N0),
    .S(\porta1/Madd__old_count_1_cy<23>_rt_751 ),
    .O(\porta1/Madd__old_count_1_cy [23])
  );
  XORCY   \porta1/Madd__old_count_1_xor<22>  (
    .CI(\porta1/Madd__old_count_1_cy [21]),
    .LI(\porta1/Madd__old_count_1_cy<22>_rt_749 ),
    .O(\porta1/_old_count_1 [22])
  );
  MUXCY   \porta1/Madd__old_count_1_cy<22>  (
    .CI(\porta1/Madd__old_count_1_cy [21]),
    .DI(N0),
    .S(\porta1/Madd__old_count_1_cy<22>_rt_749 ),
    .O(\porta1/Madd__old_count_1_cy [22])
  );
  XORCY   \porta1/Madd__old_count_1_xor<21>  (
    .CI(\porta1/Madd__old_count_1_cy [20]),
    .LI(\porta1/Madd__old_count_1_cy<21>_rt_747 ),
    .O(\porta1/_old_count_1 [21])
  );
  MUXCY   \porta1/Madd__old_count_1_cy<21>  (
    .CI(\porta1/Madd__old_count_1_cy [20]),
    .DI(N0),
    .S(\porta1/Madd__old_count_1_cy<21>_rt_747 ),
    .O(\porta1/Madd__old_count_1_cy [21])
  );
  XORCY   \porta1/Madd__old_count_1_xor<20>  (
    .CI(\porta1/Madd__old_count_1_cy [19]),
    .LI(\porta1/Madd__old_count_1_cy<20>_rt_745 ),
    .O(\porta1/_old_count_1 [20])
  );
  MUXCY   \porta1/Madd__old_count_1_cy<20>  (
    .CI(\porta1/Madd__old_count_1_cy [19]),
    .DI(N0),
    .S(\porta1/Madd__old_count_1_cy<20>_rt_745 ),
    .O(\porta1/Madd__old_count_1_cy [20])
  );
  XORCY   \porta1/Madd__old_count_1_xor<19>  (
    .CI(\porta1/Madd__old_count_1_cy [18]),
    .LI(\porta1/Madd__old_count_1_cy<19>_rt_741 ),
    .O(\porta1/_old_count_1 [19])
  );
  MUXCY   \porta1/Madd__old_count_1_cy<19>  (
    .CI(\porta1/Madd__old_count_1_cy [18]),
    .DI(N0),
    .S(\porta1/Madd__old_count_1_cy<19>_rt_741 ),
    .O(\porta1/Madd__old_count_1_cy [19])
  );
  XORCY   \porta1/Madd__old_count_1_xor<18>  (
    .CI(\porta1/Madd__old_count_1_cy [17]),
    .LI(\porta1/Madd__old_count_1_cy<18>_rt_739 ),
    .O(\porta1/_old_count_1 [18])
  );
  MUXCY   \porta1/Madd__old_count_1_cy<18>  (
    .CI(\porta1/Madd__old_count_1_cy [17]),
    .DI(N0),
    .S(\porta1/Madd__old_count_1_cy<18>_rt_739 ),
    .O(\porta1/Madd__old_count_1_cy [18])
  );
  XORCY   \porta1/Madd__old_count_1_xor<17>  (
    .CI(\porta1/Madd__old_count_1_cy [16]),
    .LI(\porta1/Madd__old_count_1_cy<17>_rt_737 ),
    .O(\porta1/_old_count_1 [17])
  );
  MUXCY   \porta1/Madd__old_count_1_cy<17>  (
    .CI(\porta1/Madd__old_count_1_cy [16]),
    .DI(N0),
    .S(\porta1/Madd__old_count_1_cy<17>_rt_737 ),
    .O(\porta1/Madd__old_count_1_cy [17])
  );
  XORCY   \porta1/Madd__old_count_1_xor<16>  (
    .CI(\porta1/Madd__old_count_1_cy [15]),
    .LI(\porta1/Madd__old_count_1_cy<16>_rt_735 ),
    .O(\porta1/_old_count_1 [16])
  );
  MUXCY   \porta1/Madd__old_count_1_cy<16>  (
    .CI(\porta1/Madd__old_count_1_cy [15]),
    .DI(N0),
    .S(\porta1/Madd__old_count_1_cy<16>_rt_735 ),
    .O(\porta1/Madd__old_count_1_cy [16])
  );
  XORCY   \porta1/Madd__old_count_1_xor<15>  (
    .CI(\porta1/Madd__old_count_1_cy [14]),
    .LI(\porta1/Madd__old_count_1_cy<15>_rt_733 ),
    .O(\porta1/_old_count_1 [15])
  );
  MUXCY   \porta1/Madd__old_count_1_cy<15>  (
    .CI(\porta1/Madd__old_count_1_cy [14]),
    .DI(N0),
    .S(\porta1/Madd__old_count_1_cy<15>_rt_733 ),
    .O(\porta1/Madd__old_count_1_cy [15])
  );
  XORCY   \porta1/Madd__old_count_1_xor<14>  (
    .CI(\porta1/Madd__old_count_1_cy [13]),
    .LI(\porta1/Madd__old_count_1_cy<14>_rt_731 ),
    .O(\porta1/_old_count_1 [14])
  );
  MUXCY   \porta1/Madd__old_count_1_cy<14>  (
    .CI(\porta1/Madd__old_count_1_cy [13]),
    .DI(N0),
    .S(\porta1/Madd__old_count_1_cy<14>_rt_731 ),
    .O(\porta1/Madd__old_count_1_cy [14])
  );
  XORCY   \porta1/Madd__old_count_1_xor<13>  (
    .CI(\porta1/Madd__old_count_1_cy [12]),
    .LI(\porta1/Madd__old_count_1_cy<13>_rt_729 ),
    .O(\porta1/_old_count_1 [13])
  );
  MUXCY   \porta1/Madd__old_count_1_cy<13>  (
    .CI(\porta1/Madd__old_count_1_cy [12]),
    .DI(N0),
    .S(\porta1/Madd__old_count_1_cy<13>_rt_729 ),
    .O(\porta1/Madd__old_count_1_cy [13])
  );
  XORCY   \porta1/Madd__old_count_1_xor<12>  (
    .CI(\porta1/Madd__old_count_1_cy [11]),
    .LI(\porta1/Madd__old_count_1_cy<12>_rt_727 ),
    .O(\porta1/_old_count_1 [12])
  );
  MUXCY   \porta1/Madd__old_count_1_cy<12>  (
    .CI(\porta1/Madd__old_count_1_cy [11]),
    .DI(N0),
    .S(\porta1/Madd__old_count_1_cy<12>_rt_727 ),
    .O(\porta1/Madd__old_count_1_cy [12])
  );
  XORCY   \porta1/Madd__old_count_1_xor<11>  (
    .CI(\porta1/Madd__old_count_1_cy [10]),
    .LI(\porta1/Madd__old_count_1_cy<11>_rt_725 ),
    .O(\porta1/_old_count_1 [11])
  );
  MUXCY   \porta1/Madd__old_count_1_cy<11>  (
    .CI(\porta1/Madd__old_count_1_cy [10]),
    .DI(N0),
    .S(\porta1/Madd__old_count_1_cy<11>_rt_725 ),
    .O(\porta1/Madd__old_count_1_cy [11])
  );
  XORCY   \porta1/Madd__old_count_1_xor<10>  (
    .CI(\porta1/Madd__old_count_1_cy [9]),
    .LI(\porta1/Madd__old_count_1_cy<10>_rt_723 ),
    .O(\porta1/_old_count_1 [10])
  );
  MUXCY   \porta1/Madd__old_count_1_cy<10>  (
    .CI(\porta1/Madd__old_count_1_cy [9]),
    .DI(N0),
    .S(\porta1/Madd__old_count_1_cy<10>_rt_723 ),
    .O(\porta1/Madd__old_count_1_cy [10])
  );
  XORCY   \porta1/Madd__old_count_1_xor<9>  (
    .CI(\porta1/Madd__old_count_1_cy [8]),
    .LI(\porta1/Madd__old_count_1_cy<9>_rt_781 ),
    .O(\porta1/_old_count_1 [9])
  );
  MUXCY   \porta1/Madd__old_count_1_cy<9>  (
    .CI(\porta1/Madd__old_count_1_cy [8]),
    .DI(N0),
    .S(\porta1/Madd__old_count_1_cy<9>_rt_781 ),
    .O(\porta1/Madd__old_count_1_cy [9])
  );
  XORCY   \porta1/Madd__old_count_1_xor<8>  (
    .CI(\porta1/Madd__old_count_1_cy [7]),
    .LI(\porta1/Madd__old_count_1_cy<8>_rt_779 ),
    .O(\porta1/_old_count_1 [8])
  );
  MUXCY   \porta1/Madd__old_count_1_cy<8>  (
    .CI(\porta1/Madd__old_count_1_cy [7]),
    .DI(N0),
    .S(\porta1/Madd__old_count_1_cy<8>_rt_779 ),
    .O(\porta1/Madd__old_count_1_cy [8])
  );
  XORCY   \porta1/Madd__old_count_1_xor<7>  (
    .CI(\porta1/Madd__old_count_1_cy [6]),
    .LI(\porta1/Madd__old_count_1_cy<7>_rt_777 ),
    .O(\porta1/_old_count_1 [7])
  );
  MUXCY   \porta1/Madd__old_count_1_cy<7>  (
    .CI(\porta1/Madd__old_count_1_cy [6]),
    .DI(N0),
    .S(\porta1/Madd__old_count_1_cy<7>_rt_777 ),
    .O(\porta1/Madd__old_count_1_cy [7])
  );
  XORCY   \porta1/Madd__old_count_1_xor<6>  (
    .CI(\porta1/Madd__old_count_1_cy [5]),
    .LI(\porta1/Madd__old_count_1_cy<6>_rt_775 ),
    .O(\porta1/_old_count_1 [6])
  );
  MUXCY   \porta1/Madd__old_count_1_cy<6>  (
    .CI(\porta1/Madd__old_count_1_cy [5]),
    .DI(N0),
    .S(\porta1/Madd__old_count_1_cy<6>_rt_775 ),
    .O(\porta1/Madd__old_count_1_cy [6])
  );
  XORCY   \porta1/Madd__old_count_1_xor<5>  (
    .CI(\porta1/Madd__old_count_1_cy [4]),
    .LI(\porta1/Madd__old_count_1_cy<5>_rt_773 ),
    .O(\porta1/_old_count_1 [5])
  );
  MUXCY   \porta1/Madd__old_count_1_cy<5>  (
    .CI(\porta1/Madd__old_count_1_cy [4]),
    .DI(N0),
    .S(\porta1/Madd__old_count_1_cy<5>_rt_773 ),
    .O(\porta1/Madd__old_count_1_cy [5])
  );
  XORCY   \porta1/Madd__old_count_1_xor<4>  (
    .CI(\porta1/Madd__old_count_1_cy [3]),
    .LI(\porta1/Madd__old_count_1_cy<4>_rt_771 ),
    .O(\porta1/_old_count_1 [4])
  );
  MUXCY   \porta1/Madd__old_count_1_cy<4>  (
    .CI(\porta1/Madd__old_count_1_cy [3]),
    .DI(N0),
    .S(\porta1/Madd__old_count_1_cy<4>_rt_771 ),
    .O(\porta1/Madd__old_count_1_cy [4])
  );
  MUXCY   \porta1/Madd__old_count_1_cy<3>  (
    .CI(\porta1/Madd__old_count_1_cy [2]),
    .DI(N0),
    .S(\porta1/Madd__old_count_1_cy<3>_rt_769 ),
    .O(\porta1/Madd__old_count_1_cy [3])
  );
  MUXCY   \porta1/Madd__old_count_1_cy<2>  (
    .CI(\porta1/Madd__old_count_1_cy [1]),
    .DI(N0),
    .S(\porta1/Madd__old_count_1_cy<2>_rt_765 ),
    .O(\porta1/Madd__old_count_1_cy [2])
  );
  MUXCY   \porta1/Madd__old_count_1_cy<1>  (
    .CI(\porta1/Madd__old_count_1_cy [0]),
    .DI(N0),
    .S(\porta1/Madd__old_count_1_cy<1>_rt_743 ),
    .O(\porta1/Madd__old_count_1_cy [1])
  );
  MUXCY   \porta1/Madd__old_count_1_cy<0>  (
    .CI(N0),
    .DI(N1),
    .S(\porta1/Madd__old_count_1_lut [0]),
    .O(\porta1/Madd__old_count_1_cy [0])
  );
  FDR #(
    .INIT ( 1'b0 ))
  \porta1/count_31  (
    .C(clk_BUFGP_381),
    .D(\porta1/Result [31]),
    .R(\porta1/count_cmp_ge0000 ),
    .Q(\porta1/count [31])
  );
  FDR #(
    .INIT ( 1'b0 ))
  \porta1/count_30  (
    .C(clk_BUFGP_381),
    .D(\porta1/Result [30]),
    .R(\porta1/count_cmp_ge0000 ),
    .Q(\porta1/count [30])
  );
  FDR #(
    .INIT ( 1'b0 ))
  \porta1/count_29  (
    .C(clk_BUFGP_381),
    .D(\porta1/Result [29]),
    .R(\porta1/count_cmp_ge0000 ),
    .Q(\porta1/count [29])
  );
  FDR #(
    .INIT ( 1'b0 ))
  \porta1/count_28  (
    .C(clk_BUFGP_381),
    .D(\porta1/Result [28]),
    .R(\porta1/count_cmp_ge0000 ),
    .Q(\porta1/count [28])
  );
  FDR #(
    .INIT ( 1'b0 ))
  \porta1/count_27  (
    .C(clk_BUFGP_381),
    .D(\porta1/Result [27]),
    .R(\porta1/count_cmp_ge0000 ),
    .Q(\porta1/count [27])
  );
  FDR #(
    .INIT ( 1'b0 ))
  \porta1/count_26  (
    .C(clk_BUFGP_381),
    .D(\porta1/Result [26]),
    .R(\porta1/count_cmp_ge0000 ),
    .Q(\porta1/count [26])
  );
  FDR #(
    .INIT ( 1'b0 ))
  \porta1/count_25  (
    .C(clk_BUFGP_381),
    .D(\porta1/Result [25]),
    .R(\porta1/count_cmp_ge0000 ),
    .Q(\porta1/count [25])
  );
  FDR #(
    .INIT ( 1'b0 ))
  \porta1/count_24  (
    .C(clk_BUFGP_381),
    .D(\porta1/Result [24]),
    .R(\porta1/count_cmp_ge0000 ),
    .Q(\porta1/count [24])
  );
  FDR #(
    .INIT ( 1'b0 ))
  \porta1/count_23  (
    .C(clk_BUFGP_381),
    .D(\porta1/Result [23]),
    .R(\porta1/count_cmp_ge0000 ),
    .Q(\porta1/count [23])
  );
  FDR #(
    .INIT ( 1'b0 ))
  \porta1/count_22  (
    .C(clk_BUFGP_381),
    .D(\porta1/Result [22]),
    .R(\porta1/count_cmp_ge0000 ),
    .Q(\porta1/count [22])
  );
  FDR #(
    .INIT ( 1'b0 ))
  \porta1/count_21  (
    .C(clk_BUFGP_381),
    .D(\porta1/Result [21]),
    .R(\porta1/count_cmp_ge0000 ),
    .Q(\porta1/count [21])
  );
  FDR #(
    .INIT ( 1'b0 ))
  \porta1/count_20  (
    .C(clk_BUFGP_381),
    .D(\porta1/Result [20]),
    .R(\porta1/count_cmp_ge0000 ),
    .Q(\porta1/count [20])
  );
  FDR #(
    .INIT ( 1'b0 ))
  \porta1/count_19  (
    .C(clk_BUFGP_381),
    .D(\porta1/Result [19]),
    .R(\porta1/count_cmp_ge0000 ),
    .Q(\porta1/count [19])
  );
  FDR #(
    .INIT ( 1'b0 ))
  \porta1/count_18  (
    .C(clk_BUFGP_381),
    .D(\porta1/Result [18]),
    .R(\porta1/count_cmp_ge0000 ),
    .Q(\porta1/count [18])
  );
  FDR #(
    .INIT ( 1'b0 ))
  \porta1/count_17  (
    .C(clk_BUFGP_381),
    .D(\porta1/Result [17]),
    .R(\porta1/count_cmp_ge0000 ),
    .Q(\porta1/count [17])
  );
  FDR #(
    .INIT ( 1'b0 ))
  \porta1/count_16  (
    .C(clk_BUFGP_381),
    .D(\porta1/Result [16]),
    .R(\porta1/count_cmp_ge0000 ),
    .Q(\porta1/count [16])
  );
  FDR #(
    .INIT ( 1'b0 ))
  \porta1/count_15  (
    .C(clk_BUFGP_381),
    .D(\porta1/Result [15]),
    .R(\porta1/count_cmp_ge0000 ),
    .Q(\porta1/count [15])
  );
  FDR #(
    .INIT ( 1'b0 ))
  \porta1/count_14  (
    .C(clk_BUFGP_381),
    .D(\porta1/Result [14]),
    .R(\porta1/count_cmp_ge0000 ),
    .Q(\porta1/count [14])
  );
  FDR #(
    .INIT ( 1'b0 ))
  \porta1/count_13  (
    .C(clk_BUFGP_381),
    .D(\porta1/Result [13]),
    .R(\porta1/count_cmp_ge0000 ),
    .Q(\porta1/count [13])
  );
  FDR #(
    .INIT ( 1'b0 ))
  \porta1/count_12  (
    .C(clk_BUFGP_381),
    .D(\porta1/Result [12]),
    .R(\porta1/count_cmp_ge0000 ),
    .Q(\porta1/count [12])
  );
  FDR #(
    .INIT ( 1'b0 ))
  \porta1/count_11  (
    .C(clk_BUFGP_381),
    .D(\porta1/Result [11]),
    .R(\porta1/count_cmp_ge0000 ),
    .Q(\porta1/count [11])
  );
  FDR #(
    .INIT ( 1'b0 ))
  \porta1/count_10  (
    .C(clk_BUFGP_381),
    .D(\porta1/Result [10]),
    .R(\porta1/count_cmp_ge0000 ),
    .Q(\porta1/count [10])
  );
  FDR #(
    .INIT ( 1'b0 ))
  \porta1/count_9  (
    .C(clk_BUFGP_381),
    .D(\porta1/Result [9]),
    .R(\porta1/count_cmp_ge0000 ),
    .Q(\porta1/count [9])
  );
  FDR #(
    .INIT ( 1'b0 ))
  \porta1/count_8  (
    .C(clk_BUFGP_381),
    .D(\porta1/Result [8]),
    .R(\porta1/count_cmp_ge0000 ),
    .Q(\porta1/count [8])
  );
  FDR #(
    .INIT ( 1'b0 ))
  \porta1/count_7  (
    .C(clk_BUFGP_381),
    .D(\porta1/Result [7]),
    .R(\porta1/count_cmp_ge0000 ),
    .Q(\porta1/count [7])
  );
  FDR #(
    .INIT ( 1'b0 ))
  \porta1/count_6  (
    .C(clk_BUFGP_381),
    .D(\porta1/Result [6]),
    .R(\porta1/count_cmp_ge0000 ),
    .Q(\porta1/count [6])
  );
  FDR #(
    .INIT ( 1'b0 ))
  \porta1/count_5  (
    .C(clk_BUFGP_381),
    .D(\porta1/Result [5]),
    .R(\porta1/count_cmp_ge0000 ),
    .Q(\porta1/count [5])
  );
  FDR #(
    .INIT ( 1'b0 ))
  \porta1/count_4  (
    .C(clk_BUFGP_381),
    .D(\porta1/Result [4]),
    .R(\porta1/count_cmp_ge0000 ),
    .Q(\porta1/count [4])
  );
  FDR #(
    .INIT ( 1'b0 ))
  \porta1/count_3  (
    .C(clk_BUFGP_381),
    .D(\porta1/Result [3]),
    .R(\porta1/count_cmp_ge0000 ),
    .Q(\porta1/count [3])
  );
  FDR #(
    .INIT ( 1'b0 ))
  \porta1/count_2  (
    .C(clk_BUFGP_381),
    .D(\porta1/Result [2]),
    .R(\porta1/count_cmp_ge0000 ),
    .Q(\porta1/count [2])
  );
  FDR #(
    .INIT ( 1'b0 ))
  \porta1/count_1  (
    .C(clk_BUFGP_381),
    .D(\porta1/Result [1]),
    .R(\porta1/count_cmp_ge0000 ),
    .Q(\porta1/count [1])
  );
  FDR #(
    .INIT ( 1'b0 ))
  \porta1/count_0  (
    .C(clk_BUFGP_381),
    .D(\porta1/Result [0]),
    .R(\porta1/count_cmp_ge0000 ),
    .Q(\porta1/count [0])
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \porta1/note_out_5  (
    .C(\porta1/note_clk_986 ),
    .CE(\porta1/note_out_not0001 ),
    .D(\porta1/note_out_mux0000 [5]),
    .R(\porta1/en_inv ),
    .Q(\porta1/note_out [5])
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \porta1/note_out_4  (
    .C(\porta1/note_clk_986 ),
    .CE(\porta1/note_out_not0001 ),
    .D(\porta1/note_out_mux0000 [4]),
    .R(\porta1/en_inv ),
    .Q(\porta1/note_out [4])
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \porta1/note_out_3  (
    .C(\porta1/note_clk_986 ),
    .CE(\porta1/note_out_not0001 ),
    .D(\porta1/note_out_mux0000 [3]),
    .R(\porta1/en_inv ),
    .Q(\porta1/note_out [3])
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \porta1/note_out_2  (
    .C(\porta1/note_clk_986 ),
    .CE(\porta1/note_out_not0001 ),
    .D(\porta1/note_out_mux0000 [2]),
    .R(\porta1/en_inv ),
    .Q(\porta1/note_out [2])
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \porta1/note_out_1  (
    .C(\porta1/note_clk_986 ),
    .CE(\porta1/note_out_not0001 ),
    .D(\porta1/note_out_mux0000 [1]),
    .R(\porta1/en_inv ),
    .Q(\porta1/note_out [1])
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \porta1/note_out_0  (
    .C(\porta1/note_clk_986 ),
    .CE(\porta1/note_out_not0001 ),
    .D(\porta1/note_out_mux0000 [0]),
    .R(\porta1/en_inv ),
    .Q(\porta1/note_out [0])
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \porta1/en_flag  (
    .C(\porta1/note_clk_986 ),
    .CE(\porta1/en_flag_inv ),
    .D(N1),
    .R(\porta1/en_inv ),
    .Q(\porta1/en_flag_983 )
  );
  FDE #(
    .INIT ( 1'b0 ))
  \porta1/note_clk  (
    .C(clk_BUFGP_381),
    .CE(\porta1/count_cmp_ge0000 ),
    .D(\porta1/note_clk_not0001 ),
    .Q(\porta1/note_clk_986 )
  );
  MUXCY   \freqgen2/Mcompar_freq_out_cmp_gt0000_cy<14>  (
    .CI(\freqgen2/Mcompar_freq_out_cmp_gt0000_cy [13]),
    .DI(N0),
    .S(\freqgen2/Mcompar_freq_out_cmp_gt0000_lut [14]),
    .O(\freqgen2/Mcompar_freq_out_cmp_gt0000_cy [14])
  );
  LUT2 #(
    .INIT ( 4'h1 ))
  \freqgen2/Mcompar_freq_out_cmp_gt0000_lut<14>  (
    .I0(\freqgen2/count [14]),
    .I1(\freqgen2/count [15]),
    .O(\freqgen2/Mcompar_freq_out_cmp_gt0000_lut [14])
  );
  MUXCY   \freqgen2/Mcompar_freq_out_cmp_gt0000_cy<13>  (
    .CI(\freqgen2/Mcompar_freq_out_cmp_gt0000_cy [12]),
    .DI(N0),
    .S(\freqgen2/Mcompar_freq_out_cmp_gt0000_lut [13]),
    .O(\freqgen2/Mcompar_freq_out_cmp_gt0000_cy [13])
  );
  MUXCY   \freqgen2/Mcompar_freq_out_cmp_gt0000_cy<12>  (
    .CI(\freqgen2/Mcompar_freq_out_cmp_gt0000_cy [11]),
    .DI(N0),
    .S(\freqgen2/Mcompar_freq_out_cmp_gt0000_lut [12]),
    .O(\freqgen2/Mcompar_freq_out_cmp_gt0000_cy [12])
  );
  MUXCY   \freqgen2/Mcompar_freq_out_cmp_gt0000_cy<11>  (
    .CI(\freqgen2/Mcompar_freq_out_cmp_gt0000_cy [10]),
    .DI(N0),
    .S(\freqgen2/Mcompar_freq_out_cmp_gt0000_lut [11]),
    .O(\freqgen2/Mcompar_freq_out_cmp_gt0000_cy [11])
  );
  MUXCY   \freqgen2/Mcompar_freq_out_cmp_gt0000_cy<10>  (
    .CI(\freqgen2/Mcompar_freq_out_cmp_gt0000_cy [9]),
    .DI(N0),
    .S(\freqgen2/Mcompar_freq_out_cmp_gt0000_lut [10]),
    .O(\freqgen2/Mcompar_freq_out_cmp_gt0000_cy [10])
  );
  MUXCY   \freqgen2/Mcompar_freq_out_cmp_gt0000_cy<9>  (
    .CI(\freqgen2/Mcompar_freq_out_cmp_gt0000_cy [8]),
    .DI(N0),
    .S(\freqgen2/Mcompar_freq_out_cmp_gt0000_lut [9]),
    .O(\freqgen2/Mcompar_freq_out_cmp_gt0000_cy [9])
  );
  MUXCY   \freqgen2/Mcompar_freq_out_cmp_gt0000_cy<8>  (
    .CI(\freqgen2/Mcompar_freq_out_cmp_gt0000_cy [7]),
    .DI(N0),
    .S(\freqgen2/Mcompar_freq_out_cmp_gt0000_lut [8]),
    .O(\freqgen2/Mcompar_freq_out_cmp_gt0000_cy [8])
  );
  MUXCY   \freqgen2/Mcompar_freq_out_cmp_gt0000_cy<7>  (
    .CI(\freqgen2/Mcompar_freq_out_cmp_gt0000_cy [6]),
    .DI(N0),
    .S(\freqgen2/Mcompar_freq_out_cmp_gt0000_lut [7]),
    .O(\freqgen2/Mcompar_freq_out_cmp_gt0000_cy [7])
  );
  MUXCY   \freqgen2/Mcompar_freq_out_cmp_gt0000_cy<6>  (
    .CI(\freqgen2/Mcompar_freq_out_cmp_gt0000_cy [5]),
    .DI(N0),
    .S(\freqgen2/Mcompar_freq_out_cmp_gt0000_lut [6]),
    .O(\freqgen2/Mcompar_freq_out_cmp_gt0000_cy [6])
  );
  MUXCY   \freqgen2/Mcompar_freq_out_cmp_gt0000_cy<5>  (
    .CI(\freqgen2/Mcompar_freq_out_cmp_gt0000_cy [4]),
    .DI(N0),
    .S(\freqgen2/Mcompar_freq_out_cmp_gt0000_lut [5]),
    .O(\freqgen2/Mcompar_freq_out_cmp_gt0000_cy [5])
  );
  MUXCY   \freqgen2/Mcompar_freq_out_cmp_gt0000_cy<4>  (
    .CI(\freqgen2/Mcompar_freq_out_cmp_gt0000_cy [3]),
    .DI(N0),
    .S(\freqgen2/Mcompar_freq_out_cmp_gt0000_lut [4]),
    .O(\freqgen2/Mcompar_freq_out_cmp_gt0000_cy [4])
  );
  MUXCY   \freqgen2/Mcompar_freq_out_cmp_gt0000_cy<3>  (
    .CI(\freqgen2/Mcompar_freq_out_cmp_gt0000_cy [2]),
    .DI(N0),
    .S(\freqgen2/Mcompar_freq_out_cmp_gt0000_lut [3]),
    .O(\freqgen2/Mcompar_freq_out_cmp_gt0000_cy [3])
  );
  MUXCY   \freqgen2/Mcompar_freq_out_cmp_gt0000_cy<2>  (
    .CI(\freqgen2/Mcompar_freq_out_cmp_gt0000_cy [1]),
    .DI(N0),
    .S(\freqgen2/Mcompar_freq_out_cmp_gt0000_lut [2]),
    .O(\freqgen2/Mcompar_freq_out_cmp_gt0000_cy [2])
  );
  MUXCY   \freqgen2/Mcompar_freq_out_cmp_gt0000_cy<1>  (
    .CI(\freqgen2/Mcompar_freq_out_cmp_gt0000_cy [0]),
    .DI(N0),
    .S(\freqgen2/Mcompar_freq_out_cmp_gt0000_lut [1]),
    .O(\freqgen2/Mcompar_freq_out_cmp_gt0000_cy [1])
  );
  MUXCY   \freqgen2/Mcompar_freq_out_cmp_gt0000_cy<0>  (
    .CI(N1),
    .DI(N0),
    .S(\freqgen2/Mcompar_freq_out_cmp_gt0000_lut [0]),
    .O(\freqgen2/Mcompar_freq_out_cmp_gt0000_cy [0])
  );
  XORCY   \freqgen2/Madd_count_add0000_xor<15>  (
    .CI(\freqgen2/Madd_count_add0000_cy [14]),
    .LI(\freqgen2/_old_count_3 [15]),
    .O(\freqgen2/count_add0000 [15])
  );
  XORCY   \freqgen2/Madd_count_add0000_xor<14>  (
    .CI(\freqgen2/Madd_count_add0000_cy [13]),
    .LI(\freqgen2/_old_count_3 [14]),
    .O(\freqgen2/count_add0000 [14])
  );
  MUXCY   \freqgen2/Madd_count_add0000_cy<14>  (
    .CI(\freqgen2/Madd_count_add0000_cy [13]),
    .DI(N0),
    .S(\freqgen2/_old_count_3 [14]),
    .O(\freqgen2/Madd_count_add0000_cy [14])
  );
  XORCY   \freqgen2/Madd_count_add0000_xor<13>  (
    .CI(\freqgen2/Madd_count_add0000_cy [12]),
    .LI(\freqgen2/_old_count_3 [13]),
    .O(\freqgen2/count_add0000 [13])
  );
  MUXCY   \freqgen2/Madd_count_add0000_cy<13>  (
    .CI(\freqgen2/Madd_count_add0000_cy [12]),
    .DI(N0),
    .S(\freqgen2/_old_count_3 [13]),
    .O(\freqgen2/Madd_count_add0000_cy [13])
  );
  XORCY   \freqgen2/Madd_count_add0000_xor<12>  (
    .CI(\freqgen2/Madd_count_add0000_cy [11]),
    .LI(\freqgen2/_old_count_3 [12]),
    .O(\freqgen2/count_add0000 [12])
  );
  MUXCY   \freqgen2/Madd_count_add0000_cy<12>  (
    .CI(\freqgen2/Madd_count_add0000_cy [11]),
    .DI(N0),
    .S(\freqgen2/_old_count_3 [12]),
    .O(\freqgen2/Madd_count_add0000_cy [12])
  );
  XORCY   \freqgen2/Madd_count_add0000_xor<11>  (
    .CI(\freqgen2/Madd_count_add0000_cy [10]),
    .LI(\freqgen2/_old_count_3 [11]),
    .O(\freqgen2/count_add0000 [11])
  );
  MUXCY   \freqgen2/Madd_count_add0000_cy<11>  (
    .CI(\freqgen2/Madd_count_add0000_cy [10]),
    .DI(N0),
    .S(\freqgen2/_old_count_3 [11]),
    .O(\freqgen2/Madd_count_add0000_cy [11])
  );
  XORCY   \freqgen2/Madd_count_add0000_xor<10>  (
    .CI(\freqgen2/Madd_count_add0000_cy [9]),
    .LI(\freqgen2/_old_count_3 [10]),
    .O(\freqgen2/count_add0000 [10])
  );
  MUXCY   \freqgen2/Madd_count_add0000_cy<10>  (
    .CI(\freqgen2/Madd_count_add0000_cy [9]),
    .DI(N0),
    .S(\freqgen2/_old_count_3 [10]),
    .O(\freqgen2/Madd_count_add0000_cy [10])
  );
  XORCY   \freqgen2/Madd_count_add0000_xor<9>  (
    .CI(\freqgen2/Madd_count_add0000_cy [8]),
    .LI(\freqgen2/_old_count_3 [9]),
    .O(\freqgen2/count_add0000 [9])
  );
  MUXCY   \freqgen2/Madd_count_add0000_cy<9>  (
    .CI(\freqgen2/Madd_count_add0000_cy [8]),
    .DI(N0),
    .S(\freqgen2/_old_count_3 [9]),
    .O(\freqgen2/Madd_count_add0000_cy [9])
  );
  XORCY   \freqgen2/Madd_count_add0000_xor<8>  (
    .CI(\freqgen2/Madd_count_add0000_cy [7]),
    .LI(\freqgen2/_old_count_3 [8]),
    .O(\freqgen2/count_add0000 [8])
  );
  MUXCY   \freqgen2/Madd_count_add0000_cy<8>  (
    .CI(\freqgen2/Madd_count_add0000_cy [7]),
    .DI(N0),
    .S(\freqgen2/_old_count_3 [8]),
    .O(\freqgen2/Madd_count_add0000_cy [8])
  );
  XORCY   \freqgen2/Madd_count_add0000_xor<7>  (
    .CI(\freqgen2/Madd_count_add0000_cy [6]),
    .LI(\freqgen2/_old_count_3 [7]),
    .O(\freqgen2/count_add0000 [7])
  );
  MUXCY   \freqgen2/Madd_count_add0000_cy<7>  (
    .CI(\freqgen2/Madd_count_add0000_cy [6]),
    .DI(N0),
    .S(\freqgen2/_old_count_3 [7]),
    .O(\freqgen2/Madd_count_add0000_cy [7])
  );
  XORCY   \freqgen2/Madd_count_add0000_xor<6>  (
    .CI(\freqgen2/Madd_count_add0000_cy [5]),
    .LI(\freqgen2/_old_count_3 [6]),
    .O(\freqgen2/count_add0000 [6])
  );
  MUXCY   \freqgen2/Madd_count_add0000_cy<6>  (
    .CI(\freqgen2/Madd_count_add0000_cy [5]),
    .DI(N0),
    .S(\freqgen2/_old_count_3 [6]),
    .O(\freqgen2/Madd_count_add0000_cy [6])
  );
  XORCY   \freqgen2/Madd_count_add0000_xor<5>  (
    .CI(\freqgen2/Madd_count_add0000_cy [4]),
    .LI(\freqgen2/_old_count_3 [5]),
    .O(\freqgen2/count_add0000 [5])
  );
  MUXCY   \freqgen2/Madd_count_add0000_cy<5>  (
    .CI(\freqgen2/Madd_count_add0000_cy [4]),
    .DI(N0),
    .S(\freqgen2/_old_count_3 [5]),
    .O(\freqgen2/Madd_count_add0000_cy [5])
  );
  XORCY   \freqgen2/Madd_count_add0000_xor<4>  (
    .CI(\freqgen2/Madd_count_add0000_cy [3]),
    .LI(\freqgen2/_old_count_3 [4]),
    .O(\freqgen2/count_add0000 [4])
  );
  MUXCY   \freqgen2/Madd_count_add0000_cy<4>  (
    .CI(\freqgen2/Madd_count_add0000_cy [3]),
    .DI(N0),
    .S(\freqgen2/_old_count_3 [4]),
    .O(\freqgen2/Madd_count_add0000_cy [4])
  );
  XORCY   \freqgen2/Madd_count_add0000_xor<3>  (
    .CI(\freqgen2/Madd_count_add0000_cy [2]),
    .LI(\freqgen2/_old_count_3 [3]),
    .O(\freqgen2/count_add0000 [3])
  );
  MUXCY   \freqgen2/Madd_count_add0000_cy<3>  (
    .CI(\freqgen2/Madd_count_add0000_cy [2]),
    .DI(N0),
    .S(\freqgen2/_old_count_3 [3]),
    .O(\freqgen2/Madd_count_add0000_cy [3])
  );
  XORCY   \freqgen2/Madd_count_add0000_xor<2>  (
    .CI(\freqgen2/Madd_count_add0000_cy [1]),
    .LI(\freqgen2/_old_count_3 [2]),
    .O(\freqgen2/count_add0000 [2])
  );
  MUXCY   \freqgen2/Madd_count_add0000_cy<2>  (
    .CI(\freqgen2/Madd_count_add0000_cy [1]),
    .DI(N0),
    .S(\freqgen2/_old_count_3 [2]),
    .O(\freqgen2/Madd_count_add0000_cy [2])
  );
  XORCY   \freqgen2/Madd_count_add0000_xor<1>  (
    .CI(\freqgen2/Madd_count_add0000_cy [0]),
    .LI(\freqgen2/_old_count_3 [1]),
    .O(\freqgen2/count_add0000 [1])
  );
  MUXCY   \freqgen2/Madd_count_add0000_cy<1>  (
    .CI(\freqgen2/Madd_count_add0000_cy [0]),
    .DI(N0),
    .S(\freqgen2/_old_count_3 [1]),
    .O(\freqgen2/Madd_count_add0000_cy [1])
  );
  XORCY   \freqgen2/Madd_count_add0000_xor<0>  (
    .CI(N0),
    .LI(\freqgen2/Madd_count_add0000_lut [0]),
    .O(\freqgen2/count_add0000 [0])
  );
  MUXCY   \freqgen2/Madd_count_add0000_cy<0>  (
    .CI(N0),
    .DI(N1),
    .S(\freqgen2/Madd_count_add0000_lut [0]),
    .O(\freqgen2/Madd_count_add0000_cy [0])
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \freqgen2/freq_out  (
    .C(clk_BUFGP_381),
    .CE(\freqgen2/freq_out_cmp_gt0000 ),
    .D(\freqgen2/freq_out_not0001 ),
    .R(N1),
    .Q(\freqgen2/freq_out_655 )
  );
  FD #(
    .INIT ( 1'b0 ))
  \freqgen2/count_15  (
    .C(clk_BUFGP_381),
    .D(\freqgen2/count_add0000 [15]),
    .Q(\freqgen2/count [15])
  );
  FD #(
    .INIT ( 1'b0 ))
  \freqgen2/count_14  (
    .C(clk_BUFGP_381),
    .D(\freqgen2/count_add0000 [14]),
    .Q(\freqgen2/count [14])
  );
  FD #(
    .INIT ( 1'b0 ))
  \freqgen2/count_13  (
    .C(clk_BUFGP_381),
    .D(\freqgen2/count_add0000 [13]),
    .Q(\freqgen2/count [13])
  );
  FD #(
    .INIT ( 1'b0 ))
  \freqgen2/count_12  (
    .C(clk_BUFGP_381),
    .D(\freqgen2/count_add0000 [12]),
    .Q(\freqgen2/count [12])
  );
  FD #(
    .INIT ( 1'b0 ))
  \freqgen2/count_11  (
    .C(clk_BUFGP_381),
    .D(\freqgen2/count_add0000 [11]),
    .Q(\freqgen2/count [11])
  );
  FD #(
    .INIT ( 1'b0 ))
  \freqgen2/count_10  (
    .C(clk_BUFGP_381),
    .D(\freqgen2/count_add0000 [10]),
    .Q(\freqgen2/count [10])
  );
  FD #(
    .INIT ( 1'b0 ))
  \freqgen2/count_9  (
    .C(clk_BUFGP_381),
    .D(\freqgen2/count_add0000 [9]),
    .Q(\freqgen2/count [9])
  );
  FD #(
    .INIT ( 1'b0 ))
  \freqgen2/count_8  (
    .C(clk_BUFGP_381),
    .D(\freqgen2/count_add0000 [8]),
    .Q(\freqgen2/count [8])
  );
  FD #(
    .INIT ( 1'b0 ))
  \freqgen2/count_7  (
    .C(clk_BUFGP_381),
    .D(\freqgen2/count_add0000 [7]),
    .Q(\freqgen2/count [7])
  );
  FD #(
    .INIT ( 1'b0 ))
  \freqgen2/count_6  (
    .C(clk_BUFGP_381),
    .D(\freqgen2/count_add0000 [6]),
    .Q(\freqgen2/count [6])
  );
  FD #(
    .INIT ( 1'b0 ))
  \freqgen2/count_5  (
    .C(clk_BUFGP_381),
    .D(\freqgen2/count_add0000 [5]),
    .Q(\freqgen2/count [5])
  );
  FD #(
    .INIT ( 1'b0 ))
  \freqgen2/count_4  (
    .C(clk_BUFGP_381),
    .D(\freqgen2/count_add0000 [4]),
    .Q(\freqgen2/count [4])
  );
  FD #(
    .INIT ( 1'b0 ))
  \freqgen2/count_3  (
    .C(clk_BUFGP_381),
    .D(\freqgen2/count_add0000 [3]),
    .Q(\freqgen2/count [3])
  );
  FD #(
    .INIT ( 1'b0 ))
  \freqgen2/count_2  (
    .C(clk_BUFGP_381),
    .D(\freqgen2/count_add0000 [2]),
    .Q(\freqgen2/count [2])
  );
  FD #(
    .INIT ( 1'b0 ))
  \freqgen2/count_1  (
    .C(clk_BUFGP_381),
    .D(\freqgen2/count_add0000 [1]),
    .Q(\freqgen2/count [1])
  );
  FD #(
    .INIT ( 1'b0 ))
  \freqgen2/count_0  (
    .C(clk_BUFGP_381),
    .D(\freqgen2/count_add0000 [0]),
    .Q(\freqgen2/count [0])
  );
  MUXCY   \freqgen/Mcompar_freq_out_cmp_gt0000_cy<14>  (
    .CI(\freqgen/Mcompar_freq_out_cmp_gt0000_cy [13]),
    .DI(N0),
    .S(\freqgen/Mcompar_freq_out_cmp_gt0000_lut [14]),
    .O(\freqgen/Mcompar_freq_out_cmp_gt0000_cy [14])
  );
  LUT2 #(
    .INIT ( 4'h1 ))
  \freqgen/Mcompar_freq_out_cmp_gt0000_lut<14>  (
    .I0(\freqgen/count [14]),
    .I1(\freqgen/count [15]),
    .O(\freqgen/Mcompar_freq_out_cmp_gt0000_lut [14])
  );
  MUXCY   \freqgen/Mcompar_freq_out_cmp_gt0000_cy<13>  (
    .CI(\freqgen/Mcompar_freq_out_cmp_gt0000_cy [12]),
    .DI(\freqgen/N4_mand1 ),
    .S(\freqgen/Mcompar_freq_out_cmp_gt0000_lut [13]),
    .O(\freqgen/Mcompar_freq_out_cmp_gt0000_cy [13])
  );
  LUT3 #(
    .INIT ( 8'h93 ))
  \freqgen/Mcompar_freq_out_cmp_gt0000_lut<13>  (
    .I0(\freqgen/N4_mand_506 ),
    .I1(\freqgen/count [13]),
    .I2(\freqgen/Mrom__old_base_freq_217 ),
    .O(\freqgen/Mcompar_freq_out_cmp_gt0000_lut [13])
  );
  MULT_AND   \freqgen/N4_mand  (
    .I0(\freqgen/Mrom__old_base_freq_217 ),
    .I1(\freqgen/N4_mand_506 ),
    .LO(\freqgen/N4_mand1 )
  );
  MUXCY   \freqgen/Mcompar_freq_out_cmp_gt0000_cy<12>  (
    .CI(\freqgen/Mcompar_freq_out_cmp_gt0000_cy [11]),
    .DI(\freqgen/N3 ),
    .S(\freqgen/Mcompar_freq_out_cmp_gt0000_lut [12]),
    .O(\freqgen/Mcompar_freq_out_cmp_gt0000_cy [12])
  );
  LUT2 #(
    .INIT ( 4'h9 ))
  \freqgen/Mcompar_freq_out_cmp_gt0000_lut<12>  (
    .I0(\freqgen/N3 ),
    .I1(\freqgen/count [12]),
    .O(\freqgen/Mcompar_freq_out_cmp_gt0000_lut [12])
  );
  MUXCY   \freqgen/Mcompar_freq_out_cmp_gt0000_cy<11>  (
    .CI(\freqgen/Mcompar_freq_out_cmp_gt0000_cy [10]),
    .DI(\freqgen/N2 ),
    .S(\freqgen/Mcompar_freq_out_cmp_gt0000_lut [11]),
    .O(\freqgen/Mcompar_freq_out_cmp_gt0000_cy [11])
  );
  LUT2 #(
    .INIT ( 4'h9 ))
  \freqgen/Mcompar_freq_out_cmp_gt0000_lut<11>  (
    .I0(\freqgen/N2 ),
    .I1(\freqgen/count [11]),
    .O(\freqgen/Mcompar_freq_out_cmp_gt0000_lut [11])
  );
  MUXCY   \freqgen/Mcompar_freq_out_cmp_gt0000_cy<10>  (
    .CI(\freqgen/Mcompar_freq_out_cmp_gt0000_cy [9]),
    .DI(\freqgen/Mrom__old_base_freq_210_f6_435 ),
    .S(\freqgen/Mcompar_freq_out_cmp_gt0000_lut [10]),
    .O(\freqgen/Mcompar_freq_out_cmp_gt0000_cy [10])
  );
  LUT2 #(
    .INIT ( 4'h9 ))
  \freqgen/Mcompar_freq_out_cmp_gt0000_lut<10>  (
    .I0(\freqgen/Mrom__old_base_freq_210_f6_435 ),
    .I1(\freqgen/count [10]),
    .O(\freqgen/Mcompar_freq_out_cmp_gt0000_lut [10])
  );
  MUXCY   \freqgen/Mcompar_freq_out_cmp_gt0000_cy<9>  (
    .CI(\freqgen/Mcompar_freq_out_cmp_gt0000_cy [8]),
    .DI(\freqgen/Mrom__old_base_freq_29_f6_500 ),
    .S(\freqgen/Mcompar_freq_out_cmp_gt0000_lut [9]),
    .O(\freqgen/Mcompar_freq_out_cmp_gt0000_cy [9])
  );
  LUT2 #(
    .INIT ( 4'h9 ))
  \freqgen/Mcompar_freq_out_cmp_gt0000_lut<9>  (
    .I0(\freqgen/Mrom__old_base_freq_29_f6_500 ),
    .I1(\freqgen/count [9]),
    .O(\freqgen/Mcompar_freq_out_cmp_gt0000_lut [9])
  );
  MUXCY   \freqgen/Mcompar_freq_out_cmp_gt0000_cy<8>  (
    .CI(\freqgen/Mcompar_freq_out_cmp_gt0000_cy [7]),
    .DI(\freqgen/Mrom__old_base_freq_28_f6_493 ),
    .S(\freqgen/Mcompar_freq_out_cmp_gt0000_lut [8]),
    .O(\freqgen/Mcompar_freq_out_cmp_gt0000_cy [8])
  );
  LUT2 #(
    .INIT ( 4'h9 ))
  \freqgen/Mcompar_freq_out_cmp_gt0000_lut<8>  (
    .I0(\freqgen/Mrom__old_base_freq_28_f6_493 ),
    .I1(\freqgen/count [8]),
    .O(\freqgen/Mcompar_freq_out_cmp_gt0000_lut [8])
  );
  MUXCY   \freqgen/Mcompar_freq_out_cmp_gt0000_cy<7>  (
    .CI(\freqgen/Mcompar_freq_out_cmp_gt0000_cy [6]),
    .DI(\freqgen/Mrom__old_base_freq_27_f6_486 ),
    .S(\freqgen/Mcompar_freq_out_cmp_gt0000_lut [7]),
    .O(\freqgen/Mcompar_freq_out_cmp_gt0000_cy [7])
  );
  LUT2 #(
    .INIT ( 4'h9 ))
  \freqgen/Mcompar_freq_out_cmp_gt0000_lut<7>  (
    .I0(\freqgen/Mrom__old_base_freq_27_f6_486 ),
    .I1(\freqgen/count [7]),
    .O(\freqgen/Mcompar_freq_out_cmp_gt0000_lut [7])
  );
  MUXCY   \freqgen/Mcompar_freq_out_cmp_gt0000_cy<6>  (
    .CI(\freqgen/Mcompar_freq_out_cmp_gt0000_cy [5]),
    .DI(\freqgen/Mrom__old_base_freq_26_f6_479 ),
    .S(\freqgen/Mcompar_freq_out_cmp_gt0000_lut [6]),
    .O(\freqgen/Mcompar_freq_out_cmp_gt0000_cy [6])
  );
  LUT2 #(
    .INIT ( 4'h9 ))
  \freqgen/Mcompar_freq_out_cmp_gt0000_lut<6>  (
    .I0(\freqgen/Mrom__old_base_freq_26_f6_479 ),
    .I1(\freqgen/count [6]),
    .O(\freqgen/Mcompar_freq_out_cmp_gt0000_lut [6])
  );
  MUXCY   \freqgen/Mcompar_freq_out_cmp_gt0000_cy<5>  (
    .CI(\freqgen/Mcompar_freq_out_cmp_gt0000_cy [4]),
    .DI(\freqgen/Mrom__old_base_freq_25_f6_473 ),
    .S(\freqgen/Mcompar_freq_out_cmp_gt0000_lut [5]),
    .O(\freqgen/Mcompar_freq_out_cmp_gt0000_cy [5])
  );
  LUT2 #(
    .INIT ( 4'h9 ))
  \freqgen/Mcompar_freq_out_cmp_gt0000_lut<5>  (
    .I0(\freqgen/Mrom__old_base_freq_25_f6_473 ),
    .I1(\freqgen/count [5]),
    .O(\freqgen/Mcompar_freq_out_cmp_gt0000_lut [5])
  );
  MUXCY   \freqgen/Mcompar_freq_out_cmp_gt0000_cy<4>  (
    .CI(\freqgen/Mcompar_freq_out_cmp_gt0000_cy [3]),
    .DI(\freqgen/Mrom__old_base_freq_24_f6_466 ),
    .S(\freqgen/Mcompar_freq_out_cmp_gt0000_lut [4]),
    .O(\freqgen/Mcompar_freq_out_cmp_gt0000_cy [4])
  );
  LUT2 #(
    .INIT ( 4'h9 ))
  \freqgen/Mcompar_freq_out_cmp_gt0000_lut<4>  (
    .I0(\freqgen/Mrom__old_base_freq_24_f6_466 ),
    .I1(\freqgen/count [4]),
    .O(\freqgen/Mcompar_freq_out_cmp_gt0000_lut [4])
  );
  MUXCY   \freqgen/Mcompar_freq_out_cmp_gt0000_cy<3>  (
    .CI(\freqgen/Mcompar_freq_out_cmp_gt0000_cy [2]),
    .DI(\freqgen/Mrom__old_base_freq_23_f6_459 ),
    .S(\freqgen/Mcompar_freq_out_cmp_gt0000_lut [3]),
    .O(\freqgen/Mcompar_freq_out_cmp_gt0000_cy [3])
  );
  LUT2 #(
    .INIT ( 4'h9 ))
  \freqgen/Mcompar_freq_out_cmp_gt0000_lut<3>  (
    .I0(\freqgen/Mrom__old_base_freq_23_f6_459 ),
    .I1(\freqgen/count [3]),
    .O(\freqgen/Mcompar_freq_out_cmp_gt0000_lut [3])
  );
  MUXCY   \freqgen/Mcompar_freq_out_cmp_gt0000_cy<2>  (
    .CI(\freqgen/Mcompar_freq_out_cmp_gt0000_cy [1]),
    .DI(\freqgen/Mrom__old_base_freq_22_f6_451 ),
    .S(\freqgen/Mcompar_freq_out_cmp_gt0000_lut [2]),
    .O(\freqgen/Mcompar_freq_out_cmp_gt0000_cy [2])
  );
  LUT2 #(
    .INIT ( 4'h9 ))
  \freqgen/Mcompar_freq_out_cmp_gt0000_lut<2>  (
    .I0(\freqgen/Mrom__old_base_freq_22_f6_451 ),
    .I1(\freqgen/count [2]),
    .O(\freqgen/Mcompar_freq_out_cmp_gt0000_lut [2])
  );
  MUXCY   \freqgen/Mcompar_freq_out_cmp_gt0000_cy<1>  (
    .CI(\freqgen/Mcompar_freq_out_cmp_gt0000_cy [0]),
    .DI(\freqgen/Mrom__old_base_freq_21_f6_443 ),
    .S(\freqgen/Mcompar_freq_out_cmp_gt0000_lut [1]),
    .O(\freqgen/Mcompar_freq_out_cmp_gt0000_cy [1])
  );
  LUT2 #(
    .INIT ( 4'h9 ))
  \freqgen/Mcompar_freq_out_cmp_gt0000_lut<1>  (
    .I0(\freqgen/Mrom__old_base_freq_21_f6_443 ),
    .I1(\freqgen/count [1]),
    .O(\freqgen/Mcompar_freq_out_cmp_gt0000_lut [1])
  );
  MUXCY   \freqgen/Mcompar_freq_out_cmp_gt0000_cy<0>  (
    .CI(N1),
    .DI(\freqgen/Mrom__old_base_freq_2_f6_503 ),
    .S(\freqgen/Mcompar_freq_out_cmp_gt0000_lut [0]),
    .O(\freqgen/Mcompar_freq_out_cmp_gt0000_cy [0])
  );
  LUT2 #(
    .INIT ( 4'h9 ))
  \freqgen/Mcompar_freq_out_cmp_gt0000_lut<0>  (
    .I0(\freqgen/Mrom__old_base_freq_2_f6_503 ),
    .I1(\freqgen/count [0]),
    .O(\freqgen/Mcompar_freq_out_cmp_gt0000_lut [0])
  );
  XORCY   \freqgen/Madd_count_add0000_xor<15>  (
    .CI(\freqgen/Madd_count_add0000_cy [14]),
    .LI(\freqgen/_old_count_3 [15]),
    .O(\freqgen/count_add0000 [15])
  );
  XORCY   \freqgen/Madd_count_add0000_xor<14>  (
    .CI(\freqgen/Madd_count_add0000_cy [13]),
    .LI(\freqgen/_old_count_3 [14]),
    .O(\freqgen/count_add0000 [14])
  );
  MUXCY   \freqgen/Madd_count_add0000_cy<14>  (
    .CI(\freqgen/Madd_count_add0000_cy [13]),
    .DI(N0),
    .S(\freqgen/_old_count_3 [14]),
    .O(\freqgen/Madd_count_add0000_cy [14])
  );
  XORCY   \freqgen/Madd_count_add0000_xor<13>  (
    .CI(\freqgen/Madd_count_add0000_cy [12]),
    .LI(\freqgen/_old_count_3 [13]),
    .O(\freqgen/count_add0000 [13])
  );
  MUXCY   \freqgen/Madd_count_add0000_cy<13>  (
    .CI(\freqgen/Madd_count_add0000_cy [12]),
    .DI(N0),
    .S(\freqgen/_old_count_3 [13]),
    .O(\freqgen/Madd_count_add0000_cy [13])
  );
  XORCY   \freqgen/Madd_count_add0000_xor<12>  (
    .CI(\freqgen/Madd_count_add0000_cy [11]),
    .LI(\freqgen/_old_count_3 [12]),
    .O(\freqgen/count_add0000 [12])
  );
  MUXCY   \freqgen/Madd_count_add0000_cy<12>  (
    .CI(\freqgen/Madd_count_add0000_cy [11]),
    .DI(N0),
    .S(\freqgen/_old_count_3 [12]),
    .O(\freqgen/Madd_count_add0000_cy [12])
  );
  XORCY   \freqgen/Madd_count_add0000_xor<11>  (
    .CI(\freqgen/Madd_count_add0000_cy [10]),
    .LI(\freqgen/_old_count_3 [11]),
    .O(\freqgen/count_add0000 [11])
  );
  MUXCY   \freqgen/Madd_count_add0000_cy<11>  (
    .CI(\freqgen/Madd_count_add0000_cy [10]),
    .DI(N0),
    .S(\freqgen/_old_count_3 [11]),
    .O(\freqgen/Madd_count_add0000_cy [11])
  );
  XORCY   \freqgen/Madd_count_add0000_xor<10>  (
    .CI(\freqgen/Madd_count_add0000_cy [9]),
    .LI(\freqgen/_old_count_3 [10]),
    .O(\freqgen/count_add0000 [10])
  );
  MUXCY   \freqgen/Madd_count_add0000_cy<10>  (
    .CI(\freqgen/Madd_count_add0000_cy [9]),
    .DI(N0),
    .S(\freqgen/_old_count_3 [10]),
    .O(\freqgen/Madd_count_add0000_cy [10])
  );
  XORCY   \freqgen/Madd_count_add0000_xor<9>  (
    .CI(\freqgen/Madd_count_add0000_cy [8]),
    .LI(\freqgen/_old_count_3 [9]),
    .O(\freqgen/count_add0000 [9])
  );
  MUXCY   \freqgen/Madd_count_add0000_cy<9>  (
    .CI(\freqgen/Madd_count_add0000_cy [8]),
    .DI(N0),
    .S(\freqgen/_old_count_3 [9]),
    .O(\freqgen/Madd_count_add0000_cy [9])
  );
  XORCY   \freqgen/Madd_count_add0000_xor<8>  (
    .CI(\freqgen/Madd_count_add0000_cy [7]),
    .LI(\freqgen/_old_count_3 [8]),
    .O(\freqgen/count_add0000 [8])
  );
  MUXCY   \freqgen/Madd_count_add0000_cy<8>  (
    .CI(\freqgen/Madd_count_add0000_cy [7]),
    .DI(N0),
    .S(\freqgen/_old_count_3 [8]),
    .O(\freqgen/Madd_count_add0000_cy [8])
  );
  XORCY   \freqgen/Madd_count_add0000_xor<7>  (
    .CI(\freqgen/Madd_count_add0000_cy [6]),
    .LI(\freqgen/_old_count_3 [7]),
    .O(\freqgen/count_add0000 [7])
  );
  MUXCY   \freqgen/Madd_count_add0000_cy<7>  (
    .CI(\freqgen/Madd_count_add0000_cy [6]),
    .DI(N0),
    .S(\freqgen/_old_count_3 [7]),
    .O(\freqgen/Madd_count_add0000_cy [7])
  );
  XORCY   \freqgen/Madd_count_add0000_xor<6>  (
    .CI(\freqgen/Madd_count_add0000_cy [5]),
    .LI(\freqgen/_old_count_3 [6]),
    .O(\freqgen/count_add0000 [6])
  );
  MUXCY   \freqgen/Madd_count_add0000_cy<6>  (
    .CI(\freqgen/Madd_count_add0000_cy [5]),
    .DI(N0),
    .S(\freqgen/_old_count_3 [6]),
    .O(\freqgen/Madd_count_add0000_cy [6])
  );
  XORCY   \freqgen/Madd_count_add0000_xor<5>  (
    .CI(\freqgen/Madd_count_add0000_cy [4]),
    .LI(\freqgen/_old_count_3 [5]),
    .O(\freqgen/count_add0000 [5])
  );
  MUXCY   \freqgen/Madd_count_add0000_cy<5>  (
    .CI(\freqgen/Madd_count_add0000_cy [4]),
    .DI(N0),
    .S(\freqgen/_old_count_3 [5]),
    .O(\freqgen/Madd_count_add0000_cy [5])
  );
  XORCY   \freqgen/Madd_count_add0000_xor<4>  (
    .CI(\freqgen/Madd_count_add0000_cy [3]),
    .LI(\freqgen/_old_count_3 [4]),
    .O(\freqgen/count_add0000 [4])
  );
  MUXCY   \freqgen/Madd_count_add0000_cy<4>  (
    .CI(\freqgen/Madd_count_add0000_cy [3]),
    .DI(N0),
    .S(\freqgen/_old_count_3 [4]),
    .O(\freqgen/Madd_count_add0000_cy [4])
  );
  XORCY   \freqgen/Madd_count_add0000_xor<3>  (
    .CI(\freqgen/Madd_count_add0000_cy [2]),
    .LI(\freqgen/_old_count_3 [3]),
    .O(\freqgen/count_add0000 [3])
  );
  MUXCY   \freqgen/Madd_count_add0000_cy<3>  (
    .CI(\freqgen/Madd_count_add0000_cy [2]),
    .DI(N0),
    .S(\freqgen/_old_count_3 [3]),
    .O(\freqgen/Madd_count_add0000_cy [3])
  );
  XORCY   \freqgen/Madd_count_add0000_xor<2>  (
    .CI(\freqgen/Madd_count_add0000_cy [1]),
    .LI(\freqgen/_old_count_3 [2]),
    .O(\freqgen/count_add0000 [2])
  );
  MUXCY   \freqgen/Madd_count_add0000_cy<2>  (
    .CI(\freqgen/Madd_count_add0000_cy [1]),
    .DI(N0),
    .S(\freqgen/_old_count_3 [2]),
    .O(\freqgen/Madd_count_add0000_cy [2])
  );
  XORCY   \freqgen/Madd_count_add0000_xor<1>  (
    .CI(\freqgen/Madd_count_add0000_cy [0]),
    .LI(\freqgen/_old_count_3 [1]),
    .O(\freqgen/count_add0000 [1])
  );
  MUXCY   \freqgen/Madd_count_add0000_cy<1>  (
    .CI(\freqgen/Madd_count_add0000_cy [0]),
    .DI(N0),
    .S(\freqgen/_old_count_3 [1]),
    .O(\freqgen/Madd_count_add0000_cy [1])
  );
  XORCY   \freqgen/Madd_count_add0000_xor<0>  (
    .CI(N0),
    .LI(\freqgen/Madd_count_add0000_lut [0]),
    .O(\freqgen/count_add0000 [0])
  );
  MUXCY   \freqgen/Madd_count_add0000_cy<0>  (
    .CI(N0),
    .DI(N1),
    .S(\freqgen/Madd_count_add0000_lut [0]),
    .O(\freqgen/Madd_count_add0000_cy [0])
  );
  MUXF6   \freqgen/Mrom__old_base_freq_210_f6  (
    .I0(\freqgen/Mrom__old_base_freq_210_f5_433 ),
    .I1(\freqgen/Mrom__old_base_freq_210_430 ),
    .S(\porta1/note_out [5]),
    .O(\freqgen/Mrom__old_base_freq_210_f6_435 )
  );
  MUXF5   \freqgen/Mrom__old_base_freq_210_f5  (
    .I0(\freqgen/Mrom__old_base_freq_210_f51_434 ),
    .I1(\freqgen/Mrom__old_base_freq_2101_431 ),
    .S(\porta1/note_out [4]),
    .O(\freqgen/Mrom__old_base_freq_210_f5_433 )
  );
  LUT4 #(
    .INIT ( 16'hD596 ))
  \freqgen/Mrom__old_base_freq_2102  (
    .I0(\porta1/note_out [1]),
    .I1(\porta1/note_out [2]),
    .I2(\porta1/note_out [3]),
    .I3(\porta1/note_out [0]),
    .O(\freqgen/Mrom__old_base_freq_2102_432 )
  );
  LUT4 #(
    .INIT ( 16'h2226 ))
  \freqgen/Mrom__old_base_freq_2101  (
    .I0(\porta1/note_out [2]),
    .I1(\porta1/note_out [3]),
    .I2(\porta1/note_out [0]),
    .I3(\porta1/note_out [1]),
    .O(\freqgen/Mrom__old_base_freq_2101_431 )
  );
  LUT3 #(
    .INIT ( 8'h15 ))
  \freqgen/Mrom__old_base_freq_210  (
    .I0(\porta1/note_out [4]),
    .I1(\porta1/note_out [3]),
    .I2(\porta1/note_out [2]),
    .O(\freqgen/Mrom__old_base_freq_210_430 )
  );
  MUXF6   \freqgen/Mrom__old_base_freq_29_f6  (
    .I0(\freqgen/Mrom__old_base_freq_29_f51 ),
    .I1(\freqgen/Mrom__old_base_freq_29_f5_497 ),
    .S(\porta1/note_out [5]),
    .O(\freqgen/Mrom__old_base_freq_29_f6_500 )
  );
  MUXF5   \freqgen/Mrom__old_base_freq_29_f5_0  (
    .I0(\freqgen/Mrom__old_base_freq_29_f5_0_499 ),
    .I1(\freqgen/Mrom__old_base_freq_292_496 ),
    .S(\porta1/note_out [4]),
    .O(\freqgen/Mrom__old_base_freq_29_f51 )
  );
  LUT4 #(
    .INIT ( 16'h7496 ))
  \freqgen/Mrom__old_base_freq_293  (
    .I0(\porta1/note_out [0]),
    .I1(\porta1/note_out [2]),
    .I2(\porta1/note_out [3]),
    .I3(\porta1/note_out [1]),
    .O(\freqgen/Mrom__old_base_freq_25 )
  );
  LUT4 #(
    .INIT ( 16'h2725 ))
  \freqgen/Mrom__old_base_freq_292  (
    .I0(\porta1/note_out [3]),
    .I1(\porta1/note_out [2]),
    .I2(\porta1/note_out [1]),
    .I3(\porta1/note_out [0]),
    .O(\freqgen/Mrom__old_base_freq_292_496 )
  );
  MUXF5   \freqgen/Mrom__old_base_freq_29_f5  (
    .I0(\freqgen/Mrom__old_base_freq_291_495 ),
    .I1(\freqgen/Mrom__old_base_freq_29 ),
    .S(\porta1/note_out [4]),
    .O(\freqgen/Mrom__old_base_freq_29_f5_497 )
  );
  LUT4 #(
    .INIT ( 16'h999D ))
  \freqgen/Mrom__old_base_freq_291  (
    .I0(\porta1/note_out [3]),
    .I1(\porta1/note_out [2]),
    .I2(\porta1/note_out [0]),
    .I3(\porta1/note_out [1]),
    .O(\freqgen/Mrom__old_base_freq_291_495 )
  );
  MUXF6   \freqgen/Mrom__old_base_freq_28_f6  (
    .I0(\freqgen/Mrom__old_base_freq_28_f51 ),
    .I1(\freqgen/Mrom__old_base_freq_28_f5_491 ),
    .S(\porta1/note_out [5]),
    .O(\freqgen/Mrom__old_base_freq_28_f6_493 )
  );
  MUXF5   \freqgen/Mrom__old_base_freq_28_f5_0  (
    .I0(\freqgen/Mrom__old_base_freq_283_490 ),
    .I1(\freqgen/Mrom__old_base_freq_282_489 ),
    .S(\porta1/note_out [4]),
    .O(\freqgen/Mrom__old_base_freq_28_f51 )
  );
  LUT4 #(
    .INIT ( 16'h361A ))
  \freqgen/Mrom__old_base_freq_283  (
    .I0(\porta1/note_out [3]),
    .I1(\porta1/note_out [1]),
    .I2(\porta1/note_out [2]),
    .I3(\porta1/note_out [0]),
    .O(\freqgen/Mrom__old_base_freq_283_490 )
  );
  LUT4 #(
    .INIT ( 16'h672D ))
  \freqgen/Mrom__old_base_freq_282  (
    .I0(\porta1/note_out [3]),
    .I1(\porta1/note_out [1]),
    .I2(\porta1/note_out [0]),
    .I3(\porta1/note_out [2]),
    .O(\freqgen/Mrom__old_base_freq_282_489 )
  );
  MUXF5   \freqgen/Mrom__old_base_freq_28_f5  (
    .I0(\freqgen/Mrom__old_base_freq_281_488 ),
    .I1(\freqgen/Mrom__old_base_freq_28_487 ),
    .S(\porta1/note_out [4]),
    .O(\freqgen/Mrom__old_base_freq_28_f5_491 )
  );
  LUT4 #(
    .INIT ( 16'hABA9 ))
  \freqgen/Mrom__old_base_freq_281  (
    .I0(\porta1/note_out [2]),
    .I1(\porta1/note_out [1]),
    .I2(\porta1/note_out [3]),
    .I3(\porta1/note_out [0]),
    .O(\freqgen/Mrom__old_base_freq_281_488 )
  );
  LUT4 #(
    .INIT ( 16'hAAAB ))
  \freqgen/Mrom__old_base_freq_28  (
    .I0(\porta1/note_out [3]),
    .I1(\porta1/note_out [0]),
    .I2(\porta1/note_out [1]),
    .I3(\porta1/note_out [2]),
    .O(\freqgen/Mrom__old_base_freq_28_487 )
  );
  MUXF6   \freqgen/Mrom__old_base_freq_27_f6  (
    .I0(\freqgen/Mrom__old_base_freq_27_f51 ),
    .I1(\freqgen/Mrom__old_base_freq_27_f5_484 ),
    .S(\porta1/note_out [5]),
    .O(\freqgen/Mrom__old_base_freq_27_f6_486 )
  );
  MUXF5   \freqgen/Mrom__old_base_freq_27_f5_0  (
    .I0(\freqgen/Mrom__old_base_freq_273_483 ),
    .I1(\freqgen/Mrom__old_base_freq_272_482 ),
    .S(\porta1/note_out [4]),
    .O(\freqgen/Mrom__old_base_freq_27_f51 )
  );
  LUT4 #(
    .INIT ( 16'hB168 ))
  \freqgen/Mrom__old_base_freq_273  (
    .I0(\porta1/note_out [2]),
    .I1(\porta1/note_out [3]),
    .I2(\porta1/note_out [1]),
    .I3(\porta1/note_out [0]),
    .O(\freqgen/Mrom__old_base_freq_273_483 )
  );
  LUT4 #(
    .INIT ( 16'h262F ))
  \freqgen/Mrom__old_base_freq_272  (
    .I0(\porta1/note_out [2]),
    .I1(\porta1/note_out [0]),
    .I2(\porta1/note_out [1]),
    .I3(\porta1/note_out [3]),
    .O(\freqgen/Mrom__old_base_freq_272_482 )
  );
  MUXF5   \freqgen/Mrom__old_base_freq_27_f5  (
    .I0(\freqgen/Mrom__old_base_freq_271_481 ),
    .I1(\freqgen/Mrom__old_base_freq_27_480 ),
    .S(\porta1/note_out [4]),
    .O(\freqgen/Mrom__old_base_freq_27_f5_484 )
  );
  LUT4 #(
    .INIT ( 16'h5667 ))
  \freqgen/Mrom__old_base_freq_271  (
    .I0(\porta1/note_out [1]),
    .I1(\porta1/note_out [3]),
    .I2(\porta1/note_out [0]),
    .I3(\porta1/note_out [2]),
    .O(\freqgen/Mrom__old_base_freq_271_481 )
  );
  LUT4 #(
    .INIT ( 16'h3732 ))
  \freqgen/Mrom__old_base_freq_27  (
    .I0(\porta1/note_out [0]),
    .I1(\porta1/note_out [2]),
    .I2(\porta1/note_out [1]),
    .I3(\porta1/note_out [3]),
    .O(\freqgen/Mrom__old_base_freq_27_480 )
  );
  MUXF6   \freqgen/Mrom__old_base_freq_26_f6  (
    .I0(\freqgen/Mrom__old_base_freq_26_f51 ),
    .I1(\freqgen/Mrom__old_base_freq_26_f5_477 ),
    .S(\porta1/note_out [5]),
    .O(\freqgen/Mrom__old_base_freq_26_f6_479 )
  );
  MUXF5   \freqgen/Mrom__old_base_freq_26_f5_0  (
    .I0(\freqgen/Mrom__old_base_freq_263_476 ),
    .I1(\freqgen/Mrom__old_base_freq_262_475 ),
    .S(\porta1/note_out [4]),
    .O(\freqgen/Mrom__old_base_freq_26_f51 )
  );
  LUT4 #(
    .INIT ( 16'hE240 ))
  \freqgen/Mrom__old_base_freq_263  (
    .I0(\porta1/note_out [3]),
    .I1(\porta1/note_out [1]),
    .I2(\porta1/note_out [2]),
    .I3(\porta1/note_out [0]),
    .O(\freqgen/Mrom__old_base_freq_263_476 )
  );
  LUT4 #(
    .INIT ( 16'hB49C ))
  \freqgen/Mrom__old_base_freq_262  (
    .I0(\porta1/note_out [0]),
    .I1(\porta1/note_out [1]),
    .I2(\porta1/note_out [3]),
    .I3(\porta1/note_out [2]),
    .O(\freqgen/Mrom__old_base_freq_262_475 )
  );
  MUXF5   \freqgen/Mrom__old_base_freq_26_f5  (
    .I0(\freqgen/Mrom__old_base_freq_261_474 ),
    .I1(\freqgen/Mrom__old_base_freq_2102_432 ),
    .S(\porta1/note_out [4]),
    .O(\freqgen/Mrom__old_base_freq_26_f5_477 )
  );
  LUT4 #(
    .INIT ( 16'hB31D ))
  \freqgen/Mrom__old_base_freq_261  (
    .I0(\porta1/note_out [2]),
    .I1(\porta1/note_out [0]),
    .I2(\porta1/note_out [1]),
    .I3(\porta1/note_out [3]),
    .O(\freqgen/Mrom__old_base_freq_261_474 )
  );
  MUXF6   \freqgen/Mrom__old_base_freq_25_f6  (
    .I0(\freqgen/Mrom__old_base_freq_25_f51 ),
    .I1(\freqgen/Mrom__old_base_freq_25_f5_471 ),
    .S(\porta1/note_out [5]),
    .O(\freqgen/Mrom__old_base_freq_25_f6_473 )
  );
  MUXF5   \freqgen/Mrom__old_base_freq_25_f5_0  (
    .I0(\freqgen/Mrom__old_base_freq_253_470 ),
    .I1(\freqgen/Mrom__old_base_freq_252_469 ),
    .S(\porta1/note_out [4]),
    .O(\freqgen/Mrom__old_base_freq_25_f51 )
  );
  LUT4 #(
    .INIT ( 16'h656E ))
  \freqgen/Mrom__old_base_freq_253  (
    .I0(\porta1/note_out [2]),
    .I1(\porta1/note_out [3]),
    .I2(\porta1/note_out [1]),
    .I3(\porta1/note_out [0]),
    .O(\freqgen/Mrom__old_base_freq_253_470 )
  );
  LUT4 #(
    .INIT ( 16'h6328 ))
  \freqgen/Mrom__old_base_freq_252  (
    .I0(\porta1/note_out [0]),
    .I1(\porta1/note_out [2]),
    .I2(\porta1/note_out [3]),
    .I3(\porta1/note_out [1]),
    .O(\freqgen/Mrom__old_base_freq_252_469 )
  );
  MUXF5   \freqgen/Mrom__old_base_freq_25_f5  (
    .I0(\freqgen/Mrom__old_base_freq_251_468 ),
    .I1(\freqgen/Mrom__old_base_freq_25 ),
    .S(\porta1/note_out [4]),
    .O(\freqgen/Mrom__old_base_freq_25_f5_471 )
  );
  LUT4 #(
    .INIT ( 16'h69BA ))
  \freqgen/Mrom__old_base_freq_251  (
    .I0(\porta1/note_out [3]),
    .I1(\porta1/note_out [0]),
    .I2(\porta1/note_out [2]),
    .I3(\porta1/note_out [1]),
    .O(\freqgen/Mrom__old_base_freq_251_468 )
  );
  MUXF6   \freqgen/Mrom__old_base_freq_24_f6  (
    .I0(\freqgen/Mrom__old_base_freq_24_f51 ),
    .I1(\freqgen/Mrom__old_base_freq_24_f5_464 ),
    .S(\porta1/note_out [5]),
    .O(\freqgen/Mrom__old_base_freq_24_f6_466 )
  );
  MUXF5   \freqgen/Mrom__old_base_freq_24_f5_0  (
    .I0(\freqgen/Mrom__old_base_freq_243_463 ),
    .I1(\freqgen/Mrom__old_base_freq_242_462 ),
    .S(\porta1/note_out [4]),
    .O(\freqgen/Mrom__old_base_freq_24_f51 )
  );
  LUT4 #(
    .INIT ( 16'h67A8 ))
  \freqgen/Mrom__old_base_freq_244  (
    .I0(\porta1/note_out [1]),
    .I1(\porta1/note_out [3]),
    .I2(\porta1/note_out [0]),
    .I3(\porta1/note_out [2]),
    .O(\freqgen/Mrom__old_base_freq_243_463 )
  );
  LUT4 #(
    .INIT ( 16'h32B7 ))
  \freqgen/Mrom__old_base_freq_243  (
    .I0(\porta1/note_out [1]),
    .I1(\porta1/note_out [3]),
    .I2(\porta1/note_out [2]),
    .I3(\porta1/note_out [0]),
    .O(\freqgen/Mrom__old_base_freq_242_462 )
  );
  MUXF5   \freqgen/Mrom__old_base_freq_24_f5  (
    .I0(\freqgen/Mrom__old_base_freq_241_461 ),
    .I1(\freqgen/Mrom__old_base_freq_24_460 ),
    .S(\porta1/note_out [4]),
    .O(\freqgen/Mrom__old_base_freq_24_f5_464 )
  );
  LUT4 #(
    .INIT ( 16'h590A ))
  \freqgen/Mrom__old_base_freq_242  (
    .I0(\porta1/note_out [0]),
    .I1(\porta1/note_out [2]),
    .I2(\porta1/note_out [3]),
    .I3(\porta1/note_out [1]),
    .O(\freqgen/Mrom__old_base_freq_241_461 )
  );
  LUT4 #(
    .INIT ( 16'h716D ))
  \freqgen/Mrom__old_base_freq_241  (
    .I0(\porta1/note_out [1]),
    .I1(\porta1/note_out [3]),
    .I2(\porta1/note_out [0]),
    .I3(\porta1/note_out [2]),
    .O(\freqgen/Mrom__old_base_freq_24_460 )
  );
  MUXF6   \freqgen/Mrom__old_base_freq_23_f6  (
    .I0(\freqgen/Mrom__old_base_freq_23_f51 ),
    .I1(\freqgen/Mrom__old_base_freq_23_f5_457 ),
    .S(\porta1/note_out [5]),
    .O(\freqgen/Mrom__old_base_freq_23_f6_459 )
  );
  MUXF5   \freqgen/Mrom__old_base_freq_23_f5_0  (
    .I0(\freqgen/Mrom__old_base_freq_234_456 ),
    .I1(\freqgen/Mrom__old_base_freq_233_455 ),
    .S(\porta1/note_out [4]),
    .O(\freqgen/Mrom__old_base_freq_23_f51 )
  );
  LUT4 #(
    .INIT ( 16'h8D26 ))
  \freqgen/Mrom__old_base_freq_234  (
    .I0(\porta1/note_out [1]),
    .I1(\porta1/note_out [2]),
    .I2(\porta1/note_out [3]),
    .I3(\porta1/note_out [0]),
    .O(\freqgen/Mrom__old_base_freq_234_456 )
  );
  LUT4 #(
    .INIT ( 16'h4F71 ))
  \freqgen/Mrom__old_base_freq_233  (
    .I0(\porta1/note_out [0]),
    .I1(\porta1/note_out [2]),
    .I2(\porta1/note_out [3]),
    .I3(\porta1/note_out [1]),
    .O(\freqgen/Mrom__old_base_freq_233_455 )
  );
  MUXF5   \freqgen/Mrom__old_base_freq_23_f5  (
    .I0(\freqgen/Mrom__old_base_freq_232_454 ),
    .I1(\freqgen/Mrom__old_base_freq_231_453 ),
    .S(\porta1/note_out [4]),
    .O(\freqgen/Mrom__old_base_freq_23_f5_457 )
  );
  LUT4 #(
    .INIT ( 16'h5297 ))
  \freqgen/Mrom__old_base_freq_232  (
    .I0(\porta1/note_out [0]),
    .I1(\porta1/note_out [2]),
    .I2(\porta1/note_out [3]),
    .I3(\porta1/note_out [1]),
    .O(\freqgen/Mrom__old_base_freq_232_454 )
  );
  LUT4 #(
    .INIT ( 16'h9642 ))
  \freqgen/Mrom__old_base_freq_231  (
    .I0(\porta1/note_out [0]),
    .I1(\porta1/note_out [2]),
    .I2(\porta1/note_out [3]),
    .I3(\porta1/note_out [1]),
    .O(\freqgen/Mrom__old_base_freq_231_453 )
  );
  MUXF6   \freqgen/Mrom__old_base_freq_22_f6  (
    .I0(\freqgen/Mrom__old_base_freq_22_f51 ),
    .I1(\freqgen/Mrom__old_base_freq_22_f5_449 ),
    .S(\porta1/note_out [5]),
    .O(\freqgen/Mrom__old_base_freq_22_f6_451 )
  );
  MUXF5   \freqgen/Mrom__old_base_freq_22_f5_0  (
    .I0(\freqgen/Mrom__old_base_freq_224_448 ),
    .I1(\freqgen/Mrom__old_base_freq_223_447 ),
    .S(\porta1/note_out [4]),
    .O(\freqgen/Mrom__old_base_freq_22_f51 )
  );
  LUT4 #(
    .INIT ( 16'h64FC ))
  \freqgen/Mrom__old_base_freq_224  (
    .I0(\porta1/note_out [1]),
    .I1(\porta1/note_out [3]),
    .I2(\porta1/note_out [2]),
    .I3(\porta1/note_out [0]),
    .O(\freqgen/Mrom__old_base_freq_224_448 )
  );
  LUT4 #(
    .INIT ( 16'h6563 ))
  \freqgen/Mrom__old_base_freq_223  (
    .I0(\porta1/note_out [0]),
    .I1(\porta1/note_out [2]),
    .I2(\porta1/note_out [1]),
    .I3(\porta1/note_out [3]),
    .O(\freqgen/Mrom__old_base_freq_223_447 )
  );
  MUXF5   \freqgen/Mrom__old_base_freq_22_f5  (
    .I0(\freqgen/Mrom__old_base_freq_222_446 ),
    .I1(\freqgen/Mrom__old_base_freq_221_445 ),
    .S(\porta1/note_out [4]),
    .O(\freqgen/Mrom__old_base_freq_22_f5_449 )
  );
  LUT4 #(
    .INIT ( 16'h92CC ))
  \freqgen/Mrom__old_base_freq_222  (
    .I0(\porta1/note_out [0]),
    .I1(\porta1/note_out [2]),
    .I2(\porta1/note_out [3]),
    .I3(\porta1/note_out [1]),
    .O(\freqgen/Mrom__old_base_freq_222_446 )
  );
  LUT4 #(
    .INIT ( 16'h9949 ))
  \freqgen/Mrom__old_base_freq_221  (
    .I0(\porta1/note_out [0]),
    .I1(\porta1/note_out [3]),
    .I2(\porta1/note_out [1]),
    .I3(\porta1/note_out [2]),
    .O(\freqgen/Mrom__old_base_freq_221_445 )
  );
  MUXF6   \freqgen/Mrom__old_base_freq_21_f6  (
    .I0(\freqgen/Mrom__old_base_freq_21_f51 ),
    .I1(\freqgen/Mrom__old_base_freq_21_f5_441 ),
    .S(\porta1/note_out [5]),
    .O(\freqgen/Mrom__old_base_freq_21_f6_443 )
  );
  MUXF5   \freqgen/Mrom__old_base_freq_21_f5_0  (
    .I0(\freqgen/Mrom__old_base_freq_214_439 ),
    .I1(\freqgen/Mrom__old_base_freq_213_438 ),
    .S(\porta1/note_out [4]),
    .O(\freqgen/Mrom__old_base_freq_21_f51 )
  );
  LUT4 #(
    .INIT ( 16'h1484 ))
  \freqgen/Mrom__old_base_freq_214  (
    .I0(\porta1/note_out [0]),
    .I1(\porta1/note_out [1]),
    .I2(\porta1/note_out [2]),
    .I3(\porta1/note_out [3]),
    .O(\freqgen/Mrom__old_base_freq_214_439 )
  );
  LUT4 #(
    .INIT ( 16'h566F ))
  \freqgen/Mrom__old_base_freq_213  (
    .I0(\porta1/note_out [1]),
    .I1(\porta1/note_out [2]),
    .I2(\porta1/note_out [3]),
    .I3(\porta1/note_out [0]),
    .O(\freqgen/Mrom__old_base_freq_213_438 )
  );
  MUXF5   \freqgen/Mrom__old_base_freq_21_f5  (
    .I0(\freqgen/Mrom__old_base_freq_212_437 ),
    .I1(\freqgen/Mrom__old_base_freq_211_436 ),
    .S(\porta1/note_out [4]),
    .O(\freqgen/Mrom__old_base_freq_21_f5_441 )
  );
  LUT4 #(
    .INIT ( 16'h8490 ))
  \freqgen/Mrom__old_base_freq_212  (
    .I0(\porta1/note_out [0]),
    .I1(\porta1/note_out [1]),
    .I2(\porta1/note_out [2]),
    .I3(\porta1/note_out [3]),
    .O(\freqgen/Mrom__old_base_freq_212_437 )
  );
  LUT4 #(
    .INIT ( 16'h148F ))
  \freqgen/Mrom__old_base_freq_211  (
    .I0(\porta1/note_out [0]),
    .I1(\porta1/note_out [3]),
    .I2(\porta1/note_out [1]),
    .I3(\porta1/note_out [2]),
    .O(\freqgen/Mrom__old_base_freq_211_436 )
  );
  MUXF6   \freqgen/Mrom__old_base_freq_2_f6  (
    .I0(\freqgen/Mrom__old_base_freq_2_f51 ),
    .I1(\freqgen/Mrom__old_base_freq_2_f5_501 ),
    .S(\porta1/note_out [5]),
    .O(\freqgen/Mrom__old_base_freq_2_f6_503 )
  );
  MUXF5   \freqgen/Mrom__old_base_freq_2_f5_0  (
    .I0(\freqgen/Mrom__old_base_freq_23_452 ),
    .I1(\freqgen/Mrom__old_base_freq_22_444 ),
    .S(\porta1/note_out [4]),
    .O(\freqgen/Mrom__old_base_freq_2_f51 )
  );
  LUT4 #(
    .INIT ( 16'h93C0 ))
  \freqgen/Mrom__old_base_freq_24  (
    .I0(\porta1/note_out [1]),
    .I1(\porta1/note_out [2]),
    .I2(\porta1/note_out [3]),
    .I3(\porta1/note_out [0]),
    .O(\freqgen/Mrom__old_base_freq_23_452 )
  );
  LUT4 #(
    .INIT ( 16'h5448 ))
  \freqgen/Mrom__old_base_freq_23  (
    .I0(\porta1/note_out [0]),
    .I1(\porta1/note_out [1]),
    .I2(\porta1/note_out [2]),
    .I3(\porta1/note_out [3]),
    .O(\freqgen/Mrom__old_base_freq_22_444 )
  );
  MUXF5   \freqgen/Mrom__old_base_freq_2_f5  (
    .I0(\freqgen/Mrom__old_base_freq_21_429 ),
    .I1(\freqgen/Mrom__old_base_freq_2 ),
    .S(\porta1/note_out [4]),
    .O(\freqgen/Mrom__old_base_freq_2_f5_501 )
  );
  LUT4 #(
    .INIT ( 16'h3663 ))
  \freqgen/Mrom__old_base_freq_22  (
    .I0(\porta1/note_out [0]),
    .I1(\porta1/note_out [1]),
    .I2(\porta1/note_out [2]),
    .I3(\porta1/note_out [3]),
    .O(\freqgen/Mrom__old_base_freq_21_429 )
  );
  LUT4 #(
    .INIT ( 16'hDB63 ))
  \freqgen/Mrom__old_base_freq_21  (
    .I0(\porta1/note_out [1]),
    .I1(\porta1/note_out [3]),
    .I2(\porta1/note_out [2]),
    .I3(\porta1/note_out [0]),
    .O(\freqgen/Mrom__old_base_freq_2 )
  );
  FDRE #(
    .INIT ( 1'b0 ))
  \freqgen/freq_out  (
    .C(clk_BUFGP_381),
    .CE(\freqgen/freq_out_cmp_gt0000 ),
    .D(\freqgen/freq_out_not0001 ),
    .R(\freqgen/freq_out_cmp_eq0000 ),
    .Q(\freqgen/freq_out_555 )
  );
  FD #(
    .INIT ( 1'b0 ))
  \freqgen/count_15  (
    .C(clk_BUFGP_381),
    .D(\freqgen/count_add0000 [15]),
    .Q(\freqgen/count [15])
  );
  FD #(
    .INIT ( 1'b0 ))
  \freqgen/count_14  (
    .C(clk_BUFGP_381),
    .D(\freqgen/count_add0000 [14]),
    .Q(\freqgen/count [14])
  );
  FD #(
    .INIT ( 1'b0 ))
  \freqgen/count_13  (
    .C(clk_BUFGP_381),
    .D(\freqgen/count_add0000 [13]),
    .Q(\freqgen/count [13])
  );
  FD #(
    .INIT ( 1'b0 ))
  \freqgen/count_12  (
    .C(clk_BUFGP_381),
    .D(\freqgen/count_add0000 [12]),
    .Q(\freqgen/count [12])
  );
  FD #(
    .INIT ( 1'b0 ))
  \freqgen/count_11  (
    .C(clk_BUFGP_381),
    .D(\freqgen/count_add0000 [11]),
    .Q(\freqgen/count [11])
  );
  FD #(
    .INIT ( 1'b0 ))
  \freqgen/count_10  (
    .C(clk_BUFGP_381),
    .D(\freqgen/count_add0000 [10]),
    .Q(\freqgen/count [10])
  );
  FD #(
    .INIT ( 1'b0 ))
  \freqgen/count_9  (
    .C(clk_BUFGP_381),
    .D(\freqgen/count_add0000 [9]),
    .Q(\freqgen/count [9])
  );
  FD #(
    .INIT ( 1'b0 ))
  \freqgen/count_8  (
    .C(clk_BUFGP_381),
    .D(\freqgen/count_add0000 [8]),
    .Q(\freqgen/count [8])
  );
  FD #(
    .INIT ( 1'b0 ))
  \freqgen/count_7  (
    .C(clk_BUFGP_381),
    .D(\freqgen/count_add0000 [7]),
    .Q(\freqgen/count [7])
  );
  FD #(
    .INIT ( 1'b0 ))
  \freqgen/count_6  (
    .C(clk_BUFGP_381),
    .D(\freqgen/count_add0000 [6]),
    .Q(\freqgen/count [6])
  );
  FD #(
    .INIT ( 1'b0 ))
  \freqgen/count_5  (
    .C(clk_BUFGP_381),
    .D(\freqgen/count_add0000 [5]),
    .Q(\freqgen/count [5])
  );
  FD #(
    .INIT ( 1'b0 ))
  \freqgen/count_4  (
    .C(clk_BUFGP_381),
    .D(\freqgen/count_add0000 [4]),
    .Q(\freqgen/count [4])
  );
  FD #(
    .INIT ( 1'b0 ))
  \freqgen/count_3  (
    .C(clk_BUFGP_381),
    .D(\freqgen/count_add0000 [3]),
    .Q(\freqgen/count [3])
  );
  FD #(
    .INIT ( 1'b0 ))
  \freqgen/count_2  (
    .C(clk_BUFGP_381),
    .D(\freqgen/count_add0000 [2]),
    .Q(\freqgen/count [2])
  );
  FD #(
    .INIT ( 1'b0 ))
  \freqgen/count_1  (
    .C(clk_BUFGP_381),
    .D(\freqgen/count_add0000 [1]),
    .Q(\freqgen/count [1])
  );
  FD #(
    .INIT ( 1'b0 ))
  \freqgen/count_0  (
    .C(clk_BUFGP_381),
    .D(\freqgen/count_add0000 [0]),
    .Q(\freqgen/count [0])
  );
  FDE #(
    .INIT ( 1'b0 ))
  \sqgen2/square_out_0  (
    .C(buffreq3),
    .CE(\sqgen2/count [4]),
    .D(\sqgen2/square_out_cmp_eq0000 ),
    .Q(\sqgen2/square_out [0])
  );
  FD #(
    .INIT ( 1'b0 ))
  \sqgen2/count_3  (
    .C(buffreq3),
    .D(\sqgen2/count_add0000[3] ),
    .Q(\sqgen2/count [3])
  );
  FD #(
    .INIT ( 1'b0 ))
  \sqgen2/count_0  (
    .C(buffreq3),
    .D(\sqgen2/count_add0000[0] ),
    .Q(\sqgen2/count [0])
  );
  FDE #(
    .INIT ( 1'b0 ))
  \sqgen1/square_out_0  (
    .C(buffreq1),
    .CE(\sqgen1/count [4]),
    .D(\sqgen1/square_out_cmp_eq0000 ),
    .Q(\sqgen1/square_out [0])
  );
  FD #(
    .INIT ( 1'b0 ))
  \sqgen1/count_3  (
    .C(buffreq1),
    .D(\sqgen1/count_add0000[3] ),
    .Q(\sqgen1/count [3])
  );
  FD #(
    .INIT ( 1'b0 ))
  \sqgen1/count_0  (
    .C(buffreq1),
    .D(\sqgen1/count_add0000[0] ),
    .Q(\sqgen1/count [0])
  );
  FDR #(
    .INIT ( 1'b0 ))
  \trgen2/count_5  (
    .C(buffreq4),
    .D(\trgen2/_old_count_5 [5]),
    .R(\trgen2/_old_count_5 [5]),
    .Q(\trgen2/count [5])
  );
  FDR #(
    .INIT ( 1'b0 ))
  \trgen2/count_4  (
    .C(buffreq4),
    .D(\trgen2/_old_count_5 [4]),
    .R(\trgen2/_old_count_5 [5]),
    .Q(\trgen2/count [4])
  );
  FDR #(
    .INIT ( 1'b0 ))
  \trgen2/count_3  (
    .C(buffreq4),
    .D(\trgen2/_old_count_5 [3]),
    .R(\trgen2/_old_count_5 [5]),
    .Q(\trgen2/count [3])
  );
  FDR #(
    .INIT ( 1'b0 ))
  \trgen2/count_2  (
    .C(buffreq4),
    .D(\trgen2/_old_count_5 [2]),
    .R(\trgen2/_old_count_5 [5]),
    .Q(\trgen2/count [2])
  );
  FDR #(
    .INIT ( 1'b0 ))
  \trgen2/count_1  (
    .C(buffreq4),
    .D(\trgen2/_old_count_5 [1]),
    .R(\trgen2/_old_count_5 [5]),
    .Q(\trgen2/count [1])
  );
  FDR #(
    .INIT ( 1'b0 ))
  \trgen2/count_0  (
    .C(buffreq4),
    .D(\trgen2/_old_count_5 [0]),
    .R(\trgen2/_old_count_5 [5]),
    .Q(\trgen2/count [0])
  );
  FDR #(
    .INIT ( 1'b0 ))
  \trgen1/count_5  (
    .C(buffreq2),
    .D(\trgen1/_old_count_5 [5]),
    .R(\trgen1/_old_count_5 [5]),
    .Q(\trgen1/count [5])
  );
  FDR #(
    .INIT ( 1'b0 ))
  \trgen1/count_4  (
    .C(buffreq2),
    .D(\trgen1/_old_count_5 [4]),
    .R(\trgen1/_old_count_5 [5]),
    .Q(\trgen1/count [4])
  );
  FDR #(
    .INIT ( 1'b0 ))
  \trgen1/count_3  (
    .C(buffreq2),
    .D(\trgen1/_old_count_5 [3]),
    .R(\trgen1/_old_count_5 [5]),
    .Q(\trgen1/count [3])
  );
  FDR #(
    .INIT ( 1'b0 ))
  \trgen1/count_2  (
    .C(buffreq2),
    .D(\trgen1/_old_count_5 [2]),
    .R(\trgen1/_old_count_5 [5]),
    .Q(\trgen1/count [2])
  );
  FDR #(
    .INIT ( 1'b0 ))
  \trgen1/count_1  (
    .C(buffreq2),
    .D(\trgen1/_old_count_5 [1]),
    .R(\trgen1/_old_count_5 [5]),
    .Q(\trgen1/count [1])
  );
  FDR #(
    .INIT ( 1'b0 ))
  \trgen1/count_0  (
    .C(buffreq2),
    .D(\trgen1/_old_count_5 [0]),
    .R(\trgen1/_old_count_5 [5]),
    .Q(\trgen1/count [0])
  );
  LUT4 #(
    .INIT ( 16'h0001 ))
  \note_in_and0000_wg_lut<0>  (
    .I0(StateCtr[24]),
    .I1(StateCtr[23]),
    .I2(StateCtr[26]),
    .I3(StateCtr[22]),
    .O(note_in_and0000_wg_lut[0])
  );
  MUXCY   \note_in_and0000_wg_cy<0>  (
    .CI(N1),
    .DI(N0),
    .S(note_in_and0000_wg_lut[0]),
    .O(note_in_and0000_wg_cy[0])
  );
  LUT4 #(
    .INIT ( 16'h0001 ))
  \note_in_and0000_wg_lut<1>  (
    .I0(StateCtr[21]),
    .I1(StateCtr[18]),
    .I2(StateCtr[27]),
    .I3(StateCtr[20]),
    .O(note_in_and0000_wg_lut[1])
  );
  MUXCY   \note_in_and0000_wg_cy<1>  (
    .CI(note_in_and0000_wg_cy[0]),
    .DI(N0),
    .S(note_in_and0000_wg_lut[1]),
    .O(note_in_and0000_wg_cy[1])
  );
  LUT4 #(
    .INIT ( 16'h0001 ))
  \note_in_and0000_wg_lut<2>  (
    .I0(StateCtr[19]),
    .I1(StateCtr[17]),
    .I2(StateCtr[25]),
    .I3(StateCtr[16]),
    .O(note_in_and0000_wg_lut[2])
  );
  MUXCY   \note_in_and0000_wg_cy<2>  (
    .CI(note_in_and0000_wg_cy[1]),
    .DI(N0),
    .S(note_in_and0000_wg_lut[2]),
    .O(note_in_and0000_wg_cy[2])
  );
  LUT4 #(
    .INIT ( 16'h0001 ))
  \note_in_and0000_wg_lut<3>  (
    .I0(StateCtr[15]),
    .I1(StateCtr[14]),
    .I2(StateCtr[28]),
    .I3(StateCtr[11]),
    .O(note_in_and0000_wg_lut[3])
  );
  MUXCY   \note_in_and0000_wg_cy<3>  (
    .CI(note_in_and0000_wg_cy[2]),
    .DI(N0),
    .S(note_in_and0000_wg_lut[3]),
    .O(note_in_and0000_wg_cy[3])
  );
  LUT4 #(
    .INIT ( 16'h0001 ))
  \note_in_and0000_wg_lut<4>  (
    .I0(StateCtr[13]),
    .I1(StateCtr[12]),
    .I2(StateCtr[29]),
    .I3(StateCtr[10]),
    .O(note_in_and0000_wg_lut[4])
  );
  MUXCY   \note_in_and0000_wg_cy<4>  (
    .CI(note_in_and0000_wg_cy[3]),
    .DI(N0),
    .S(note_in_and0000_wg_lut[4]),
    .O(note_in_and0000_wg_cy[4])
  );
  LUT4 #(
    .INIT ( 16'h0001 ))
  \note_in_and0000_wg_lut<5>  (
    .I0(StateCtr[9]),
    .I1(StateCtr[8]),
    .I2(StateCtr[30]),
    .I3(StateCtr[7]),
    .O(note_in_and0000_wg_lut[5])
  );
  MUXCY   \note_in_and0000_wg_cy<5>  (
    .CI(note_in_and0000_wg_cy[4]),
    .DI(N0),
    .S(note_in_and0000_wg_lut[5]),
    .O(note_in_and0000_wg_cy[5])
  );
  LUT4 #(
    .INIT ( 16'h0001 ))
  \note_in_and0000_wg_lut<6>  (
    .I0(StateCtr[4]),
    .I1(StateCtr[6]),
    .I2(StateCtr[31]),
    .I3(StateCtr[5]),
    .O(note_in_and0000_wg_lut[6])
  );
  MUXCY   \note_in_and0000_wg_cy<6>  (
    .CI(note_in_and0000_wg_cy[5]),
    .DI(N0),
    .S(note_in_and0000_wg_lut[6]),
    .O(note_in_and0000)
  );
  LUT2 #(
    .INIT ( 4'h1 ))
  \freqgen/Mrom__old_base_freq_2181111  (
    .I0(\porta1/note_out [5]),
    .I1(\porta1/note_out [4]),
    .O(\freqgen/N4_mand_506 )
  );
  LUT4 #(
    .INIT ( 16'h5554 ))
  \freqgen/Mrom__old_base_freq_2171  (
    .I0(\porta1/note_out [3]),
    .I1(\porta1/note_out [2]),
    .I2(\porta1/note_out [1]),
    .I3(\porta1/note_out [0]),
    .O(\freqgen/Mrom__old_base_freq_217 )
  );
  LUT4 #(
    .INIT ( 16'h0046 ))
  \freqgen/Mrom__old_base_freq_216121  (
    .I0(\porta1/note_out [4]),
    .I1(\porta1/note_out [3]),
    .I2(\porta1/note_out [2]),
    .I3(\porta1/note_out [5]),
    .O(\freqgen/N3 )
  );
  LUT4 #(
    .INIT ( 16'hFF15 ))
  \freqgen/Mrom__old_base_freq_213112_SW0  (
    .I0(\porta1/note_out [3]),
    .I1(\porta1/note_out [2]),
    .I2(\porta1/note_out [4]),
    .I3(\porta1/note_out [5]),
    .O(N01)
  );
  LUT4 #(
    .INIT ( 16'hAEBE ))
  \freqgen/Mrom__old_base_freq_213112_SW1  (
    .I0(\porta1/note_out [5]),
    .I1(\porta1/note_out [2]),
    .I2(\porta1/note_out [4]),
    .I3(\porta1/note_out [3]),
    .O(N11)
  );
  LUT4 #(
    .INIT ( 16'h3237 ))
  \freqgen/Mrom__old_base_freq_213112  (
    .I0(\porta1/note_out [0]),
    .I1(N11),
    .I2(\porta1/note_out [1]),
    .I3(N01),
    .O(\freqgen/N2 )
  );
  LUT4 #(
    .INIT ( 16'h3323 ))
  \freqgen/freq_out_cmp_eq000023  (
    .I0(\porta1/note_out [5]),
    .I1(\freqgen/N3 ),
    .I2(\freqgen/Mrom__old_base_freq_217 ),
    .I3(\porta1/note_out [4]),
    .O(\freqgen/freq_out_cmp_eq000023_557 )
  );
  LUT4 #(
    .INIT ( 16'h0001 ))
  \freqgen/freq_out_cmp_eq000047  (
    .I0(\freqgen/N2 ),
    .I1(\freqgen/Mrom__old_base_freq_210_f6_435 ),
    .I2(\freqgen/Mrom__old_base_freq_29_f6_500 ),
    .I3(\freqgen/Mrom__old_base_freq_28_f6_493 ),
    .O(\freqgen/freq_out_cmp_eq000047_558 )
  );
  LUT4 #(
    .INIT ( 16'h0001 ))
  \freqgen/freq_out_cmp_eq000060  (
    .I0(\freqgen/Mrom__old_base_freq_27_f6_486 ),
    .I1(\freqgen/Mrom__old_base_freq_26_f6_479 ),
    .I2(\freqgen/Mrom__old_base_freq_25_f6_473 ),
    .I3(\freqgen/Mrom__old_base_freq_24_f6_466 ),
    .O(\freqgen/freq_out_cmp_eq000060_559 )
  );
  LUT3 #(
    .INIT ( 8'h82 ))
  \mixer/Mmux_ch411  (
    .I0(\trgen2/triangle_out [0]),
    .I1(volsel_0_IBUF_1080),
    .I2(volsel_1_IBUF_1081),
    .O(\mixer/ch4 [0])
  );
  LUT4 #(
    .INIT ( 16'h5C90 ))
  \mixer/Mmux_ch431  (
    .I0(volsel_1_IBUF_1081),
    .I1(volsel_0_IBUF_1080),
    .I2(\trgen2/triangle_out [1]),
    .I3(\trgen2/triangle_out [0]),
    .O(\mixer/ch4 [1])
  );
  LUT2 #(
    .INIT ( 4'h2 ))
  \trgen2/_old_count_5<0>1  (
    .I0(butt_3_IBUF_377),
    .I1(\trgen2/count [0]),
    .O(\trgen2/_old_count_5 [0])
  );
  LUT2 #(
    .INIT ( 4'h2 ))
  \trgen1/_old_count_5<0>1  (
    .I0(butt_3_IBUF_377),
    .I1(\trgen1/count [0]),
    .O(\trgen1/_old_count_5 [0])
  );
  LUT3 #(
    .INIT ( 8'h28 ))
  \trgen2/_old_count_5<1>1  (
    .I0(butt_3_IBUF_377),
    .I1(\trgen2/count [0]),
    .I2(\trgen2/count [1]),
    .O(\trgen2/_old_count_5 [1])
  );
  LUT3 #(
    .INIT ( 8'h28 ))
  \trgen1/_old_count_5<1>1  (
    .I0(butt_3_IBUF_377),
    .I1(\trgen1/count [0]),
    .I2(\trgen1/count [1]),
    .O(\trgen1/_old_count_5 [1])
  );
  LUT4 #(
    .INIT ( 16'h2888 ))
  \trgen2/_old_count_5<2>1  (
    .I0(butt_3_IBUF_377),
    .I1(\trgen2/count [2]),
    .I2(\trgen2/count [0]),
    .I3(\trgen2/count [1]),
    .O(\trgen2/_old_count_5 [2])
  );
  LUT4 #(
    .INIT ( 16'h2888 ))
  \trgen1/_old_count_5<2>1  (
    .I0(butt_3_IBUF_377),
    .I1(\trgen1/count [2]),
    .I2(\trgen1/count [0]),
    .I3(\trgen1/count [1]),
    .O(\trgen1/_old_count_5 [2])
  );
  LUT2 #(
    .INIT ( 4'hB ))
  \sqgen2/Madd_count_add0000_xor<0>11  (
    .I0(\sqgen2/count [4]),
    .I1(\sqgen2/count [0]),
    .O(\sqgen2/count_add0000[0] )
  );
  LUT2 #(
    .INIT ( 4'hB ))
  \sqgen1/Madd_count_add0000_xor<0>11  (
    .I0(\sqgen1/count [4]),
    .I1(\sqgen1/count [0]),
    .O(\sqgen1/count_add0000[0] )
  );
  LUT3 #(
    .INIT ( 8'h80 ))
  \trgen2/_old_count_5<4>_SW0  (
    .I0(\trgen2/count [0]),
    .I1(\trgen2/count [3]),
    .I2(\trgen2/count [2]),
    .O(N13)
  );
  LUT4 #(
    .INIT ( 16'h2888 ))
  \trgen2/_old_count_5<4>  (
    .I0(butt_3_IBUF_377),
    .I1(\trgen2/count [4]),
    .I2(\trgen2/count [1]),
    .I3(N13),
    .O(\trgen2/_old_count_5 [4])
  );
  LUT3 #(
    .INIT ( 8'h80 ))
  \trgen1/_old_count_5<4>_SW0  (
    .I0(\trgen1/count [0]),
    .I1(\trgen1/count [3]),
    .I2(\trgen1/count [2]),
    .O(N15)
  );
  LUT4 #(
    .INIT ( 16'h2888 ))
  \trgen1/_old_count_5<4>  (
    .I0(butt_3_IBUF_377),
    .I1(\trgen1/count [4]),
    .I2(\trgen1/count [1]),
    .I3(N15),
    .O(\trgen1/_old_count_5 [4])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \porta1/note_out_mux0000<0>1  (
    .I0(\porta1/note_out_cmp_ge0000 ),
    .I1(\porta1/note_out_share0000 [0]),
    .I2(note_in[0]),
    .O(\porta1/note_out_mux0000 [0])
  );
  LUT3 #(
    .INIT ( 8'hE8 ))
  \mixer/Madd_old_tempresult_6_addsub0001C31  (
    .I0(\sqgen2/square_out [0]),
    .I1(\trgen1/triangle_out [3]),
    .I2(\sqgen1/square_out [0]),
    .O(\mixer/Madd_old_tempresult_6_addsub0001C3 )
  );
  LUT2 #(
    .INIT ( 4'h7 ))
  \porta1/note_out_not00011  (
    .I0(\porta1/en_flag_983 ),
    .I1(\porta1/note_out_cmp_ge0000 ),
    .O(\porta1/note_out_not0001 )
  );
  LUT2 #(
    .INIT ( 4'h2 ))
  SECCTR_mux00001 (
    .I0(note_in_cmp_ge0000),
    .I1(SECCTR_OBUF_227),
    .O(SECCTR_mux0000)
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \porta1/note_out_mux0000<1>1  (
    .I0(\porta1/note_out_cmp_ge0000 ),
    .I1(\porta1/note_out_share0000 [1]),
    .I2(note_in[1]),
    .O(\porta1/note_out_mux0000 [1])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \porta1/note_out_mux0000<2>1  (
    .I0(\porta1/note_out_cmp_ge0000 ),
    .I1(\porta1/note_out_share0000 [2]),
    .I2(note_in[2]),
    .O(\porta1/note_out_mux0000 [2])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \porta1/note_out_mux0000<3>1  (
    .I0(\porta1/note_out_cmp_ge0000 ),
    .I1(\porta1/note_out_share0000 [3]),
    .I2(note_in[3]),
    .O(\porta1/note_out_mux0000 [3])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \porta1/note_out_mux0000<4>1  (
    .I0(\porta1/note_out_cmp_ge0000 ),
    .I1(\porta1/note_out_share0000 [4]),
    .I2(note_in[4]),
    .O(\porta1/note_out_mux0000 [4])
  );
  LUT4 #(
    .INIT ( 16'h8000 ))
  \trgen2/_old_count_5<5>_SW0  (
    .I0(\trgen2/count [0]),
    .I1(\trgen2/count [4]),
    .I2(\trgen2/count [3]),
    .I3(\trgen2/count [2]),
    .O(N17)
  );
  LUT4 #(
    .INIT ( 16'h2888 ))
  \trgen2/_old_count_5<5>  (
    .I0(butt_3_IBUF_377),
    .I1(\trgen2/count [5]),
    .I2(\trgen2/count [1]),
    .I3(N17),
    .O(\trgen2/_old_count_5 [5])
  );
  LUT4 #(
    .INIT ( 16'h8000 ))
  \trgen1/_old_count_5<5>_SW0  (
    .I0(\trgen1/count [0]),
    .I1(\trgen1/count [4]),
    .I2(\trgen1/count [3]),
    .I3(\trgen1/count [2]),
    .O(N19)
  );
  LUT4 #(
    .INIT ( 16'h2888 ))
  \trgen1/_old_count_5<5>  (
    .I0(butt_3_IBUF_377),
    .I1(\trgen1/count [5]),
    .I2(\trgen1/count [1]),
    .I3(N19),
    .O(\trgen1/_old_count_5 [5])
  );
  LUT3 #(
    .INIT ( 8'hE4 ))
  \porta1/note_out_mux0000<5>1  (
    .I0(\porta1/note_out_cmp_ge0000 ),
    .I1(\porta1/note_out_share0000 [5]),
    .I2(note_in[5]),
    .O(\porta1/note_out_mux0000 [5])
  );
  LUT2 #(
    .INIT ( 4'hE ))
  SecondCtr_or00001 (
    .I0(butt_4_IBUF_379),
    .I1(note_in_cmp_ge0000),
    .O(SecondCtr_or0000)
  );
  LUT4 #(
    .INIT ( 16'hA820 ))
  \mixer/Madd_old_tempresult_6_addsub0001_Madd_cy<6>11  (
    .I0(\mixer/Madd_old_tempresult_6_addsub0001C3 ),
    .I1(\mixer/Madd_old_tempresult_6_addsub0001_Madd_lut [5]),
    .I2(\mixer/Madd_old_tempresult_6_addsub0001C2 ),
    .I3(\mixer/Madd_old_tempresult_6_addsub0001_Madd_cy[4] ),
    .O(\mixer/Madd_old_tempresult_6_addsub0001_Madd_cy[6] )
  );
  LUT4 #(
    .INIT ( 16'h96C6 ))
  \mixer/ch4_addsub0000<3>1  (
    .I0(\trgen2/triangle_out [2]),
    .I1(\trgen2/triangle_out [3]),
    .I2(\trgen2/triangle_out [1]),
    .I3(\trgen2/triangle_out [0]),
    .O(\mixer/ch4_addsub0000 [3])
  );
  LUT4 #(
    .INIT ( 16'h9C14 ))
  \note_in_mux0000<0>_SW0  (
    .I0(StateCtr[0]),
    .I1(StateCtr[2]),
    .I2(StateCtr[1]),
    .I3(note_in[5]),
    .O(N23)
  );
  LUT4 #(
    .INIT ( 16'h8000 ))
  \note_in_mux0000<5>1  (
    .I0(StateCtr[0]),
    .I1(note_in[0]),
    .I2(N3),
    .I3(StateCtr[2]),
    .O(note_in_mux0000[5])
  );
  LUT4 #(
    .INIT ( 16'h8000 ))
  \note_in_mux0000<4>1  (
    .I0(StateCtr[0]),
    .I1(note_in[1]),
    .I2(N51),
    .I3(StateCtr[2]),
    .O(note_in_mux0000[4])
  );
  LUT4 #(
    .INIT ( 16'hA820 ))
  \note_in_mux0000<2>1  (
    .I0(N3),
    .I1(StateCtr[0]),
    .I2(StateCtr[1]),
    .I3(note_in[3]),
    .O(\note_in_mux0000<2>1_716 )
  );
  MUXF5   \note_in_mux0000<2>_f5  (
    .I0(\note_in_mux0000<2>2_717 ),
    .I1(\note_in_mux0000<2>1_716 ),
    .S(StateCtr[2]),
    .O(note_in_mux0000[2])
  );
  LUT4 #(
    .INIT ( 16'h569A ))
  \mixer/Madd_old_tempresult_6_addsub0001_Madd_xor<6>11  (
    .I0(\mixer/Madd_old_tempresult_6_addsub0001C3 ),
    .I1(\mixer/Madd_old_tempresult_6_addsub0001_Madd_lut [5]),
    .I2(\mixer/Madd_old_tempresult_6_addsub0001C2 ),
    .I3(\mixer/Madd_old_tempresult_6_addsub0001_Madd_cy[4] ),
    .O(\mixer/old_tempresult_6_addsub0001 [6])
  );
  LUT3 #(
    .INIT ( 8'hE8 ))
  \mixer/Madd_old_tempresult_6_addsub0001C21  (
    .I0(\sqgen2/square_out [0]),
    .I1(\trgen1/triangle_out [2]),
    .I2(\sqgen1/square_out [0]),
    .O(\mixer/Madd_old_tempresult_6_addsub0001C2 )
  );
  LUT3 #(
    .INIT ( 8'h9A ))
  \mixer/Madd_old_tempresult_6_addsub0001_Madd_xor<4>11  (
    .I0(\mixer/Madd_old_tempresult_6_addsub0001_Madd_lut [4]),
    .I1(\mixer/Madd_old_tempresult_6_addsub0001_Madd_lut [3]),
    .I2(\mixer/Madd_old_tempresult_6_addsub0001C ),
    .O(\mixer/old_tempresult_6_addsub0001 [4])
  );
  LUT4 #(
    .INIT ( 16'h6C64 ))
  \mixer/ch4<4>1  (
    .I0(volsel_0_IBUF_1080),
    .I1(volsel_1_IBUF_1081),
    .I2(\trgen2/triangle_out [3]),
    .I3(\trgen2/triangle_out [1]),
    .O(\mixer/ch4<4>1_685 )
  );
  LUT4 #(
    .INIT ( 16'h20A0 ))
  \mixer/ch4<4>2  (
    .I0(\trgen2/triangle_out [3]),
    .I1(\mixer/ch4<4>_bdd4 ),
    .I2(volsel_0_IBUF_1080),
    .I3(\trgen2/triangle_out [1]),
    .O(\mixer/ch4<4>2_686 )
  );
  MUXF5   \mixer/ch4<4>_f5  (
    .I0(\mixer/ch4<4>2_686 ),
    .I1(\mixer/ch4<4>1_685 ),
    .S(\trgen2/triangle_out [2]),
    .O(\mixer/ch4 [4])
  );
  LUT2 #(
    .INIT ( 4'h8 ))
  Mmux_StateCtr_mux0000271 (
    .I0(StateCtr_addsub0000[27]),
    .I1(N52),
    .O(StateCtr_mux0000[4])
  );
  LUT2 #(
    .INIT ( 4'h8 ))
  Mmux_StateCtr_mux0000261 (
    .I0(StateCtr_addsub0000[28]),
    .I1(N2),
    .O(StateCtr_mux0000[3])
  );
  LUT2 #(
    .INIT ( 4'h8 ))
  Mmux_StateCtr_mux0000231 (
    .I0(StateCtr_addsub0000[29]),
    .I1(N2),
    .O(StateCtr_mux0000[2])
  );
  LUT2 #(
    .INIT ( 4'h8 ))
  Mmux_StateCtr_mux0000121 (
    .I0(StateCtr_addsub0000[30]),
    .I1(N2),
    .O(StateCtr_mux0000[1])
  );
  LUT2 #(
    .INIT ( 4'h8 ))
  Mmux_StateCtr_mux000011 (
    .I0(StateCtr_addsub0000[31]),
    .I1(N2),
    .O(StateCtr_mux0000[0])
  );
  LUT2 #(
    .INIT ( 4'h8 ))
  \mixer/ch4<4>31  (
    .I0(volsel_1_IBUF_1081),
    .I1(\trgen2/triangle_out [0]),
    .O(\mixer/ch4<4>_bdd4 )
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  \mixer/Madd_old_tempresult_6_addsub0001_Madd_xor<5>11  (
    .I0(\mixer/Madd_old_tempresult_6_addsub0001_Madd_lut [5]),
    .I1(\mixer/Madd_old_tempresult_6_addsub0001_Madd_cy[4] ),
    .O(\mixer/old_tempresult_6_addsub0001 [5])
  );
  LUT3 #(
    .INIT ( 8'hE8 ))
  \mixer/Madd_old_tempresult_6_addsub0001C1  (
    .I0(\sqgen2/square_out [0]),
    .I1(\trgen1/triangle_out [0]),
    .I2(\sqgen1/square_out [0]),
    .O(\mixer/Madd_old_tempresult_6_addsub0001C )
  );
  IBUF   butt_3_IBUF (
    .I(butt_3),
    .O(butt_3_IBUF_377)
  );
  IBUF   butt_4_IBUF (
    .I(butt_4),
    .O(butt_4_IBUF_379)
  );
  IBUF   volsel_1_IBUF (
    .I(volsel[1]),
    .O(volsel_1_IBUF_1081)
  );
  IBUF   volsel_0_IBUF (
    .I(volsel[0]),
    .O(volsel_0_IBUF_1080)
  );
  OBUF   SECCTR_OBUF (
    .I(SECCTR_OBUF_227),
    .O(SECCTR)
  );
  OBUF   audio_out_7_OBUF (
    .I(audio_out_7_OBUF_371),
    .O(audio_out[7])
  );
  OBUF   audio_out_6_OBUF (
    .I(audio_out_6_OBUF_370),
    .O(audio_out[6])
  );
  OBUF   audio_out_5_OBUF (
    .I(audio_out_5_OBUF_369),
    .O(audio_out[5])
  );
  OBUF   audio_out_4_OBUF (
    .I(audio_out_4_OBUF_368),
    .O(audio_out[4])
  );
  OBUF   audio_out_3_OBUF (
    .I(audio_out_3_OBUF_367),
    .O(audio_out[3])
  );
  OBUF   audio_out_2_OBUF (
    .I(audio_out_2_OBUF_366),
    .O(audio_out[2])
  );
  OBUF   audio_out_1_OBUF (
    .I(\mixer/ch4 [1]),
    .O(audio_out[1])
  );
  OBUF   audio_out_0_OBUF (
    .I(\mixer/ch4 [0]),
    .O(audio_out[0])
  );
  FDR #(
    .INIT ( 1'b0 ))
  \sqgen2/count_4  (
    .C(buffreq3),
    .D(\sqgen2/Madd_count_add0000_xor<4>11 ),
    .R(\sqgen2/count_add0000[0] ),
    .Q(\sqgen2/count [4])
  );
  LUT3 #(
    .INIT ( 8'h80 ))
  \sqgen2/Madd_count_add0000_xor<4>111  (
    .I0(\sqgen2/count [3]),
    .I1(\sqgen2/count [2]),
    .I2(\sqgen2/count [1]),
    .O(\sqgen2/Madd_count_add0000_xor<4>11 )
  );
  FDR #(
    .INIT ( 1'b0 ))
  \sqgen2/count_2  (
    .C(buffreq3),
    .D(\sqgen2/Madd_count_add0000_xor<2>11 ),
    .R(\sqgen2/count [4]),
    .Q(\sqgen2/count [2])
  );
  LUT3 #(
    .INIT ( 8'h6A ))
  \sqgen2/Madd_count_add0000_xor<2>111  (
    .I0(\sqgen2/count [2]),
    .I1(\sqgen2/count [0]),
    .I2(\sqgen2/count [1]),
    .O(\sqgen2/Madd_count_add0000_xor<2>11 )
  );
  FDR #(
    .INIT ( 1'b0 ))
  \sqgen2/count_1  (
    .C(buffreq3),
    .D(\sqgen2/Madd_count_add0000_xor<1>11 ),
    .R(\sqgen2/count [4]),
    .Q(\sqgen2/count [1])
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  \sqgen2/Madd_count_add0000_xor<1>111  (
    .I0(\sqgen2/count [0]),
    .I1(\sqgen2/count [1]),
    .O(\sqgen2/Madd_count_add0000_xor<1>11 )
  );
  FDR #(
    .INIT ( 1'b0 ))
  \sqgen1/count_4  (
    .C(buffreq1),
    .D(\sqgen1/Madd_count_add0000_xor<4>11 ),
    .R(\sqgen1/count_add0000[0] ),
    .Q(\sqgen1/count [4])
  );
  LUT3 #(
    .INIT ( 8'h80 ))
  \sqgen1/Madd_count_add0000_xor<4>111  (
    .I0(\sqgen1/count [3]),
    .I1(\sqgen1/count [2]),
    .I2(\sqgen1/count [1]),
    .O(\sqgen1/Madd_count_add0000_xor<4>11 )
  );
  FDR #(
    .INIT ( 1'b0 ))
  \sqgen1/count_2  (
    .C(buffreq1),
    .D(\sqgen1/Madd_count_add0000_xor<2>11 ),
    .R(\sqgen1/count [4]),
    .Q(\sqgen1/count [2])
  );
  LUT3 #(
    .INIT ( 8'h6A ))
  \sqgen1/Madd_count_add0000_xor<2>111  (
    .I0(\sqgen1/count [2]),
    .I1(\sqgen1/count [0]),
    .I2(\sqgen1/count [1]),
    .O(\sqgen1/Madd_count_add0000_xor<2>11 )
  );
  FDR #(
    .INIT ( 1'b0 ))
  \sqgen1/count_1  (
    .C(buffreq1),
    .D(\sqgen1/Madd_count_add0000_xor<1>11 ),
    .R(\sqgen1/count [4]),
    .Q(\sqgen1/count [1])
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  \sqgen1/Madd_count_add0000_xor<1>111  (
    .I0(\sqgen1/count [0]),
    .I1(\sqgen1/count [1]),
    .O(\sqgen1/Madd_count_add0000_xor<1>11 )
  );
  FDR #(
    .INIT ( 1'b0 ))
  \trgen2/triangle_out_3  (
    .C(buffreq4),
    .D(\trgen2/triangle_out_mux0000<0>1 ),
    .R(\trgen2/count [5]),
    .Q(\trgen2/triangle_out [3])
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  \trgen2/triangle_out_mux0000<0>11  (
    .I0(\trgen2/count [3]),
    .I1(\trgen2/count [4]),
    .O(\trgen2/triangle_out_mux0000<0>1 )
  );
  FDR #(
    .INIT ( 1'b0 ))
  \trgen2/triangle_out_2  (
    .C(buffreq4),
    .D(\trgen2/triangle_out_mux0000<1>1 ),
    .R(\trgen2/count [5]),
    .Q(\trgen2/triangle_out [2])
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  \trgen2/triangle_out_mux0000<1>11  (
    .I0(\trgen2/count [2]),
    .I1(\trgen2/count [4]),
    .O(\trgen2/triangle_out_mux0000<1>1 )
  );
  FDR #(
    .INIT ( 1'b0 ))
  \trgen2/triangle_out_1  (
    .C(buffreq4),
    .D(\trgen2/triangle_out_mux0000<2>1 ),
    .R(\trgen2/count [5]),
    .Q(\trgen2/triangle_out [1])
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  \trgen2/triangle_out_mux0000<2>11  (
    .I0(\trgen2/count [1]),
    .I1(\trgen2/count [4]),
    .O(\trgen2/triangle_out_mux0000<2>1 )
  );
  FDR #(
    .INIT ( 1'b0 ))
  \trgen2/triangle_out_0  (
    .C(buffreq4),
    .D(\trgen2/triangle_out_mux0000<3>1 ),
    .R(\trgen2/count [5]),
    .Q(\trgen2/triangle_out [0])
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  \trgen2/triangle_out_mux0000<3>11  (
    .I0(\trgen2/count [0]),
    .I1(\trgen2/count [4]),
    .O(\trgen2/triangle_out_mux0000<3>1 )
  );
  FDR #(
    .INIT ( 1'b0 ))
  \trgen1/triangle_out_3  (
    .C(buffreq2),
    .D(\trgen1/triangle_out_mux0000<0>1 ),
    .R(\trgen1/count [5]),
    .Q(\trgen1/triangle_out [3])
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  \trgen1/triangle_out_mux0000<0>11  (
    .I0(\trgen1/count [3]),
    .I1(\trgen1/count [4]),
    .O(\trgen1/triangle_out_mux0000<0>1 )
  );
  FDR #(
    .INIT ( 1'b0 ))
  \trgen1/triangle_out_2  (
    .C(buffreq2),
    .D(\trgen1/triangle_out_mux0000<1>1 ),
    .R(\trgen1/count [5]),
    .Q(\trgen1/triangle_out [2])
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  \trgen1/triangle_out_mux0000<1>11  (
    .I0(\trgen1/count [2]),
    .I1(\trgen1/count [4]),
    .O(\trgen1/triangle_out_mux0000<1>1 )
  );
  FDR #(
    .INIT ( 1'b0 ))
  \trgen1/triangle_out_1  (
    .C(buffreq2),
    .D(\trgen1/triangle_out_mux0000<2>1 ),
    .R(\trgen1/count [5]),
    .Q(\trgen1/triangle_out [1])
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  \trgen1/triangle_out_mux0000<2>11  (
    .I0(\trgen1/count [1]),
    .I1(\trgen1/count [4]),
    .O(\trgen1/triangle_out_mux0000<2>1 )
  );
  FDR #(
    .INIT ( 1'b0 ))
  \trgen1/triangle_out_0  (
    .C(buffreq2),
    .D(\trgen1/triangle_out_mux0000<3>1 ),
    .R(\trgen1/count [5]),
    .Q(\trgen1/triangle_out [0])
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  \trgen1/triangle_out_mux0000<3>11  (
    .I0(\trgen1/count [0]),
    .I1(\trgen1/count [4]),
    .O(\trgen1/triangle_out_mux0000<3>1 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \Madd_StateCtr_addsub0000_cy<1>_rt  (
    .I0(StateCtr[1]),
    .O(\Madd_StateCtr_addsub0000_cy<1>_rt_22 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \Madd_StateCtr_addsub0000_cy<2>_rt  (
    .I0(StateCtr[2]),
    .O(\Madd_StateCtr_addsub0000_cy<2>_rt_44 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \Madd_StateCtr_addsub0000_cy<3>_rt  (
    .I0(StateCtr[3]),
    .O(\Madd_StateCtr_addsub0000_cy<3>_rt_48 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \Madd_StateCtr_addsub0000_cy<4>_rt  (
    .I0(StateCtr[4]),
    .O(\Madd_StateCtr_addsub0000_cy<4>_rt_50 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \Madd_StateCtr_addsub0000_cy<5>_rt  (
    .I0(StateCtr[5]),
    .O(\Madd_StateCtr_addsub0000_cy<5>_rt_52 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \Madd_StateCtr_addsub0000_cy<6>_rt  (
    .I0(StateCtr[6]),
    .O(\Madd_StateCtr_addsub0000_cy<6>_rt_54 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \Madd_StateCtr_addsub0000_cy<7>_rt  (
    .I0(StateCtr[7]),
    .O(\Madd_StateCtr_addsub0000_cy<7>_rt_56 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \Madd_StateCtr_addsub0000_cy<8>_rt  (
    .I0(StateCtr[8]),
    .O(\Madd_StateCtr_addsub0000_cy<8>_rt_58 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \Madd_StateCtr_addsub0000_cy<9>_rt  (
    .I0(StateCtr[9]),
    .O(\Madd_StateCtr_addsub0000_cy<9>_rt_60 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \Madd_StateCtr_addsub0000_cy<10>_rt  (
    .I0(StateCtr[10]),
    .O(\Madd_StateCtr_addsub0000_cy<10>_rt_2 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \Madd_StateCtr_addsub0000_cy<11>_rt  (
    .I0(StateCtr[11]),
    .O(\Madd_StateCtr_addsub0000_cy<11>_rt_4 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \Madd_StateCtr_addsub0000_cy<12>_rt  (
    .I0(StateCtr[12]),
    .O(\Madd_StateCtr_addsub0000_cy<12>_rt_6 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \Madd_StateCtr_addsub0000_cy<13>_rt  (
    .I0(StateCtr[13]),
    .O(\Madd_StateCtr_addsub0000_cy<13>_rt_8 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \Madd_StateCtr_addsub0000_cy<14>_rt  (
    .I0(StateCtr[14]),
    .O(\Madd_StateCtr_addsub0000_cy<14>_rt_10 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \Madd_StateCtr_addsub0000_cy<15>_rt  (
    .I0(StateCtr[15]),
    .O(\Madd_StateCtr_addsub0000_cy<15>_rt_12 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \Madd_StateCtr_addsub0000_cy<16>_rt  (
    .I0(StateCtr[16]),
    .O(\Madd_StateCtr_addsub0000_cy<16>_rt_14 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \Madd_StateCtr_addsub0000_cy<17>_rt  (
    .I0(StateCtr[17]),
    .O(\Madd_StateCtr_addsub0000_cy<17>_rt_16 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \Madd_StateCtr_addsub0000_cy<18>_rt  (
    .I0(StateCtr[18]),
    .O(\Madd_StateCtr_addsub0000_cy<18>_rt_18 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \Madd_StateCtr_addsub0000_cy<19>_rt  (
    .I0(StateCtr[19]),
    .O(\Madd_StateCtr_addsub0000_cy<19>_rt_20 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \Madd_StateCtr_addsub0000_cy<20>_rt  (
    .I0(StateCtr[20]),
    .O(\Madd_StateCtr_addsub0000_cy<20>_rt_24 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \Madd_StateCtr_addsub0000_cy<21>_rt  (
    .I0(StateCtr[21]),
    .O(\Madd_StateCtr_addsub0000_cy<21>_rt_26 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \Madd_StateCtr_addsub0000_cy<22>_rt  (
    .I0(StateCtr[22]),
    .O(\Madd_StateCtr_addsub0000_cy<22>_rt_28 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \Madd_StateCtr_addsub0000_cy<23>_rt  (
    .I0(StateCtr[23]),
    .O(\Madd_StateCtr_addsub0000_cy<23>_rt_30 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \Madd_StateCtr_addsub0000_cy<24>_rt  (
    .I0(StateCtr[24]),
    .O(\Madd_StateCtr_addsub0000_cy<24>_rt_32 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \Madd_StateCtr_addsub0000_cy<25>_rt  (
    .I0(StateCtr[25]),
    .O(\Madd_StateCtr_addsub0000_cy<25>_rt_34 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \Madd_StateCtr_addsub0000_cy<26>_rt  (
    .I0(StateCtr[26]),
    .O(\Madd_StateCtr_addsub0000_cy<26>_rt_36 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \Madd_StateCtr_addsub0000_cy<27>_rt  (
    .I0(StateCtr[27]),
    .O(\Madd_StateCtr_addsub0000_cy<27>_rt_38 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \Madd_StateCtr_addsub0000_cy<28>_rt  (
    .I0(StateCtr[28]),
    .O(\Madd_StateCtr_addsub0000_cy<28>_rt_40 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \Madd_StateCtr_addsub0000_cy<29>_rt  (
    .I0(StateCtr[29]),
    .O(\Madd_StateCtr_addsub0000_cy<29>_rt_42 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \Madd_StateCtr_addsub0000_cy<30>_rt  (
    .I0(StateCtr[30]),
    .O(\Madd_StateCtr_addsub0000_cy<30>_rt_46 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \Mcompar_note_in_cmp_ge0000_cy<0>_rt  (
    .I0(SecondCtr[5]),
    .O(\Mcompar_note_in_cmp_ge0000_cy<0>_rt_84 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \Mcompar_note_in_cmp_ge0000_cy<2>_rt  (
    .I0(SecondCtr[7]),
    .O(\Mcompar_note_in_cmp_ge0000_cy<2>_rt_88 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \Mcompar_StateCtr_cmp_gt0000_cy<1>_rt  (
    .I0(StateCtr[3]),
    .O(\Mcompar_StateCtr_cmp_gt0000_cy<1>_rt_65 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \Mcount_SecondCtr_cy<1>_rt  (
    .I0(SecondCtr[1]),
    .O(\Mcount_SecondCtr_cy<1>_rt_128 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \Mcount_SecondCtr_cy<2>_rt  (
    .I0(SecondCtr[2]),
    .O(\Mcount_SecondCtr_cy<2>_rt_150 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \Mcount_SecondCtr_cy<3>_rt  (
    .I0(SecondCtr[3]),
    .O(\Mcount_SecondCtr_cy<3>_rt_154 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \Mcount_SecondCtr_cy<4>_rt  (
    .I0(SecondCtr[4]),
    .O(\Mcount_SecondCtr_cy<4>_rt_156 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \Mcount_SecondCtr_cy<5>_rt  (
    .I0(SecondCtr[5]),
    .O(\Mcount_SecondCtr_cy<5>_rt_158 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \Mcount_SecondCtr_cy<6>_rt  (
    .I0(SecondCtr[6]),
    .O(\Mcount_SecondCtr_cy<6>_rt_160 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \Mcount_SecondCtr_cy<7>_rt  (
    .I0(SecondCtr[7]),
    .O(\Mcount_SecondCtr_cy<7>_rt_162 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \Mcount_SecondCtr_cy<8>_rt  (
    .I0(SecondCtr[8]),
    .O(\Mcount_SecondCtr_cy<8>_rt_164 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \Mcount_SecondCtr_cy<9>_rt  (
    .I0(SecondCtr[9]),
    .O(\Mcount_SecondCtr_cy<9>_rt_166 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \Mcount_SecondCtr_cy<10>_rt  (
    .I0(SecondCtr[10]),
    .O(\Mcount_SecondCtr_cy<10>_rt_108 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \Mcount_SecondCtr_cy<11>_rt  (
    .I0(SecondCtr[11]),
    .O(\Mcount_SecondCtr_cy<11>_rt_110 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \Mcount_SecondCtr_cy<12>_rt  (
    .I0(SecondCtr[12]),
    .O(\Mcount_SecondCtr_cy<12>_rt_112 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \Mcount_SecondCtr_cy<13>_rt  (
    .I0(SecondCtr[13]),
    .O(\Mcount_SecondCtr_cy<13>_rt_114 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \Mcount_SecondCtr_cy<14>_rt  (
    .I0(SecondCtr[14]),
    .O(\Mcount_SecondCtr_cy<14>_rt_116 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \Mcount_SecondCtr_cy<15>_rt  (
    .I0(SecondCtr[15]),
    .O(\Mcount_SecondCtr_cy<15>_rt_118 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \Mcount_SecondCtr_cy<16>_rt  (
    .I0(SecondCtr[16]),
    .O(\Mcount_SecondCtr_cy<16>_rt_120 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \Mcount_SecondCtr_cy<17>_rt  (
    .I0(SecondCtr[17]),
    .O(\Mcount_SecondCtr_cy<17>_rt_122 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \Mcount_SecondCtr_cy<18>_rt  (
    .I0(SecondCtr[18]),
    .O(\Mcount_SecondCtr_cy<18>_rt_124 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \Mcount_SecondCtr_cy<19>_rt  (
    .I0(SecondCtr[19]),
    .O(\Mcount_SecondCtr_cy<19>_rt_126 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \Mcount_SecondCtr_cy<20>_rt  (
    .I0(SecondCtr[20]),
    .O(\Mcount_SecondCtr_cy<20>_rt_130 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \Mcount_SecondCtr_cy<21>_rt  (
    .I0(SecondCtr[21]),
    .O(\Mcount_SecondCtr_cy<21>_rt_132 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \Mcount_SecondCtr_cy<22>_rt  (
    .I0(SecondCtr[22]),
    .O(\Mcount_SecondCtr_cy<22>_rt_134 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \Mcount_SecondCtr_cy<23>_rt  (
    .I0(SecondCtr[23]),
    .O(\Mcount_SecondCtr_cy<23>_rt_136 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \Mcount_SecondCtr_cy<24>_rt  (
    .I0(SecondCtr[24]),
    .O(\Mcount_SecondCtr_cy<24>_rt_138 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \Mcount_SecondCtr_cy<25>_rt  (
    .I0(SecondCtr[25]),
    .O(\Mcount_SecondCtr_cy<25>_rt_140 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \Mcount_SecondCtr_cy<26>_rt  (
    .I0(SecondCtr[26]),
    .O(\Mcount_SecondCtr_cy<26>_rt_142 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \Mcount_SecondCtr_cy<27>_rt  (
    .I0(SecondCtr[27]),
    .O(\Mcount_SecondCtr_cy<27>_rt_144 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \Mcount_SecondCtr_cy<28>_rt  (
    .I0(SecondCtr[28]),
    .O(\Mcount_SecondCtr_cy<28>_rt_146 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \Mcount_SecondCtr_cy<29>_rt  (
    .I0(SecondCtr[29]),
    .O(\Mcount_SecondCtr_cy<29>_rt_148 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \Mcount_SecondCtr_cy<30>_rt  (
    .I0(SecondCtr[30]),
    .O(\Mcount_SecondCtr_cy<30>_rt_152 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \porta1/Mcompar_count_cmp_ge0000_cy<4>_rt  (
    .I0(\porta1/_old_count_1 [13]),
    .O(\porta1/Mcompar_count_cmp_ge0000_cy<4>_rt_801 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \porta1/Mcompar_count_cmp_ge0000_cy<0>_rt  (
    .I0(\porta1/_old_count_1 [4]),
    .O(\porta1/Mcompar_count_cmp_ge0000_cy<0>_rt_796 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \porta1/Maddsub_note_out_share0000_cy<4>_rt  (
    .I0(\porta1/note_out [4]),
    .O(\porta1/Maddsub_note_out_share0000_cy<4>_rt_793 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \porta1/Maddsub_note_out_share0000_cy<3>_rt  (
    .I0(\porta1/note_out [3]),
    .O(\porta1/Maddsub_note_out_share0000_cy<3>_rt_791 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \porta1/Maddsub_note_out_share0000_cy<2>_rt  (
    .I0(\porta1/note_out [2]),
    .O(\porta1/Maddsub_note_out_share0000_cy<2>_rt_789 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \porta1/Maddsub_note_out_share0000_cy<1>_rt  (
    .I0(\porta1/note_out [1]),
    .O(\porta1/Maddsub_note_out_share0000_cy<1>_rt_787 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \porta1/Maddsub_note_out_share0000_cy<0>_rt  (
    .I0(\porta1/note_out [0]),
    .O(\porta1/Maddsub_note_out_share0000_cy<0>_rt_785 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \porta1/Mcount_count_cy<30>_rt  (
    .I0(\porta1/count [30]),
    .O(\porta1/Mcount_count_cy<30>_rt_873 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \porta1/Mcount_count_cy<29>_rt  (
    .I0(\porta1/count [29]),
    .O(\porta1/Mcount_count_cy<29>_rt_869 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \porta1/Mcount_count_cy<28>_rt  (
    .I0(\porta1/count [28]),
    .O(\porta1/Mcount_count_cy<28>_rt_867 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \porta1/Mcount_count_cy<27>_rt  (
    .I0(\porta1/count [27]),
    .O(\porta1/Mcount_count_cy<27>_rt_865 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \porta1/Mcount_count_cy<26>_rt  (
    .I0(\porta1/count [26]),
    .O(\porta1/Mcount_count_cy<26>_rt_863 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \porta1/Mcount_count_cy<25>_rt  (
    .I0(\porta1/count [25]),
    .O(\porta1/Mcount_count_cy<25>_rt_861 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \porta1/Mcount_count_cy<24>_rt  (
    .I0(\porta1/count [24]),
    .O(\porta1/Mcount_count_cy<24>_rt_859 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \porta1/Mcount_count_cy<23>_rt  (
    .I0(\porta1/count [23]),
    .O(\porta1/Mcount_count_cy<23>_rt_857 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \porta1/Mcount_count_cy<22>_rt  (
    .I0(\porta1/count [22]),
    .O(\porta1/Mcount_count_cy<22>_rt_855 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \porta1/Mcount_count_cy<21>_rt  (
    .I0(\porta1/count [21]),
    .O(\porta1/Mcount_count_cy<21>_rt_853 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \porta1/Mcount_count_cy<20>_rt  (
    .I0(\porta1/count [20]),
    .O(\porta1/Mcount_count_cy<20>_rt_851 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \porta1/Mcount_count_cy<19>_rt  (
    .I0(\porta1/count [19]),
    .O(\porta1/Mcount_count_cy<19>_rt_847 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \porta1/Mcount_count_cy<18>_rt  (
    .I0(\porta1/count [18]),
    .O(\porta1/Mcount_count_cy<18>_rt_845 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \porta1/Mcount_count_cy<17>_rt  (
    .I0(\porta1/count [17]),
    .O(\porta1/Mcount_count_cy<17>_rt_843 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \porta1/Mcount_count_cy<16>_rt  (
    .I0(\porta1/count [16]),
    .O(\porta1/Mcount_count_cy<16>_rt_841 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \porta1/Mcount_count_cy<15>_rt  (
    .I0(\porta1/count [15]),
    .O(\porta1/Mcount_count_cy<15>_rt_839 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \porta1/Mcount_count_cy<14>_rt  (
    .I0(\porta1/count [14]),
    .O(\porta1/Mcount_count_cy<14>_rt_837 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \porta1/Mcount_count_cy<13>_rt  (
    .I0(\porta1/count [13]),
    .O(\porta1/Mcount_count_cy<13>_rt_835 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \porta1/Mcount_count_cy<12>_rt  (
    .I0(\porta1/count [12]),
    .O(\porta1/Mcount_count_cy<12>_rt_833 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \porta1/Mcount_count_cy<11>_rt  (
    .I0(\porta1/count [11]),
    .O(\porta1/Mcount_count_cy<11>_rt_831 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \porta1/Mcount_count_cy<10>_rt  (
    .I0(\porta1/count [10]),
    .O(\porta1/Mcount_count_cy<10>_rt_829 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \porta1/Mcount_count_cy<9>_rt  (
    .I0(\porta1/count [9]),
    .O(\porta1/Mcount_count_cy<9>_rt_887 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \porta1/Mcount_count_cy<8>_rt  (
    .I0(\porta1/count [8]),
    .O(\porta1/Mcount_count_cy<8>_rt_885 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \porta1/Mcount_count_cy<7>_rt  (
    .I0(\porta1/count [7]),
    .O(\porta1/Mcount_count_cy<7>_rt_883 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \porta1/Mcount_count_cy<6>_rt  (
    .I0(\porta1/count [6]),
    .O(\porta1/Mcount_count_cy<6>_rt_881 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \porta1/Mcount_count_cy<5>_rt  (
    .I0(\porta1/count [5]),
    .O(\porta1/Mcount_count_cy<5>_rt_879 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \porta1/Mcount_count_cy<4>_rt  (
    .I0(\porta1/count [4]),
    .O(\porta1/Mcount_count_cy<4>_rt_877 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \porta1/Mcount_count_cy<3>_rt  (
    .I0(\porta1/count [3]),
    .O(\porta1/Mcount_count_cy<3>_rt_875 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \porta1/Mcount_count_cy<2>_rt  (
    .I0(\porta1/count [2]),
    .O(\porta1/Mcount_count_cy<2>_rt_871 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \porta1/Mcount_count_cy<1>_rt  (
    .I0(\porta1/count [1]),
    .O(\porta1/Mcount_count_cy<1>_rt_849 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \porta1/Madd__old_count_1_cy<30>_rt  (
    .I0(\porta1/count [30]),
    .O(\porta1/Madd__old_count_1_cy<30>_rt_767 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \porta1/Madd__old_count_1_cy<29>_rt  (
    .I0(\porta1/count [29]),
    .O(\porta1/Madd__old_count_1_cy<29>_rt_763 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \porta1/Madd__old_count_1_cy<28>_rt  (
    .I0(\porta1/count [28]),
    .O(\porta1/Madd__old_count_1_cy<28>_rt_761 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \porta1/Madd__old_count_1_cy<27>_rt  (
    .I0(\porta1/count [27]),
    .O(\porta1/Madd__old_count_1_cy<27>_rt_759 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \porta1/Madd__old_count_1_cy<26>_rt  (
    .I0(\porta1/count [26]),
    .O(\porta1/Madd__old_count_1_cy<26>_rt_757 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \porta1/Madd__old_count_1_cy<25>_rt  (
    .I0(\porta1/count [25]),
    .O(\porta1/Madd__old_count_1_cy<25>_rt_755 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \porta1/Madd__old_count_1_cy<24>_rt  (
    .I0(\porta1/count [24]),
    .O(\porta1/Madd__old_count_1_cy<24>_rt_753 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \porta1/Madd__old_count_1_cy<23>_rt  (
    .I0(\porta1/count [23]),
    .O(\porta1/Madd__old_count_1_cy<23>_rt_751 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \porta1/Madd__old_count_1_cy<22>_rt  (
    .I0(\porta1/count [22]),
    .O(\porta1/Madd__old_count_1_cy<22>_rt_749 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \porta1/Madd__old_count_1_cy<21>_rt  (
    .I0(\porta1/count [21]),
    .O(\porta1/Madd__old_count_1_cy<21>_rt_747 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \porta1/Madd__old_count_1_cy<20>_rt  (
    .I0(\porta1/count [20]),
    .O(\porta1/Madd__old_count_1_cy<20>_rt_745 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \porta1/Madd__old_count_1_cy<19>_rt  (
    .I0(\porta1/count [19]),
    .O(\porta1/Madd__old_count_1_cy<19>_rt_741 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \porta1/Madd__old_count_1_cy<18>_rt  (
    .I0(\porta1/count [18]),
    .O(\porta1/Madd__old_count_1_cy<18>_rt_739 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \porta1/Madd__old_count_1_cy<17>_rt  (
    .I0(\porta1/count [17]),
    .O(\porta1/Madd__old_count_1_cy<17>_rt_737 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \porta1/Madd__old_count_1_cy<16>_rt  (
    .I0(\porta1/count [16]),
    .O(\porta1/Madd__old_count_1_cy<16>_rt_735 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \porta1/Madd__old_count_1_cy<15>_rt  (
    .I0(\porta1/count [15]),
    .O(\porta1/Madd__old_count_1_cy<15>_rt_733 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \porta1/Madd__old_count_1_cy<14>_rt  (
    .I0(\porta1/count [14]),
    .O(\porta1/Madd__old_count_1_cy<14>_rt_731 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \porta1/Madd__old_count_1_cy<13>_rt  (
    .I0(\porta1/count [13]),
    .O(\porta1/Madd__old_count_1_cy<13>_rt_729 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \porta1/Madd__old_count_1_cy<12>_rt  (
    .I0(\porta1/count [12]),
    .O(\porta1/Madd__old_count_1_cy<12>_rt_727 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \porta1/Madd__old_count_1_cy<11>_rt  (
    .I0(\porta1/count [11]),
    .O(\porta1/Madd__old_count_1_cy<11>_rt_725 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \porta1/Madd__old_count_1_cy<10>_rt  (
    .I0(\porta1/count [10]),
    .O(\porta1/Madd__old_count_1_cy<10>_rt_723 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \porta1/Madd__old_count_1_cy<9>_rt  (
    .I0(\porta1/count [9]),
    .O(\porta1/Madd__old_count_1_cy<9>_rt_781 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \porta1/Madd__old_count_1_cy<8>_rt  (
    .I0(\porta1/count [8]),
    .O(\porta1/Madd__old_count_1_cy<8>_rt_779 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \porta1/Madd__old_count_1_cy<7>_rt  (
    .I0(\porta1/count [7]),
    .O(\porta1/Madd__old_count_1_cy<7>_rt_777 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \porta1/Madd__old_count_1_cy<6>_rt  (
    .I0(\porta1/count [6]),
    .O(\porta1/Madd__old_count_1_cy<6>_rt_775 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \porta1/Madd__old_count_1_cy<5>_rt  (
    .I0(\porta1/count [5]),
    .O(\porta1/Madd__old_count_1_cy<5>_rt_773 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \porta1/Madd__old_count_1_cy<4>_rt  (
    .I0(\porta1/count [4]),
    .O(\porta1/Madd__old_count_1_cy<4>_rt_771 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \porta1/Madd__old_count_1_cy<3>_rt  (
    .I0(\porta1/count [3]),
    .O(\porta1/Madd__old_count_1_cy<3>_rt_769 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \porta1/Madd__old_count_1_cy<2>_rt  (
    .I0(\porta1/count [2]),
    .O(\porta1/Madd__old_count_1_cy<2>_rt_765 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \porta1/Madd__old_count_1_cy<1>_rt  (
    .I0(\porta1/count [1]),
    .O(\porta1/Madd__old_count_1_cy<1>_rt_743 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \Madd_StateCtr_addsub0000_xor<31>_rt  (
    .I0(StateCtr[31]),
    .O(\Madd_StateCtr_addsub0000_xor<31>_rt_62 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \Mcount_SecondCtr_xor<31>_rt  (
    .I0(SecondCtr[31]),
    .O(\Mcount_SecondCtr_xor<31>_rt_168 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \porta1/Maddsub_note_out_share0000_xor<5>_rt  (
    .I0(\porta1/note_out [5]),
    .O(\porta1/Maddsub_note_out_share0000_xor<5>_rt_794 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \porta1/Mcount_count_xor<31>_rt  (
    .I0(\porta1/count [31]),
    .O(\porta1/Mcount_count_xor<31>_rt_889 )
  );
  LUT1 #(
    .INIT ( 2'h2 ))
  \porta1/Madd__old_count_1_xor<31>_rt  (
    .I0(\porta1/count [31]),
    .O(\porta1/Madd__old_count_1_xor<31>_rt_783 )
  );
  LUT4 #(
    .INIT ( 16'hD596 ))
  \freqgen/Mrom__old_base_freq_210_f51  (
    .I0(\porta1/note_out [1]),
    .I1(\porta1/note_out [2]),
    .I2(\porta1/note_out [3]),
    .I3(\porta1/note_out [0]),
    .O(\freqgen/Mrom__old_base_freq_210_f51_434 )
  );
  LUT4 #(
    .INIT ( 16'h7496 ))
  \freqgen/Mrom__old_base_freq_29_f5_01  (
    .I0(\porta1/note_out [0]),
    .I1(\porta1/note_out [2]),
    .I2(\porta1/note_out [3]),
    .I3(\porta1/note_out [1]),
    .O(\freqgen/Mrom__old_base_freq_29_f5_0_499 )
  );
  LUT2 #(
    .INIT ( 4'h8 ))
  \freqgen2/_old_count_3<1>1  (
    .I0(\freqgen2/count [1]),
    .I1(\freqgen2/Mcompar_freq_out_cmp_gt0000_cy [14]),
    .O(\freqgen2/_old_count_3 [1])
  );
  LUT2 #(
    .INIT ( 4'h8 ))
  \freqgen/_old_count_3<1>1  (
    .I0(\freqgen/count [1]),
    .I1(\freqgen/Mcompar_freq_out_cmp_gt0000_cy [14]),
    .O(\freqgen/_old_count_3 [1])
  );
  LUT2 #(
    .INIT ( 4'h8 ))
  \freqgen2/_old_count_3<2>1  (
    .I0(\freqgen2/count [2]),
    .I1(\freqgen2/Mcompar_freq_out_cmp_gt0000_cy [14]),
    .O(\freqgen2/_old_count_3 [2])
  );
  LUT2 #(
    .INIT ( 4'h8 ))
  \freqgen/_old_count_3<2>1  (
    .I0(\freqgen/count [2]),
    .I1(\freqgen/Mcompar_freq_out_cmp_gt0000_cy [14]),
    .O(\freqgen/_old_count_3 [2])
  );
  LUT2 #(
    .INIT ( 4'h8 ))
  \freqgen2/_old_count_3<3>1  (
    .I0(\freqgen2/count [3]),
    .I1(\freqgen2/Mcompar_freq_out_cmp_gt0000_cy [14]),
    .O(\freqgen2/_old_count_3 [3])
  );
  LUT2 #(
    .INIT ( 4'h8 ))
  \freqgen/_old_count_3<3>1  (
    .I0(\freqgen/count [3]),
    .I1(\freqgen/Mcompar_freq_out_cmp_gt0000_cy [14]),
    .O(\freqgen/_old_count_3 [3])
  );
  LUT2 #(
    .INIT ( 4'h8 ))
  \freqgen2/_old_count_3<4>1  (
    .I0(\freqgen2/count [4]),
    .I1(\freqgen2/Mcompar_freq_out_cmp_gt0000_cy [14]),
    .O(\freqgen2/_old_count_3 [4])
  );
  LUT2 #(
    .INIT ( 4'h8 ))
  \freqgen/_old_count_3<4>1  (
    .I0(\freqgen/count [4]),
    .I1(\freqgen/Mcompar_freq_out_cmp_gt0000_cy [14]),
    .O(\freqgen/_old_count_3 [4])
  );
  LUT2 #(
    .INIT ( 4'h8 ))
  \freqgen2/_old_count_3<5>1  (
    .I0(\freqgen2/count [5]),
    .I1(\freqgen2/Mcompar_freq_out_cmp_gt0000_cy [14]),
    .O(\freqgen2/_old_count_3 [5])
  );
  LUT2 #(
    .INIT ( 4'h8 ))
  \freqgen/_old_count_3<5>1  (
    .I0(\freqgen/count [5]),
    .I1(\freqgen/Mcompar_freq_out_cmp_gt0000_cy [14]),
    .O(\freqgen/_old_count_3 [5])
  );
  LUT2 #(
    .INIT ( 4'h8 ))
  \freqgen2/_old_count_3<6>1  (
    .I0(\freqgen2/count [6]),
    .I1(\freqgen2/Mcompar_freq_out_cmp_gt0000_cy [14]),
    .O(\freqgen2/_old_count_3 [6])
  );
  LUT2 #(
    .INIT ( 4'h8 ))
  \freqgen/_old_count_3<6>1  (
    .I0(\freqgen/count [6]),
    .I1(\freqgen/Mcompar_freq_out_cmp_gt0000_cy [14]),
    .O(\freqgen/_old_count_3 [6])
  );
  LUT2 #(
    .INIT ( 4'h8 ))
  \freqgen2/_old_count_3<7>1  (
    .I0(\freqgen2/count [7]),
    .I1(\freqgen2/Mcompar_freq_out_cmp_gt0000_cy [14]),
    .O(\freqgen2/_old_count_3 [7])
  );
  LUT2 #(
    .INIT ( 4'h8 ))
  \freqgen/_old_count_3<7>1  (
    .I0(\freqgen/count [7]),
    .I1(\freqgen/Mcompar_freq_out_cmp_gt0000_cy [14]),
    .O(\freqgen/_old_count_3 [7])
  );
  LUT2 #(
    .INIT ( 4'h8 ))
  \freqgen2/_old_count_3<8>1  (
    .I0(\freqgen2/count [8]),
    .I1(\freqgen2/Mcompar_freq_out_cmp_gt0000_cy [14]),
    .O(\freqgen2/_old_count_3 [8])
  );
  LUT2 #(
    .INIT ( 4'h8 ))
  \freqgen/_old_count_3<8>1  (
    .I0(\freqgen/count [8]),
    .I1(\freqgen/Mcompar_freq_out_cmp_gt0000_cy [14]),
    .O(\freqgen/_old_count_3 [8])
  );
  LUT2 #(
    .INIT ( 4'h8 ))
  \freqgen2/_old_count_3<9>1  (
    .I0(\freqgen2/count [9]),
    .I1(\freqgen2/Mcompar_freq_out_cmp_gt0000_cy [14]),
    .O(\freqgen2/_old_count_3 [9])
  );
  LUT2 #(
    .INIT ( 4'h8 ))
  \freqgen/_old_count_3<9>1  (
    .I0(\freqgen/count [9]),
    .I1(\freqgen/Mcompar_freq_out_cmp_gt0000_cy [14]),
    .O(\freqgen/_old_count_3 [9])
  );
  LUT2 #(
    .INIT ( 4'h8 ))
  \freqgen2/_old_count_3<10>1  (
    .I0(\freqgen2/count [10]),
    .I1(\freqgen2/Mcompar_freq_out_cmp_gt0000_cy [14]),
    .O(\freqgen2/_old_count_3 [10])
  );
  LUT2 #(
    .INIT ( 4'h8 ))
  \freqgen/_old_count_3<10>1  (
    .I0(\freqgen/count [10]),
    .I1(\freqgen/Mcompar_freq_out_cmp_gt0000_cy [14]),
    .O(\freqgen/_old_count_3 [10])
  );
  LUT2 #(
    .INIT ( 4'h8 ))
  \freqgen2/_old_count_3<11>1  (
    .I0(\freqgen2/count [11]),
    .I1(\freqgen2/Mcompar_freq_out_cmp_gt0000_cy [14]),
    .O(\freqgen2/_old_count_3 [11])
  );
  LUT2 #(
    .INIT ( 4'h8 ))
  \freqgen/_old_count_3<11>1  (
    .I0(\freqgen/count [11]),
    .I1(\freqgen/Mcompar_freq_out_cmp_gt0000_cy [14]),
    .O(\freqgen/_old_count_3 [11])
  );
  LUT2 #(
    .INIT ( 4'h8 ))
  \freqgen2/_old_count_3<12>1  (
    .I0(\freqgen2/count [12]),
    .I1(\freqgen2/Mcompar_freq_out_cmp_gt0000_cy [14]),
    .O(\freqgen2/_old_count_3 [12])
  );
  LUT2 #(
    .INIT ( 4'h8 ))
  \freqgen/_old_count_3<12>1  (
    .I0(\freqgen/count [12]),
    .I1(\freqgen/Mcompar_freq_out_cmp_gt0000_cy [14]),
    .O(\freqgen/_old_count_3 [12])
  );
  LUT2 #(
    .INIT ( 4'h7 ))
  \freqgen2/Madd_count_add0000_lut<0>  (
    .I0(\freqgen2/count [0]),
    .I1(\freqgen2/Mcompar_freq_out_cmp_gt0000_cy [14]),
    .O(\freqgen2/Madd_count_add0000_lut [0])
  );
  LUT2 #(
    .INIT ( 4'h7 ))
  \freqgen/Madd_count_add0000_lut<0>  (
    .I0(\freqgen/count [0]),
    .I1(\freqgen/Mcompar_freq_out_cmp_gt0000_cy [14]),
    .O(\freqgen/Madd_count_add0000_lut [0])
  );
  LUT2 #(
    .INIT ( 4'h8 ))
  \freqgen2/_old_count_3<13>1  (
    .I0(\freqgen2/count [13]),
    .I1(\freqgen2/Mcompar_freq_out_cmp_gt0000_cy [14]),
    .O(\freqgen2/_old_count_3 [13])
  );
  LUT2 #(
    .INIT ( 4'h8 ))
  \freqgen/_old_count_3<13>1  (
    .I0(\freqgen/count [13]),
    .I1(\freqgen/Mcompar_freq_out_cmp_gt0000_cy [14]),
    .O(\freqgen/_old_count_3 [13])
  );
  LUT2 #(
    .INIT ( 4'h8 ))
  \freqgen2/_old_count_3<14>1  (
    .I0(\freqgen2/count [14]),
    .I1(\freqgen2/Mcompar_freq_out_cmp_gt0000_cy [14]),
    .O(\freqgen2/_old_count_3 [14])
  );
  LUT2 #(
    .INIT ( 4'h8 ))
  \freqgen/_old_count_3<14>1  (
    .I0(\freqgen/count [14]),
    .I1(\freqgen/Mcompar_freq_out_cmp_gt0000_cy [14]),
    .O(\freqgen/_old_count_3 [14])
  );
  LUT2 #(
    .INIT ( 4'h8 ))
  \freqgen2/_old_count_3<15>1  (
    .I0(\freqgen2/count [15]),
    .I1(\freqgen2/Mcompar_freq_out_cmp_gt0000_cy [14]),
    .O(\freqgen2/_old_count_3 [15])
  );
  LUT2 #(
    .INIT ( 4'h8 ))
  \freqgen/_old_count_3<15>1  (
    .I0(\freqgen/count [15]),
    .I1(\freqgen/Mcompar_freq_out_cmp_gt0000_cy [14]),
    .O(\freqgen/_old_count_3 [15])
  );
  LUT4 #(
    .INIT ( 16'h9ACA ))
  \mixer/Mmux_ch4_3  (
    .I0(\trgen2/triangle_out [0]),
    .I1(\trgen2/triangle_out [2]),
    .I2(volsel_0_IBUF_1080),
    .I3(\trgen2/triangle_out [1]),
    .O(\mixer/Mmux_ch4_3_676 )
  );
  LUT4 #(
    .INIT ( 16'h6996 ))
  \mixer/Madd__old_tempresult_6_lut<2>  (
    .I0(\sqgen2/square_out [0]),
    .I1(\sqgen1/square_out [0]),
    .I2(\trgen1/triangle_out [0]),
    .I3(\mixer/ch4 [2]),
    .O(\mixer/Madd__old_tempresult_6_lut [2])
  );
  LUT4 #(
    .INIT ( 16'hBFFF ))
  \freqgen/freq_out_cmp_eq000073_SW0  (
    .I0(\freqgen/Mrom__old_base_freq_2_f6_503 ),
    .I1(\freqgen/freq_out_cmp_eq000023_557 ),
    .I2(\freqgen/freq_out_cmp_eq000047_558 ),
    .I3(\freqgen/freq_out_cmp_eq000060_559 ),
    .O(N35)
  );
  LUT4 #(
    .INIT ( 16'h0001 ))
  \freqgen/freq_out_cmp_eq000073  (
    .I0(\freqgen/Mrom__old_base_freq_21_f6_443 ),
    .I1(\freqgen/Mrom__old_base_freq_22_f6_451 ),
    .I2(\freqgen/Mrom__old_base_freq_23_f6_459 ),
    .I3(N35),
    .O(\freqgen/freq_out_cmp_eq0000 )
  );
  LUT4 #(
    .INIT ( 16'h084C ))
  \note_in_mux0000<2>2  (
    .I0(StateCtr[0]),
    .I1(note_in_and0000),
    .I2(StateCtr[3]),
    .I3(StateCtr[1]),
    .O(\note_in_mux0000<2>2_717 )
  );
  LUT3 #(
    .INIT ( 8'h80 ))
  Mmux_StateCtr_mux0000251 (
    .I0(StateCtr_addsub0000[0]),
    .I1(note_in_cmp_ge0000),
    .I2(Mcompar_StateCtr_cmp_gt0000_cy[9]),
    .O(StateCtr_mux0000[31])
  );
  LUT3 #(
    .INIT ( 8'h80 ))
  Mmux_StateCtr_mux0000241 (
    .I0(StateCtr_addsub0000[1]),
    .I1(note_in_cmp_ge0000),
    .I2(Mcompar_StateCtr_cmp_gt0000_cy[9]),
    .O(StateCtr_mux0000[30])
  );
  LUT3 #(
    .INIT ( 8'h80 ))
  Mmux_StateCtr_mux0000221 (
    .I0(StateCtr_addsub0000[2]),
    .I1(note_in_cmp_ge0000),
    .I2(Mcompar_StateCtr_cmp_gt0000_cy[9]),
    .O(StateCtr_mux0000[29])
  );
  LUT3 #(
    .INIT ( 8'h80 ))
  Mmux_StateCtr_mux0000211 (
    .I0(StateCtr_addsub0000[3]),
    .I1(note_in_cmp_ge0000),
    .I2(Mcompar_StateCtr_cmp_gt0000_cy[9]),
    .O(StateCtr_mux0000[28])
  );
  LUT3 #(
    .INIT ( 8'h80 ))
  Mmux_StateCtr_mux0000201 (
    .I0(StateCtr_addsub0000[4]),
    .I1(note_in_cmp_ge0000),
    .I2(Mcompar_StateCtr_cmp_gt0000_cy[9]),
    .O(StateCtr_mux0000[27])
  );
  LUT3 #(
    .INIT ( 8'h80 ))
  Mmux_StateCtr_mux0000191 (
    .I0(StateCtr_addsub0000[5]),
    .I1(note_in_cmp_ge0000),
    .I2(Mcompar_StateCtr_cmp_gt0000_cy[9]),
    .O(StateCtr_mux0000[26])
  );
  LUT3 #(
    .INIT ( 8'h80 ))
  Mmux_StateCtr_mux0000181 (
    .I0(StateCtr_addsub0000[6]),
    .I1(note_in_cmp_ge0000),
    .I2(Mcompar_StateCtr_cmp_gt0000_cy[9]),
    .O(StateCtr_mux0000[25])
  );
  LUT3 #(
    .INIT ( 8'h08 ))
  \note_in_mux0000<0>  (
    .I0(N23),
    .I1(note_in_and0000),
    .I2(StateCtr[3]),
    .O(note_in_mux0000[0])
  );
  LUT3 #(
    .INIT ( 8'h80 ))
  Mmux_StateCtr_mux0000171 (
    .I0(StateCtr_addsub0000[7]),
    .I1(note_in_cmp_ge0000),
    .I2(Mcompar_StateCtr_cmp_gt0000_cy[9]),
    .O(StateCtr_mux0000[24])
  );
  LUT3 #(
    .INIT ( 8'h80 ))
  Mmux_StateCtr_mux0000161 (
    .I0(StateCtr_addsub0000[8]),
    .I1(note_in_cmp_ge0000),
    .I2(Mcompar_StateCtr_cmp_gt0000_cy[9]),
    .O(StateCtr_mux0000[23])
  );
  LUT4 #(
    .INIT ( 16'hDA8A ))
  \note_in_mux0000<1>_SW1  (
    .I0(StateCtr[0]),
    .I1(note_in[4]),
    .I2(StateCtr[2]),
    .I3(StateCtr[1]),
    .O(N37)
  );
  LUT3 #(
    .INIT ( 8'h08 ))
  \note_in_mux0000<1>  (
    .I0(N37),
    .I1(note_in_and0000),
    .I2(StateCtr[3]),
    .O(note_in_mux0000[1])
  );
  LUT3 #(
    .INIT ( 8'hA2 ))
  porta_en_mux0000_SW0 (
    .I0(StateCtr[1]),
    .I1(porta_en_1008),
    .I2(StateCtr[3]),
    .O(N39)
  );
  LUT4 #(
    .INIT ( 16'h084C ))
  porta_en_mux0000 (
    .I0(StateCtr[2]),
    .I1(note_in_and0000),
    .I2(StateCtr[3]),
    .I3(N39),
    .O(porta_en_mux0000_1009)
  );
  LUT3 #(
    .INIT ( 8'h80 ))
  Mmux_StateCtr_mux0000151 (
    .I0(StateCtr_addsub0000[9]),
    .I1(note_in_cmp_ge0000),
    .I2(Mcompar_StateCtr_cmp_gt0000_cy[9]),
    .O(StateCtr_mux0000[22])
  );
  LUT3 #(
    .INIT ( 8'h80 ))
  Mmux_StateCtr_mux0000141 (
    .I0(StateCtr_addsub0000[10]),
    .I1(note_in_cmp_ge0000),
    .I2(Mcompar_StateCtr_cmp_gt0000_cy[9]),
    .O(StateCtr_mux0000[21])
  );
  LUT3 #(
    .INIT ( 8'h80 ))
  Mmux_StateCtr_mux0000131 (
    .I0(StateCtr_addsub0000[11]),
    .I1(note_in_cmp_ge0000),
    .I2(Mcompar_StateCtr_cmp_gt0000_cy[9]),
    .O(StateCtr_mux0000[20])
  );
  LUT3 #(
    .INIT ( 8'h80 ))
  Mmux_StateCtr_mux0000111 (
    .I0(StateCtr_addsub0000[12]),
    .I1(note_in_cmp_ge0000),
    .I2(Mcompar_StateCtr_cmp_gt0000_cy[9]),
    .O(StateCtr_mux0000[19])
  );
  LUT3 #(
    .INIT ( 8'h80 ))
  Mmux_StateCtr_mux0000101 (
    .I0(StateCtr_addsub0000[13]),
    .I1(note_in_cmp_ge0000),
    .I2(Mcompar_StateCtr_cmp_gt0000_cy[9]),
    .O(StateCtr_mux0000[18])
  );
  LUT3 #(
    .INIT ( 8'h80 ))
  Mmux_StateCtr_mux000091 (
    .I0(StateCtr_addsub0000[14]),
    .I1(note_in_cmp_ge0000),
    .I2(Mcompar_StateCtr_cmp_gt0000_cy[9]),
    .O(StateCtr_mux0000[17])
  );
  LUT3 #(
    .INIT ( 8'h80 ))
  Mmux_StateCtr_mux000081 (
    .I0(StateCtr_addsub0000[15]),
    .I1(note_in_cmp_ge0000),
    .I2(Mcompar_StateCtr_cmp_gt0000_cy[9]),
    .O(StateCtr_mux0000[16])
  );
  LUT3 #(
    .INIT ( 8'h80 ))
  Mmux_StateCtr_mux000071 (
    .I0(StateCtr_addsub0000[16]),
    .I1(note_in_cmp_ge0000),
    .I2(Mcompar_StateCtr_cmp_gt0000_cy[9]),
    .O(StateCtr_mux0000[15])
  );
  LUT3 #(
    .INIT ( 8'h80 ))
  Mmux_StateCtr_mux000061 (
    .I0(StateCtr_addsub0000[17]),
    .I1(note_in_cmp_ge0000),
    .I2(Mcompar_StateCtr_cmp_gt0000_cy[9]),
    .O(StateCtr_mux0000[14])
  );
  LUT3 #(
    .INIT ( 8'h80 ))
  Mmux_StateCtr_mux000051 (
    .I0(StateCtr_addsub0000[18]),
    .I1(note_in_cmp_ge0000),
    .I2(Mcompar_StateCtr_cmp_gt0000_cy[9]),
    .O(StateCtr_mux0000[13])
  );
  LUT3 #(
    .INIT ( 8'h80 ))
  Mmux_StateCtr_mux000041 (
    .I0(StateCtr_addsub0000[19]),
    .I1(note_in_cmp_ge0000),
    .I2(Mcompar_StateCtr_cmp_gt0000_cy[9]),
    .O(StateCtr_mux0000[12])
  );
  LUT3 #(
    .INIT ( 8'h80 ))
  Mmux_StateCtr_mux000031 (
    .I0(StateCtr_addsub0000[20]),
    .I1(note_in_cmp_ge0000),
    .I2(Mcompar_StateCtr_cmp_gt0000_cy[9]),
    .O(StateCtr_mux0000[11])
  );
  LUT3 #(
    .INIT ( 8'h80 ))
  Mmux_StateCtr_mux000021 (
    .I0(StateCtr_addsub0000[21]),
    .I1(note_in_cmp_ge0000),
    .I2(Mcompar_StateCtr_cmp_gt0000_cy[9]),
    .O(StateCtr_mux0000[10])
  );
  LUT3 #(
    .INIT ( 8'h80 ))
  Mmux_StateCtr_mux0000321 (
    .I0(StateCtr_addsub0000[22]),
    .I1(note_in_cmp_ge0000),
    .I2(Mcompar_StateCtr_cmp_gt0000_cy[9]),
    .O(StateCtr_mux0000[9])
  );
  LUT3 #(
    .INIT ( 8'h80 ))
  Mmux_StateCtr_mux0000311 (
    .I0(StateCtr_addsub0000[23]),
    .I1(note_in_cmp_ge0000),
    .I2(Mcompar_StateCtr_cmp_gt0000_cy[9]),
    .O(StateCtr_mux0000[8])
  );
  LUT3 #(
    .INIT ( 8'h80 ))
  Mmux_StateCtr_mux0000281 (
    .I0(StateCtr_addsub0000[26]),
    .I1(note_in_cmp_ge0000),
    .I2(Mcompar_StateCtr_cmp_gt0000_cy[9]),
    .O(StateCtr_mux0000[5])
  );
  LUT3 #(
    .INIT ( 8'h80 ))
  Mmux_StateCtr_mux0000291 (
    .I0(StateCtr_addsub0000[25]),
    .I1(note_in_cmp_ge0000),
    .I2(Mcompar_StateCtr_cmp_gt0000_cy[9]),
    .O(StateCtr_mux0000[6])
  );
  LUT3 #(
    .INIT ( 8'h80 ))
  Mmux_StateCtr_mux0000301 (
    .I0(StateCtr_addsub0000[24]),
    .I1(note_in_cmp_ge0000),
    .I2(Mcompar_StateCtr_cmp_gt0000_cy[9]),
    .O(StateCtr_mux0000[7])
  );
  LUT4 #(
    .INIT ( 16'h6A56 ))
  \mixer/Madd_old_tempresult_6_addsub0001_Madd_lut<5>1  (
    .I0(\trgen1/triangle_out [3]),
    .I1(\sqgen2/square_out [0]),
    .I2(\sqgen1/square_out [0]),
    .I3(\trgen1/triangle_out [2]),
    .O(\mixer/Madd_old_tempresult_6_addsub0001_Madd_lut [5])
  );
  LUT4 #(
    .INIT ( 16'h6A56 ))
  \mixer/Madd_old_tempresult_6_addsub0001_Madd_lut<4>1  (
    .I0(\trgen1/triangle_out [2]),
    .I1(\sqgen2/square_out [0]),
    .I2(\sqgen1/square_out [0]),
    .I3(\trgen1/triangle_out [1]),
    .O(\mixer/Madd_old_tempresult_6_addsub0001_Madd_lut [4])
  );
  LUT4 #(
    .INIT ( 16'h6A56 ))
  \mixer/Madd_old_tempresult_6_addsub0001_Madd_lut<3>1  (
    .I0(\trgen1/triangle_out [1]),
    .I1(\sqgen2/square_out [0]),
    .I2(\sqgen1/square_out [0]),
    .I3(\trgen1/triangle_out [0]),
    .O(\mixer/Madd_old_tempresult_6_addsub0001_Madd_lut [3])
  );
  LUT4 #(
    .INIT ( 16'h5A96 ))
  \mixer/Madd__old_tempresult_6_lut<4>  (
    .I0(\mixer/Madd_old_tempresult_6_addsub0001_Madd_lut [4]),
    .I1(\mixer/Madd_old_tempresult_6_addsub0001C ),
    .I2(\mixer/ch4 [4]),
    .I3(\mixer/Madd_old_tempresult_6_addsub0001_Madd_lut [3]),
    .O(\mixer/Madd__old_tempresult_6_lut [4])
  );
  LUT4 #(
    .INIT ( 16'h9666 ))
  \mixer/Madd__old_tempresult_6_lut<5>  (
    .I0(\mixer/Madd_old_tempresult_6_addsub0001_Madd_cy[4] ),
    .I1(\mixer/Madd_old_tempresult_6_addsub0001_Madd_lut [5]),
    .I2(\trgen2/triangle_out [3]),
    .I3(N41),
    .O(\mixer/Madd__old_tempresult_6_lut [5])
  );
  MUXF5   \sqgen2/Madd_count_add0000_xor<3>1  (
    .I0(N43),
    .I1(N44),
    .S(\sqgen2/count [3]),
    .O(\sqgen2/count_add0000[3] )
  );
  LUT3 #(
    .INIT ( 8'h08 ))
  \sqgen2/Madd_count_add0000_xor<3>1_F  (
    .I0(\sqgen2/count [1]),
    .I1(\sqgen2/count [2]),
    .I2(\sqgen2/count_add0000[0] ),
    .O(N43)
  );
  LUT4 #(
    .INIT ( 16'h1333 ))
  \sqgen2/Madd_count_add0000_xor<3>1_G  (
    .I0(\sqgen2/count [1]),
    .I1(\sqgen2/count [4]),
    .I2(\sqgen2/count [0]),
    .I3(\sqgen2/count [2]),
    .O(N44)
  );
  MUXF5   \sqgen1/Madd_count_add0000_xor<3>1  (
    .I0(N45),
    .I1(N46),
    .S(\sqgen1/count [3]),
    .O(\sqgen1/count_add0000[3] )
  );
  LUT3 #(
    .INIT ( 8'h08 ))
  \sqgen1/Madd_count_add0000_xor<3>1_F  (
    .I0(\sqgen1/count [1]),
    .I1(\sqgen1/count [2]),
    .I2(\sqgen1/count_add0000[0] ),
    .O(N45)
  );
  LUT4 #(
    .INIT ( 16'h1333 ))
  \sqgen1/Madd_count_add0000_xor<3>1_G  (
    .I0(\sqgen1/count [1]),
    .I1(\sqgen1/count [4]),
    .I2(\sqgen1/count [0]),
    .I3(\sqgen1/count [2]),
    .O(N46)
  );
  MUXF5   \mixer/Madd_old_tempresult_6_addsub0001_Madd_cy<4>11  (
    .I0(N47),
    .I1(N48),
    .S(\sqgen1/square_out [0]),
    .O(\mixer/Madd_old_tempresult_6_addsub0001_Madd_cy[4] )
  );
  LUT4 #(
    .INIT ( 16'h2220 ))
  \mixer/Madd_old_tempresult_6_addsub0001_Madd_cy<4>11_F  (
    .I0(\sqgen2/square_out [0]),
    .I1(\trgen1/triangle_out [2]),
    .I2(\trgen1/triangle_out [1]),
    .I3(\trgen1/triangle_out [0]),
    .O(N47)
  );
  LUT4 #(
    .INIT ( 16'hBB98 ))
  \mixer/Madd_old_tempresult_6_addsub0001_Madd_cy<4>11_G  (
    .I0(\sqgen2/square_out [0]),
    .I1(\trgen1/triangle_out [2]),
    .I2(\trgen1/triangle_out [0]),
    .I3(\trgen1/triangle_out [1]),
    .O(N48)
  );
  MUXF5   \note_in_mux0000<3>  (
    .I0(N49),
    .I1(N50),
    .S(StateCtr[0]),
    .O(note_in_mux0000[3])
  );
  LUT4 #(
    .INIT ( 16'h022A ))
  \note_in_mux0000<3>_F  (
    .I0(note_in_and0000),
    .I1(StateCtr[3]),
    .I2(StateCtr[2]),
    .I3(StateCtr[1]),
    .O(N49)
  );
  LUT4 #(
    .INIT ( 16'h2000 ))
  \note_in_mux0000<3>_G  (
    .I0(note_in_and0000),
    .I1(StateCtr[3]),
    .I2(StateCtr[2]),
    .I3(note_in[2]),
    .O(N50)
  );
  BUFGP   clk_BUFGP (
    .I(clk),
    .O(clk_BUFGP_381)
  );
  INV   \Madd_StateCtr_addsub0000_lut<0>_INV_0  (
    .I(StateCtr[0]),
    .O(Madd_StateCtr_addsub0000_lut[0])
  );
  INV   \Mcompar_note_in_cmp_ge0000_lut<1>_INV_0  (
    .I(SecondCtr[6]),
    .O(\Mcompar_note_in_cmp_ge0000_lut[1] )
  );
  INV   \Mcompar_note_in_cmp_ge0000_lut<3>_INV_0  (
    .I(SecondCtr[8]),
    .O(\Mcompar_note_in_cmp_ge0000_lut[3] )
  );
  INV   \Mcount_SecondCtr_lut<0>_INV_0  (
    .I(SecondCtr[0]),
    .O(Mcount_SecondCtr_lut[0])
  );
  INV   \porta1/Mcount_count_lut<0>_INV_0  (
    .I(\porta1/count [0]),
    .O(\porta1/Mcount_count_lut [0])
  );
  INV   \porta1/Madd__old_count_1_lut<0>_INV_0  (
    .I(\porta1/count [0]),
    .O(\porta1/Madd__old_count_1_lut [0])
  );
  INV   \freqgen2/Mcompar_freq_out_cmp_gt0000_cy<14>_inv_INV_0  (
    .I(\freqgen2/Mcompar_freq_out_cmp_gt0000_cy [14]),
    .O(\freqgen2/freq_out_cmp_gt0000 )
  );
  INV   \freqgen/Mcompar_freq_out_cmp_gt0000_cy<14>_inv_INV_0  (
    .I(\freqgen/Mcompar_freq_out_cmp_gt0000_cy [14]),
    .O(\freqgen/freq_out_cmp_gt0000 )
  );
  INV   \freqgen/Mrom__old_base_freq_29_INV_0  (
    .I(\porta1/note_out [3]),
    .O(\freqgen/Mrom__old_base_freq_29 )
  );
  INV   \porta1/en_inv1_INV_0  (
    .I(porta_en_1008),
    .O(\porta1/en_inv )
  );
  INV   \sqgen2/square_out_cmp_eq00001_INV_0  (
    .I(\sqgen2/square_out [0]),
    .O(\sqgen2/square_out_cmp_eq0000 )
  );
  INV   \sqgen1/square_out_cmp_eq00001_INV_0  (
    .I(\sqgen1/square_out [0]),
    .O(\sqgen1/square_out_cmp_eq0000 )
  );
  INV   \porta1/note_clk_not00011_INV_0  (
    .I(\porta1/note_clk_986 ),
    .O(\porta1/note_clk_not0001 )
  );
  INV   \freqgen2/freq_out_not00011_INV_0  (
    .I(\freqgen2/freq_out_655 ),
    .O(\freqgen2/freq_out_not0001 )
  );
  INV   \freqgen/freq_out_not00011_INV_0  (
    .I(\freqgen/freq_out_555 ),
    .O(\freqgen/freq_out_not0001 )
  );
  INV   \porta1/en_flag_inv1_INV_0  (
    .I(\porta1/en_flag_983 ),
    .O(\porta1/en_flag_inv )
  );
  INV   \freqgen2/Mcompar_freq_out_cmp_gt0000_lut<0>1_INV_0  (
    .I(\freqgen2/count [0]),
    .O(\freqgen2/Mcompar_freq_out_cmp_gt0000_lut [0])
  );
  INV   \freqgen2/Mcompar_freq_out_cmp_gt0000_lut<10>1_INV_0  (
    .I(\freqgen2/count [10]),
    .O(\freqgen2/Mcompar_freq_out_cmp_gt0000_lut [10])
  );
  INV   \freqgen2/Mcompar_freq_out_cmp_gt0000_lut<11>1_INV_0  (
    .I(\freqgen2/count [11]),
    .O(\freqgen2/Mcompar_freq_out_cmp_gt0000_lut [11])
  );
  INV   \freqgen2/Mcompar_freq_out_cmp_gt0000_lut<12>1_INV_0  (
    .I(\freqgen2/count [12]),
    .O(\freqgen2/Mcompar_freq_out_cmp_gt0000_lut [12])
  );
  INV   \freqgen2/Mcompar_freq_out_cmp_gt0000_lut<13>1_INV_0  (
    .I(\freqgen2/count [13]),
    .O(\freqgen2/Mcompar_freq_out_cmp_gt0000_lut [13])
  );
  INV   \freqgen2/Mcompar_freq_out_cmp_gt0000_lut<1>1_INV_0  (
    .I(\freqgen2/count [1]),
    .O(\freqgen2/Mcompar_freq_out_cmp_gt0000_lut [1])
  );
  INV   \freqgen2/Mcompar_freq_out_cmp_gt0000_lut<2>1_INV_0  (
    .I(\freqgen2/count [2]),
    .O(\freqgen2/Mcompar_freq_out_cmp_gt0000_lut [2])
  );
  INV   \freqgen2/Mcompar_freq_out_cmp_gt0000_lut<3>1_INV_0  (
    .I(\freqgen2/count [3]),
    .O(\freqgen2/Mcompar_freq_out_cmp_gt0000_lut [3])
  );
  INV   \freqgen2/Mcompar_freq_out_cmp_gt0000_lut<4>1_INV_0  (
    .I(\freqgen2/count [4]),
    .O(\freqgen2/Mcompar_freq_out_cmp_gt0000_lut [4])
  );
  INV   \freqgen2/Mcompar_freq_out_cmp_gt0000_lut<5>1_INV_0  (
    .I(\freqgen2/count [5]),
    .O(\freqgen2/Mcompar_freq_out_cmp_gt0000_lut [5])
  );
  INV   \freqgen2/Mcompar_freq_out_cmp_gt0000_lut<6>1_INV_0  (
    .I(\freqgen2/count [6]),
    .O(\freqgen2/Mcompar_freq_out_cmp_gt0000_lut [6])
  );
  INV   \freqgen2/Mcompar_freq_out_cmp_gt0000_lut<7>1_INV_0  (
    .I(\freqgen2/count [7]),
    .O(\freqgen2/Mcompar_freq_out_cmp_gt0000_lut [7])
  );
  INV   \freqgen2/Mcompar_freq_out_cmp_gt0000_lut<8>1_INV_0  (
    .I(\freqgen2/count [8]),
    .O(\freqgen2/Mcompar_freq_out_cmp_gt0000_lut [8])
  );
  INV   \freqgen2/Mcompar_freq_out_cmp_gt0000_lut<9>1_INV_0  (
    .I(\freqgen2/count [9]),
    .O(\freqgen2/Mcompar_freq_out_cmp_gt0000_lut [9])
  );
  INV   \Mcompar_note_in_cmp_ge0000_lut<11>1_INV_0  (
    .I(SecondCtr[31]),
    .O(\Mcompar_note_in_cmp_ge0000_lut[11] )
  );
  INV   \Mcompar_StateCtr_cmp_gt0000_lut<9>1_INV_0  (
    .I(StateCtr[31]),
    .O(\Mcompar_StateCtr_cmp_gt0000_lut[9] )
  );
  INV   \porta1/Mcompar_count_cmp_ge0000_lut<10>1_INV_0  (
    .I(\porta1/_old_count_1 [31]),
    .O(\porta1/Mcompar_count_cmp_ge0000_lut[10] )
  );
  LUT4 #(
    .INIT ( 16'h2AAA ))
  \trgen2/_old_count_5<3>1  (
    .I0(butt_3_IBUF_377),
    .I1(\trgen2/count [1]),
    .I2(\trgen2/count [0]),
    .I3(\trgen2/count [2]),
    .O(\trgen2/_old_count_5<3>1_1060 )
  );
  LUT4 #(
    .INIT ( 16'h8000 ))
  \trgen2/_old_count_5<3>2  (
    .I0(butt_3_IBUF_377),
    .I1(\trgen2/count [0]),
    .I2(\trgen2/count [2]),
    .I3(\trgen2/count [1]),
    .O(\trgen2/_old_count_5<3>2_1061 )
  );
  MUXF5   \trgen2/_old_count_5<3>_f5  (
    .I0(\trgen2/_old_count_5<3>2_1061 ),
    .I1(\trgen2/_old_count_5<3>1_1060 ),
    .S(\trgen2/count [3]),
    .O(\trgen2/_old_count_5 [3])
  );
  LUT4 #(
    .INIT ( 16'h2AAA ))
  \trgen1/_old_count_5<3>1  (
    .I0(butt_3_IBUF_377),
    .I1(\trgen1/count [1]),
    .I2(\trgen1/count [0]),
    .I3(\trgen1/count [2]),
    .O(\trgen1/_old_count_5<3>1_1038 )
  );
  LUT4 #(
    .INIT ( 16'h8000 ))
  \trgen1/_old_count_5<3>2  (
    .I0(butt_3_IBUF_377),
    .I1(\trgen1/count [0]),
    .I2(\trgen1/count [2]),
    .I3(\trgen1/count [1]),
    .O(\trgen1/_old_count_5<3>2_1039 )
  );
  MUXF5   \trgen1/_old_count_5<3>_f5  (
    .I0(\trgen1/_old_count_5<3>2_1039 ),
    .I1(\trgen1/_old_count_5<3>1_1038 ),
    .S(\trgen1/count [3]),
    .O(\trgen1/_old_count_5 [3])
  );
  LUT4 #(
    .INIT ( 16'hF8FF ))
  \mixer/Madd__old_tempresult_6_lut<5>_SW01  (
    .I0(\trgen2/triangle_out [0]),
    .I1(\trgen2/triangle_out [1]),
    .I2(\trgen2/triangle_out [2]),
    .I3(volsel_0_IBUF_1080),
    .O(\mixer/Madd__old_tempresult_6_lut<5>_SW0 )
  );
  MUXF5   \mixer/Madd__old_tempresult_6_lut<5>_SW0_f5  (
    .I0(N0),
    .I1(\mixer/Madd__old_tempresult_6_lut<5>_SW0 ),
    .S(volsel_1_IBUF_1081),
    .O(N41)
  );
  LUT2_D #(
    .INIT ( 4'h2 ))
  \note_in_mux0000<3>11  (
    .I0(note_in_and0000),
    .I1(StateCtr[3]),
    .LO(N51),
    .O(N3)
  );
  LUT2_D #(
    .INIT ( 4'h8 ))
  Mmux_StateCtr_mux00001101 (
    .I0(note_in_cmp_ge0000),
    .I1(Mcompar_StateCtr_cmp_gt0000_cy[9]),
    .LO(N52),
    .O(N2)
  );
endmodule


`ifndef GLBL
`define GLBL

`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;

    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (weak1, weak0) GSR = GSR_int;
    assign (weak1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

endmodule

`endif

