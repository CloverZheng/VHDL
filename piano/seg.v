module seg(
			clk,rst_n,en,
			idis_data,
			ds_stcp,ds_shcp,ds_data
		);

input clk;	//25M??????
input rst_n;	//??????????
input en;
input [15:0] idis_data ;

output ds_stcp;		//74HC595????????????????????????
output ds_shcp;		//74HC595?????????????????????
output ds_data;		//74HC595???????



//????? 0~F ??????
parameter 	SEG_NUM0 	= 8'hc0,
			SEG_NUM1 	= 8'hf9,
			SEG_NUM2 	= 8'ha4,
			SEG_NUM3 	= 8'hb0,
			SEG_NUM4 	= 8'h99,
			SEG_NUM5 	= 8'h92,
			SEG_NUM6 	= 8'h82,
			SEG_NUM7 	= 8'hF8,
			SEG_NUM8 	= 8'h80,
			SEG_NUM9 	= 8'h90,
			SEG_NUMA 	= 8'h88,
			SEG_NUMB 	= 8'h83,
			SEG_NUMC 	= 8'hc6,
			SEG_NUMD 	= 8'ha1,
			SEG_NUME 	= 8'h86,
			SEG_NUMF 	= 8'h8e;

//????? 0~7????
parameter	SEG_WE0		= 8'b1111_1110,
			SEG_WE1		= 8'b1111_1101,
			SEG_WE2		= 8'b1111_1011,
			SEG_WE3		= 8'b1111_0111;
		//	SEG_WE4		= 8'b1110_1111,
		//	SEG_WE5		= 8'b1101_1111,
		//	SEG_WE6		= 8'b1011_1111,
		//	SEG_WE7		= 8'b0111_1111;

wire en;
reg clk_div_2;
reg clk1;

always@(en)  //use enable siganl to break the module 
begin
	if (en==1)
	clk1<=clk;
	else clk1<=clk1;
end


always@(posedge clk1 or negedge rst_n)
	if(!rst_n)
		clk_div_2<=1'b0;
	else 
		clk_div_2<=~clk_div_2;
		 
//-------------------------------------------------

	

//-------------------------------------------------
//??????????
reg[3:0] seg_num;	//??????
reg[7:0] seg_duan;	//7???????????????8??
reg[7:0] seg_wei;	//7????????

reg[7:0] cnt_4;		//?????

	//?????
always @(posedge clk_div_2 or negedge rst_n)
	if(!rst_n) cnt_4 <= 8'd0;
	else cnt_4 <= cnt_4+1'b1;

	//????
always @(posedge clk_div_2 or negedge rst_n)
	if(!rst_n) seg_num <= 8'h00;
	else 
		case(cnt_4[7:6])
				2'b00: seg_num <= idis_data[3:0];
				2'b01: seg_num <= idis_data[7:4];
				2'b10: seg_num <= idis_data[11:8];
				2'b11: seg_num <= idis_data[15:12];
			default:  ;
			endcase

	//??????
reg flag;
always @(posedge clk_div_2 or negedge rst_n)
	if(!rst_n) begin seg_duan <= 8'hff;
					//	flag<=1'b0;
					end 
	//else if(flag) begin seg_duan<=8'hff;
			//			flag<=~flag;
				//	end
	else
		case(seg_num) 
			4'h0: seg_duan <= SEG_NUM0;
			4'h1: seg_duan <= SEG_NUM1;
			4'h2: seg_duan <= SEG_NUM2;
			4'h3: seg_duan <= SEG_NUM3;
			4'h4: seg_duan <= SEG_NUM4;
			4'h5: seg_duan <= SEG_NUM5;
			4'h6: seg_duan <= SEG_NUM6;
			4'h7: seg_duan <= SEG_NUM7;
			4'h8: seg_duan <= SEG_NUM8;
			4'h9: seg_duan <= SEG_NUM9;
			4'ha: seg_duan <= SEG_NUMA;
			4'hb: seg_duan <= SEG_NUMB;
			4'hc: seg_duan <= SEG_NUMC;
			4'hd: seg_duan <= SEG_NUMD;
			4'he: seg_duan <= SEG_NUME;
			4'hf: seg_duan <= SEG_NUMF;
		default:	 ;
		endcase
		

	//????
always @(cnt_4[7:6])
	case(cnt_4[7:6])
			2'b00: seg_wei <= SEG_WE0;
			2'b01: seg_wei <= SEG_WE1;
			2'b10: seg_wei <= SEG_WE2;
			2'b11: seg_wei <= SEG_WE3;
		default:  seg_wei <= 8'b0000_0000;
		endcase

//-------------------------------------------------
//74HC95????			
reg ds_stcpr;	//74HC595????????????????????????
reg ds_shcpr;	//74HC595?????????????????????
reg ds_datar;	//74HC595???????
			
	//????????	
