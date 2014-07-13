#!/bin/bash

#tb_gen.sh 
#Generates a Verilog testbench from a file of input vectors
#Makes verification a bit faster and easier
#
#Input: Formatted file, as below (arg 1)
#	Comments (preceded with //):
#      Ignored. All lines not used must be commented.
#   Configuration (preceded with #):
#      SIG_INPUT_WIDTH: width of input signal
#      SIG_NAME: name of the input signals. corresponds to their order in the vectors
#      SIG_DELAY: delay between each vector being presented
#	Test Vectors
#      Any number. Should match specified configuration
#Output: Unformatted file with vectors
#           converted to binary (arg 2)
#        Partially complete Verilog testbench that automatically loads
#           test vectors (arg 3)
#Usage: tb_gen input_vec_fmt input_vec_unfmt verilog_tb
#Note: cannot have whitespace at end of input file!
#

sig_width_param="#SIG_OUTPUT_WIDTH"
input_base_param="#SIG_INPUT_BASE"
delay_param="#SIG_DELAY"
sig_name_param="#SIG_NAME"

#remove file extension and tb_ prefix
module_name=`echo $3 | sed -e "s/tb_//" | sed -e "s/\..*//"`

#~~~~~~~~~~Configuration parameters~~~~~~~~~~~~~~
sig_width=`cat $1 | egrep $sig_width_param | \
         sed -e "s/$sig_width_param[^0-9]*//"`
delay=`cat $1 | egrep $delay_param | \
         sed -e "s/$delay_param[^0-9]*//"`
		 
#scrape the signal names into an array
sig_names=(`cat $1 | egrep $sig_name_param | \
          sed -e "s/$sig_name_param //" | \
		  sed -e "s/[ ]*,[ ]*/\n/g"`)

#calculate total width by num_sigs * output_width
#find number of commas
num_sigs=`cat $1 | egrep "#SIG_NAME" | \
         egrep -o "," | wc -l`

#one more signal than comma
num_sigs=$(($num_sigs + 1))
output_width=$(($sig_width * $num_sigs))

#Ignore comments and config parameters, strip out commas
cat $1 | egrep -v "//" | egrep -v "#" | sed -e "s/[ ]*,[ ]*//g" > $2

echo "Input vectors created! See $2"

#~~~~~~~~~~~~~~~~Print Verilog testbench file~~~~~~~~~~~~~~
#calculate number of input vectors
num_vec=`cat $2 | wc -l`

echo "
\`timescale 1ns / 1ps

module tb_$module_name();

//PARAMETERS
parameter vec_width = $sig_width;
parameter total_width = $output_width;
parameter num_vec = $num_vec;

//SIGNALS" > $3

for sig in ${sig_names[@]} 
do
	echo "reg [vec_width-1:0] $sig;" >> $3
done

echo "
//MODULE INSTANTIATION
//Todo: Add parameters and outputs
$module_name dut(" >> $3

for sig in ${sig_names[@]} 
do
	if [ "$sig" = "${sig_names[@]:(-1)}" ]
	then
		echo "  .$sig($sig)" >> $3
	else
		echo "  .$sig($sig)," >> $3
	fi
done

echo ");

//VECTOR ARRAYS
reg [vec_width-1:0] testVectors[num_vec-1:0];

//FILE HANDLES
integer output_actual;

//LOOP BOUNDS
integer i;

task testDesign; begin
	output_actual = \$fopen(\"${module_name}_output.txt\");
	for (i = 0; i < num_vec; i = i + 1) begin
		#$delay" >> $3

upper_bound=$(($output_width - 1)) #total width
lower_bound=$(($output_width - $sig_width))
for sig in ${sig_names[@]} 
do
	echo "		$sig <= testVectors[i][$upper_bound:$lower_bound];" >> $3
	upper_bound=$(($lower_bound - 1))
	lower_bound=$(($lower_bound - $sig_width))
done

echo "	end
	\$fclose(output_actual);
end
endtask

task generateRefOutput; begin
end
endtask

task verifyDesign; begin
end
endtask

initial begin
	\$readmemh(\"$2\", testVectors);
	
	generateRefOutput();
	testDesign();
	verifyDesign();
	
	\$stop;
end
endmodule" >> $3

echo "Testbench file created! See $3"

