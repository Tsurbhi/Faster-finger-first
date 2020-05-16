# Faster-finger-first
module project(P,Q);
	input wire [3:0]P; // input player
	output reg [3:0]Q=4'b0000; // intial output
	reg [3:0]Qn=4'b1111; // intial output
	wire [3:0]q; // variable assign for output
	wire [3:0]qn; // variable assign for output
	wire enable;
	
	assign enable=Qn[0] && Qn[1] && Qn[2] && Qn[3]; // anding of previse output of flipflops(feedback)
	
	JKFF1 JK1(.q(q[0]),.qn(qn[0]),.clk(enable),.j(1),.k(1),.reset(0),.preset(0)); // JK flipflop1
	JKFF1 JK2(.q(q[1]),.qn(qn[1]),.clk(enable),.j(1),.k(1),.reset(0),.preset(0)); // JK flipflop2
	JKFF1 JK3(.q(q[2]),.qn(qn[2]),.clk(enable),.j(1),.k(1),.reset(0),.preset(0)); // JK flipflop3
	JKFF1 JK4(.q(q[3]),.qn(qn[3]),.clk(enable),.j(1),.k(1),.reset(0),.preset(0)); // JK flipflop4
	
	
	// latch1
	
	always @(P[0] or enable)  // loop will change if either of player1 or enable change
		if(enable) // latch is active if enable high
	begin
		Q[0]<=q[0];
		Qn[0]<=qn[0];
	end
	
	
	//latch 2
	
	always @(P[1] or enable) // loop will change if either of player2 or enable change
		if(enable) // latch is active if enable high
		begin
			Q[1]<=q[1];
			Qn[1]<=qn[1];
		end
	
	
	//latch3

	always @(P[2] or enable) // loop will change if either of player3 or enable change
	if(enable) // latch is active if enable high
		begin
			Q[2]<=q[2];
			Qn[2]<=qn[2];
		end
		

		//latch4

	always @(P[3] or enable) // loop will change if either of player4 or enable change
	if(enable) // latch is active if enable high
		begin
			Q[3]<=q[3];
			Qn[3]<=qn[3];
		end
		
endmodule


// JK flipflop

module JKFF1(output reg q=0,qn=1,input wire clk,j,k,reset,preset);
	always @(posedge clk or posedge preset or posedge reset)
	if(reset)
	begin
		q<=1'b0;
		qn<=1'b1;
	end
	else if(preset)
	begin
		q<=1'b1;
		qn<=1'b0;
	end
	else if(~j & ~k)
	begin
		q<=q;
		qn<=qn;
	end
	else if(~j & k)
	begin
		q<=1'b0;
		qn<=1'b1;
	end
	else if(j & ~k)
	begin
		q<=1'b1;
		qn<=1'b0;
	end
	else if(j & k)
	begin
		q<=~q;
		qn<=q;
	end
endmodule
