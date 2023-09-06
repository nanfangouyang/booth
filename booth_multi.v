module booth_multi(
			input signed [7:0]A,
			input signed [7:0]B,
			output [15:0]C,E
			//output [50:0]D
);//C=A*B;
integer i;
reg [2:0] booth [3:0];
reg signed [15:0]temp  [3:0];
always@(*)begin
   booth[0][2:0]=A[0]-2*A[1];
   for(i=1;i<4;i=i+1)
	begin
	booth[i][2:0]=A[2*i-1]+ A[2*i]-2*A[2*i+1];
	end
end
always@(*)begin
   for(i=0;i<4;i=i+1)begin
   case(booth[i])	
	    3'b000:temp[i][15:0]=     0; 
		 3'b001:temp[i][15:0]= 	   B;
		 3'b010:temp[i][15:0]=   2*B;
		 3'b110:temp[i][15:0]=  -2*B;
		 3'b111:temp[i][15:0]=    -B;
		 endcase
	end
end
assign E= temp[0]+temp[1]*4   +temp[2]*16  +  temp[3]*64;
assign C= temp[0]+(temp[1]<<2)+(temp[2]<<4)+(temp[3]<<6);
//assign D=($signed(temp[0])+$signed{temp[1], (2'b00)}+$signed{temp[2],(4'b00)}+$signed{temp[3],(6'b00)});
endmodule