always @(posedge clk_div_2 or negedge rst_n)			
	if(!rst_n) ds_shcpr <= 1'b0;
	else if((cnt_4 > 8'h02 && cnt_4 <= 8'h22) || (cnt_4 > 8'h24 && cnt_4 <= 8'h44)
			|| (cnt_4 > 8'h46 && cnt_4 <= 8'h66) || (cnt_4 > 8'h68 && cnt_4 <= 8'h88)
			|| (cnt_4 > 8'h90 && cnt_4 <= 8'hb0) || (cnt_4 > 8'hb2 && cnt_4 <= 8'hd2)
			|| (cnt_4 > 8'hd4 && cnt_4 <= 8'hf4)) 
		ds_shcpr <= ~ds_shcpr;
	else ds_shcpr<=1'b0;
			
	//????????
always @(posedge clk_div_2 or negedge rst_n)			
	if(!rst_n) ds_datar <= 1'b0;
	else 
		case(cnt_4)
			8'h02,8'h46,8'h90,8'hd4: ds_datar <= seg_duan[7];
			8'h04,8'h48,8'h92,8'hd6: ds_datar <= seg_duan[6];
			8'h06,8'h4a,8'h94,8'hd8: ds_datar <= seg_duan[5];
			8'h08,8'h4c,8'h96,8'hda: ds_datar <= seg_duan[4];
			8'h0a,8'h4e,8'h98,8'hdc: ds_datar <= seg_duan[3];
			8'h0c,8'h50,8'h9a,8'hde: ds_datar <= seg_duan[2];
			8'h0e,8'h52,8'h9c,8'he0: ds_datar <= seg_duan[1];
			8'h10,8'h54,8'h9e,8'he2: ds_datar <= seg_duan[0];
			8'h12,8'h56,8'ha0,8'he4: ds_datar <= seg_wei[0];
			8'h14,8'h58,8'ha2,8'he6: ds_datar <= seg_wei[1];
			8'h16,8'h5a,8'ha4,8'he8: ds_datar <= seg_wei[2];
			8'h18,8'h5c,8'ha6,8'hea: ds_datar <= seg_wei[3];
			8'h1a,8'h5e,8'ha8,8'hec: ds_datar <= seg_wei[4];
			8'h1c,8'h60,8'haa,8'hee: ds_datar <= seg_wei[5];
			8'h1e,8'h62,8'hac,8'hf0: ds_datar <= seg_wei[6];
			8'h20,8'h64,8'hae,8'hf2: ds_datar <= seg_wei[7];
			
			8'h24,8'h68,8'hb2,: ds_datar <= 1;
			8'h26,8'h6a,8'hb4,: ds_datar <= 1;
			8'h28,8'h6c,8'hb6,: ds_datar <= 1;
			8'h2a,8'h6e,8'hb8,: ds_datar <= 1;
			8'h2c,8'h70,8'hba,: ds_datar <= 1;
			8'h2e,8'h72,8'hbc,: ds_datar <= 1;
			8'h30,8'h74,8'hbe,: ds_datar <= 1;
			8'h32,8'h76,8'hc0,: ds_datar <= 1;
			8'h34,8'h78,8'hc2,: ds_datar <= 1;
			8'h36,8'h7a,8'hc4,: ds_datar <= 1;
			8'h38,8'h7c,8'hc6,: ds_datar <= 1;
			8'h3a,8'h7e,8'hc8,: ds_datar <=	1;
			8'h3c,8'h80,8'hca,: ds_datar <= 1;
			8'h3e,8'h82,8'hcc,: ds_datar <= 1;
			8'h40,8'h84,8'hce,: ds_datar <= 1;
			8'h42,8'h86,8'hd0,: ds_datar <= 1;
			
			default: ds_datar <= seg_duan[0];
			endcase

	//????????
always @(posedge clk1 or negedge rst_n)			
	if(!rst_n) ds_stcpr <= 1'b0;
	else if((cnt_4 == 8'h02) || (cnt_4 == 8'h23) || (cnt_4 == 8'h45) || (cnt_4 == 8'h67) || (cnt_4 == 8'h89)|| (cnt_4 == 8'hb1)|| (cnt_4 == 8'hd3)) ds_stcpr <= 1'b0;
	else if((cnt_4 == 8'h22) || (cnt_4 == 8'h44) || (cnt_4 == 8'h66) || (cnt_4 == 8'h88) || (cnt_4 == 8'hb0)|| (cnt_4 == 8'hd2)|| (cnt_4 == 8'hf4)) ds_stcpr <= 1'b1;

wire ds_stcp = ds_stcpr;
wire ds_shcp = ds_shcpr;
wire ds_data = ds_datar;			

endmodule

