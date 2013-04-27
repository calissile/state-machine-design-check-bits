module fsm(input x, clock, reset, output reg z, output reg [0:3] nstate, output reg [0:3]pstate);

parameter start = 0;

parameter state0 = 1;
parameter state00 = 2;
parameter state001 = 3;
parameter state0011 = 4;
parameter state00111 = 5;
parameter state001111 = 6;
parameter state0011111 = 7;

parameter state01 = 8;
parameter state010 = 9;
parameter state0100 = 10;
parameter state01000 = 11;
parameter state010001 = 12;
parameter state0100011 = 13;

always@(posedge(reset), posedge(clock))
begin
	if(reset)
	begin
		pstate <= start;
		z <= 0;	
	end
	else
	begin
		pstate <= nstate;
		z <= (nstate == state0011111 || nstate == state0100011);
	end
	
end

always@(*)
begin

	case(pstate)
	
	state0: nstate <= (x)? state01 : state00;

	//sequence 0011111
	state00: nstate <= (x)? state001 : state00;
	state001: nstate <= (x)? state0011 : state010 ;
	state0011: nstate <= (x)? state00111 : start;
	state00111: nstate <= (x)? state001111 : start;
	state001111: nstate <= (x)? state0011111 : start;
	state0011111: nstate <= start;

	//sequence 0100011
	state01: nstate <= (x)? start : state010;
	state010: nstate <= (x)? start : state0100;
	state0100: nstate <= (x)? state001 : state01000;
	state01000: nstate <= (x)? state010001 : state00;
	state010001: nstate <= (x)? state0100011 : state010;
	state0100011: nstate <= (x)? state00111 : state0011;	

	start: nstate <= state0;
	default: nstate <= start;
		

	endcase


end
endmodule

module testcode(output reg reset, output reg clock, output reg x);

initial
  begin
    $dumpvars;
    $dumpfile("practicum.dump");
    reset = 1;
    clock = 0;
    x = 0;
#10 reset = 0;
    clock = 1;
    x = 0;
#10 clock = 0;
#5  x = 0;
#5  clock = 1;
#10 clock = 0;
#5  x = 0;
#5  clock = 1;
#10 clock = 0;
#5  x = 1;
#5  clock = 1;
#10 clock = 0;
#5  x = 1;
#5  clock = 1;
#10 clock = 0;
#5  x = 1;
#5  clock = 1;
#10 clock = 0;
#5  x = 1;
#5  clock = 1;
#10 clock = 0;
#5  x = 1;
#5  clock = 1;
#10 clock = 0;
#5  x = 0;
#5  clock = 1;
#10 clock = 0;
#5  x = 0;
#5  clock = 1;
#10 clock = 0;
#5  x = 0;
#5  clock = 1;
#10 clock = 0;
#5  x = 0;
#5  clock = 1;
#10 clock = 0;
#5  x = 1;
#5  clock = 1;
#10 clock = 0;
#5  x = 0;
#5  clock = 1;
#10 clock = 0;
#5  x = 0;
#5  clock = 1;
#10 clock = 0;
#5  x = 0;
#5  clock = 1;
#10 clock = 0;
#5  x = 1;
#5  clock = 1;
#10 clock = 0;
#5  x = 1;
#5  clock = 1;
#10 clock = 0;
#5  x = 0;
#5  clock = 1;
#10 clock = 0;
#10 $finish;
  end
endmodule

module testbench;
wire x ,clock, reset, z, nstate, pstate;
fsm(x,clock,reset,z,nstate,pstate);
testcode(reset,clock,x);
endmodule

