module ask_modulation(out,Din,clk,reset_n,enable);                //ASK Modulator
	input logic Din, clk,reset_n,enable;
	output logic [15:0] out;

	logic [10:0] clk_;
	logic [15:0] w1;
	logic data;

	T_FF tff_1(clk_[0],1'b1,clk);
	T_FF tff_2(clk_[1],1'b1,clk_[0]);
	T_FF tff_3(clk_[2],1'b1,clk_[1]);
	T_FF tff_4(clk_[3],1'b1,clk_[2]);
	T_FF tff_5(clk_[4],1'b1,clk_[3]);
	T_FF tff_6(clk_[5],1'b1,clk_[4]);
	T_FF tff_7(clk_[6],1'b1,clk_[5]);
	T_FF tff_8(clk_[7],1'b1,clk_[6]);
	T_FF tff_9(clk_[8],1'b1,clk_[7]);
	T_FF tff_10(clk_[9],1'b1,clk_[8]);
	T_FF tff_11(clk_[10],1'b1,clk_[9]);

	always_ff @(posedge clk_[8] or negedge reset_n) begin :datablock
		if(~reset_n)
			data <= 0;
		else
			data <= Din;
	end

	ASK ask(w1,data,clk);                    //ASK Modulator

	mux_16 mux(out,16'h2710,w1,enable);

endmodule
