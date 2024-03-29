// ============================================================================
// Copyright (c) 2012 by Terasic Technologies Inc.
// ============================================================================
//
// Permission:
//
//   Terasic grants permission to use and modify this code for use
//   in synthesis for all Terasic Development Boards and Altera Development
//   Kits made by Terasic.  Other use of this code, including the selling
//   ,duplication, or modification of any portion is strictly prohibited.
//
// Disclaimer:
//
//   This VHDL/Verilog or C/C++ source code is intended as a design reference
//   which illustrates how these types of functions can be implemented.
//   It is the user's responsibility to verify their design for
//   consistency and functionality through the use of formal
//   verification methods.  Terasic provides no warranty regarding the use
//   or functionality of this code.
//
// ============================================================================
//
//  Terasic Technologies Inc
//  9F., No.176, Sec.2, Gongdao 5th Rd, East Dist, Hsinchu City, 30070. Taiwan
//
//
//
//                     web: http://www.terasic.com/
//                     email: support@terasic.com
//
// ============================================================================
//
// Major Functions:	DE2 TOP LEVEL
//
// ============================================================================
//
// Revision History :
// ============================================================================
//   Ver  :| Author            :| Mod. Date :| Changes Made:
//   V1.0 :| Johnny Chen       :| 05/08/19  :|      Initial Revision
//   V1.1 :| Johnny Chen       :| 05/11/16  :|      Added FLASH Address FL_ADDR[21:20]
//   V1.2 :| Johnny Chen       :| 05/11/16  :|		Fixed ISP1362 INT/DREQ Pin Direction.
//   V1.3 :| Johnny Chen       :| 06/11/16  :|		Added the Dedicated TV Decoder Line-Locked-Clock Input
//													            for DE2 v2.X PCB.
//   V1.5 :| Eko    Yan        :| 12/01/30  :|      Update to version 11.1 sp1.
// ============================================================================

module Mips
	(
		////////////////////	Clock Input	 	////////////////////
		CLOCK_27,						//	27 MHz
		CLOCK_50,						//	50 MHz
		EXT_CLOCK,						//	External Clock
		////////////////////	Push Button		////////////////////
		KEY,							//	Pushbutton[3:0]
		////////////////////	DPDT Switch		////////////////////
		SW,								//	Toggle Switch[17:0]
		////////////////////	7-SEG Dispaly	////////////////////
		HEX0,							//	Seven Segment Digit 0
		HEX1,							//	Seven Segment Digit 1
		HEX2,							//	Seven Segment Digit 2
		HEX3,							//	Seven Segment Digit 3
		HEX4,							//	Seven Segment Digit 4
		HEX5,							//	Seven Segment Digit 5
		HEX6,							//	Seven Segment Digit 6
		HEX7,							//	Seven Segment Digit 7
		////////////////////////	LED		////////////////////////
		LEDG,							//	LED Green[8:0]
		LEDR,							//	LED Red[17:0]
		////////////////////////	UART	////////////////////////
		//UART_TXD,						//	UART Transmitter
		//UART_RXD,						//	UART Receiver
		////////////////////////	IRDA	////////////////////////
		//IRDA_TXD,						//	IRDA Transmitter
		//IRDA_RXD,						//	IRDA Receiver
		/////////////////////	SDRAM Interface		////////////////
		DRAM_DQ,						//	SDRAM Data bus 16 Bits
		DRAM_ADDR,						//	SDRAM Address bus 12 Bits
		DRAM_LDQM,						//	SDRAM Low-byte Data Mask
		DRAM_UDQM,						//	SDRAM High-byte Data Mask
		DRAM_WE_N,						//	SDRAM Write Enable
		DRAM_CAS_N,						//	SDRAM Column Address Strobe
		DRAM_RAS_N,						//	SDRAM Row Address Strobe
		DRAM_CS_N,						//	SDRAM Chip Select
		DRAM_BA_0,						//	SDRAM Bank Address 0
		DRAM_BA_1,						//	SDRAM Bank Address 0
		DRAM_CLK,						//	SDRAM Clock
		DRAM_CKE,						//	SDRAM Clock Enable
		////////////////////	Flash Interface		////////////////
		FL_DQ,							//	FLASH Data bus 8 Bits
		FL_ADDR,						//	FLASH Address bus 22 Bits
		FL_WE_N,						//	FLASH Write Enable
		FL_RST_N,						//	FLASH Reset
		FL_OE_N,						//	FLASH Output Enable
		FL_CE_N,						//	FLASH Chip Enable
		////////////////////	SRAM Interface		////////////////
		SRAM_DQ,						//	SRAM Data bus 16 Bits
		SRAM_ADDR,						//	SRAM Address bus 18 Bits
		SRAM_UB_N,						//	SRAM High-byte Data Mask
		SRAM_LB_N,						//	SRAM Low-byte Data Mask
		SRAM_WE_N,						//	SRAM Write Enable
		SRAM_CE_N,						//	SRAM Chip Enable
		SRAM_OE_N,						//	SRAM Output Enable
		////////////////////	ISP1362 Interface	////////////////
		OTG_DATA,						//	ISP1362 Data bus 16 Bits
		OTG_ADDR,						//	ISP1362 Address 2 Bits
		OTG_CS_N,						//	ISP1362 Chip Select
		OTG_RD_N,						//	ISP1362 Write
		OTG_WR_N,						//	ISP1362 Read
		OTG_RST_N,						//	ISP1362 Reset
		OTG_FSPEED,						//	USB Full Speed,	0 = Enable, Z = Disable
		OTG_LSPEED,						//	USB Low Speed, 	0 = Enable, Z = Disable
		OTG_INT0,						//	ISP1362 Interrupt 0
		OTG_INT1,						//	ISP1362 Interrupt 1
		OTG_DREQ0,						//	ISP1362 DMA Request 0
		OTG_DREQ1,						//	ISP1362 DMA Request 1
		OTG_DACK0_N,					//	ISP1362 DMA Acknowledge 0
		OTG_DACK1_N,					//	ISP1362 DMA Acknowledge 1
		////////////////////	LCD Module 16X2		////////////////
		LCD_ON,							//	LCD Power ON/OFF
		LCD_BLON,						//	LCD Back Light ON/OFF
		LCD_RW,							//	LCD Read/Write Select, 0 = Write, 1 = Read
		LCD_EN,							//	LCD Enable
		LCD_RS,							//	LCD Command/Data Select, 0 = Command, 1 = Data
		LCD_DATA,						//	LCD Data bus 8 bits
		////////////////////	SD_Card Interface	////////////////
		//SD_DAT,							//	SD Card Data
		//SD_WP_N,						   //	SD Write protect
		//SD_CMD,							//	SD Card Command Signal
		//SD_CLK,							//	SD Card Clock
		////////////////////	USB JTAG link	////////////////////
		TDI,  							// CPLD -> FPGA (data in)
		TCK,  							// CPLD -> FPGA (clk)
		TCS,  							// CPLD -> FPGA (CS)
	   TDO,  							// FPGA -> CPLD (data out)
		////////////////////	I2C		////////////////////////////
		I2C_SDAT,						//	I2C Data
		I2C_SCLK,						//	I2C Clock
		////////////////////	PS2		////////////////////////////
		PS2_DAT,						//	PS2 Data
		PS2_CLK,						//	PS2 Clock
		////////////////////	VGA		////////////////////////////
		VGA_CLK,   						//	VGA Clock
		VGA_HS,							//	VGA H_SYNC
		VGA_VS,							//	VGA V_SYNC
		VGA_BLANK,						//	VGA BLANK
		VGA_SYNC,						//	VGA SYNC
		VGA_R,   						//	VGA Red[9:0]
		VGA_G,	 						//	VGA Green[9:0]
		VGA_B,  						//	VGA Blue[9:0]
		////////////	Ethernet Interface	////////////////////////
		ENET_DATA,						//	DM9000A DATA bus 16Bits
		ENET_CMD,						//	DM9000A Command/Data Select, 0 = Command, 1 = Data
		ENET_CS_N,						//	DM9000A Chip Select
		ENET_WR_N,						//	DM9000A Write
		ENET_RD_N,						//	DM9000A Read
		ENET_RST_N,						//	DM9000A Reset
		ENET_INT,						//	DM9000A Interrupt
		ENET_CLK,						//	DM9000A Clock 25 MHz
		////////////////	Audio CODEC		////////////////////////
		AUD_ADCLRCK,					//	Audio CODEC ADC LR Clock
		AUD_ADCDAT,						//	Audio CODEC ADC Data
		AUD_DACLRCK,					//	Audio CODEC DAC LR Clock
		AUD_DACDAT,						//	Audio CODEC DAC Data
		AUD_BCLK,						//	Audio CODEC Bit-Stream Clock
		AUD_XCK,						//	Audio CODEC Chip Clock
		////////////////	TV Decoder		////////////////////////
		TD_DATA,    					//	TV Decoder Data bus 8 bits
		TD_HS,							//	TV Decoder H_SYNC
		TD_VS,							//	TV Decoder V_SYNC
		TD_RESET,						//	TV Decoder Reset
		TD_CLK27,                  //	TV Decoder 27MHz CLK
		////////////////////	GPIO	////////////////////////////
		GPIO_0,							//	GPIO Connection 0
		GPIO_1							//	GPIO Connection 1
	);

////////////////////////	Clock Input	 	////////////////////////
input		   	CLOCK_27;				//	27 MHz
input		   	CLOCK_50;				//	50 MHz
input			   EXT_CLOCK;				//	External Clock
////////////////////////	Push Button		////////////////////////
input	   [3:0]	KEY;					//	Pushbutton[3:0]
////////////////////////	DPDT Switch		////////////////////////
input	  [17:0]	SW;						//	Toggle Switch[17:0]
////////////////////////	7-SEG Dispaly	////////////////////////
output	[6:0]	HEX0;					//	Seven Segment Digit 0
output	[6:0]	HEX1;					//	Seven Segment Digit 1
output	[6:0]	HEX2;					//	Seven Segment Digit 2
output	[6:0]	HEX3;					//	Seven Segment Digit 3
output	[6:0]	HEX4;					//	Seven Segment Digit 4
output	[6:0]	HEX5;					//	Seven Segment Digit 5
output	[6:0]	HEX6;					//	Seven Segment Digit 6
output	[6:0]	HEX7;					//	Seven Segment Digit 7
////////////////////////////	LED		////////////////////////////
output	[8:0]	LEDG;					//	LED Green[8:0]
output  [17:0]	LEDR;					//	LED Red[17:0]
////////////////////////////	UART	////////////////////////////
//output			UART_TXD;				//	UART Transmitter
//input			   UART_RXD;				//	UART Receiver
////////////////////////////	IRDA	////////////////////////////
//output			IRDA_TXD;				//	IRDA Transmitter
//input			   IRDA_RXD;				//	IRDA Receiver
///////////////////////		SDRAM Interface	////////////////////////
inout	  [15:0]	DRAM_DQ;				//	SDRAM Data bus 16 Bits
output  [11:0]	DRAM_ADDR;				//	SDRAM Address bus 12 Bits
output			DRAM_LDQM;				//	SDRAM Low-byte Data Mask
output			DRAM_UDQM;				//	SDRAM High-byte Data Mask
output			DRAM_WE_N;				//	SDRAM Write Enable
output			DRAM_CAS_N;				//	SDRAM Column Address Strobe
output			DRAM_RAS_N;				//	SDRAM Row Address Strobe
output			DRAM_CS_N;				//	SDRAM Chip Select
output			DRAM_BA_0;				//	SDRAM Bank Address 0
output			DRAM_BA_1;				//	SDRAM Bank Address 0
output			DRAM_CLK;				//	SDRAM Clock
output			DRAM_CKE;				//	SDRAM Clock Enable
////////////////////////	Flash Interface	////////////////////////
inout	  [7:0]	FL_DQ;					//	FLASH Data bus 8 Bits
output [21:0]	FL_ADDR;				//	FLASH Address bus 22 Bits
output			FL_WE_N;				//	FLASH Write Enable
output			FL_RST_N;				//	FLASH Reset
output			FL_OE_N;				//	FLASH Output Enable
output			FL_CE_N;				//	FLASH Chip Enable
////////////////////////	SRAM Interface	////////////////////////
inout	 [15:0]	SRAM_DQ;				//	SRAM Data bus 16 Bits
output [17:0]	SRAM_ADDR;				//	SRAM Address bus 18 Bits
output			SRAM_UB_N;				//	SRAM High-byte Data Mask
output			SRAM_LB_N;				//	SRAM Low-byte Data Mask
output			SRAM_WE_N;				//	SRAM Write Enable
output			SRAM_CE_N;				//	SRAM Chip Enable
output			SRAM_OE_N;				//	SRAM Output Enable
////////////////////	ISP1362 Interface	////////////////////////
inout	 [15:0]	OTG_DATA;				//	ISP1362 Data bus 16 Bits
output  [1:0]	OTG_ADDR;				//	ISP1362 Address 2 Bits
output			OTG_CS_N;				//	ISP1362 Chip Select
output			OTG_RD_N;				//	ISP1362 Write
output			OTG_WR_N;				//	ISP1362 Read
output			OTG_RST_N;				//	ISP1362 Reset
output			OTG_FSPEED;				//	USB Full Speed,	0 = Enable, Z = Disable
output			OTG_LSPEED;				//	USB Low Speed, 	0 = Enable, Z = Disable
input			   OTG_INT0;				//	ISP1362 Interrupt 0
input			   OTG_INT1;				//	ISP1362 Interrupt 1
input			   OTG_DREQ0;				//	ISP1362 DMA Request 0
input			   OTG_DREQ1;				//	ISP1362 DMA Request 1
output			OTG_DACK0_N;			//	ISP1362 DMA Acknowledge 0
output			OTG_DACK1_N;			//	ISP1362 DMA Acknowledge 1
////////////////////	LCD Module 16X2	////////////////////////////
inout	  [7:0]	LCD_DATA;				//	LCD Data bus 8 bits
output			LCD_ON;					//	LCD Power ON/OFF
output			LCD_BLON;				//	LCD Back Light ON/OFF
output			LCD_RW;					//	LCD Read/Write Select, 0 = Write, 1 = Read
output			LCD_EN;					//	LCD Enable
output			LCD_RS;					//	LCD Command/Data Select, 0 = Command, 1 = Data
////////////////////	SD Card Interface	////////////////////////
//inout	 [3:0]	SD_DAT;					//	SD Card Data
//input			   SD_WP_N;				   //	SD write protect
//inout			   SD_CMD;					//	SD Card Command Signal
//output			SD_CLK;					//	SD Card Clock
////////////////////////	I2C		////////////////////////////////
inout			   I2C_SDAT;				//	I2C Data
output			I2C_SCLK;				//	I2C Clock
////////////////////////	PS2		////////////////////////////////
input		 	   PS2_DAT;				//	PS2 Data
input			   PS2_CLK;				//	PS2 Clock
////////////////////	USB JTAG link	////////////////////////////
input  			TDI;					// CPLD -> FPGA (data in)
input  			TCK;					// CPLD -> FPGA (clk)
input  			TCS;					// CPLD -> FPGA (CS)
output 			TDO;					// FPGA -> CPLD (data out)
////////////////////////	VGA			////////////////////////////
output			VGA_CLK;   				//	VGA Clock
output			VGA_HS;					//	VGA H_SYNC
output			VGA_VS;					//	VGA V_SYNC
output			VGA_BLANK;				//	VGA BLANK
output			VGA_SYNC;				//	VGA SYNC
output	[9:0]	VGA_R;   				//	VGA Red[9:0]
output	[9:0]	VGA_G;	 				//	VGA Green[9:0]
output	[9:0]	VGA_B;   				//	VGA Blue[9:0]
////////////////	Ethernet Interface	////////////////////////////
inout	[15:0]	ENET_DATA;				//	DM9000A DATA bus 16Bits
output			ENET_CMD;				//	DM9000A Command/Data Select, 0 = Command, 1 = Data
output			ENET_CS_N;				//	DM9000A Chip Select
output			ENET_WR_N;				//	DM9000A Write
output			ENET_RD_N;				//	DM9000A Read
output			ENET_RST_N;				//	DM9000A Reset
input			   ENET_INT;				//	DM9000A Interrupt
output			ENET_CLK;				//	DM9000A Clock 25 MHz
////////////////////	Audio CODEC		////////////////////////////
inout			   AUD_ADCLRCK;			//	Audio CODEC ADC LR Clock
input			   AUD_ADCDAT;				//	Audio CODEC ADC Data
inout			   AUD_DACLRCK;			//	Audio CODEC DAC LR Clock
output			AUD_DACDAT;				//	Audio CODEC DAC Data
inout			   AUD_BCLK;				//	Audio CODEC Bit-Stream Clock
output			AUD_XCK;				//	Audio CODEC Chip Clock
////////////////////	TV Devoder		////////////////////////////
input	 [7:0]	TD_DATA;    			//	TV Decoder Data bus 8 bits
input			   TD_HS;					//	TV Decoder H_SYNC
input			   TD_VS;					//	TV Decoder V_SYNC
output			TD_RESET;				//	TV Decoder Reset
input          TD_CLK27;            //	TV Decoder 27MHz CLK
////////////////////////	GPIO	////////////////////////////////
inout	[35:0]	GPIO_0;					//	GPIO Connection 0
inout	[35:0]	GPIO_1;					//	GPIO Connection 1

wire[31:0] pc_IF, pc_ID, pc_EXE, pc_MEM;
wire[31:0] pc_EXE1;
wire[31:0] pc_EXE2;
wire[31:0] pc_MEM1;
wire[31:0] pc_MEM2;
wire[31:0] pc_WB1;
wire[31:0] pc_WB2;

wire[31:0] instruction;
wire[31:0] instruction_out;

wire ID_WB_Write_Enable;
wire[4:0] ID_WB_Dest;
wire[31:0] ID_WB_Data;
wire[4:0] ID_Dest, EXE_Dest, MEM_Dest, WB_Dest;
wire[31:0] ID_Reg2, EXE_Reg2;
wire[31:0] ID_Val2, EXE_Val2;
wire[31:0] ID_Val1, EXE_Val1;
wire[3:0] ID_EXE_CMD, EXE_EXE_CMD;
wire ID_MEM_R_EN, EXE_MEM_R_EN, MEM_MEM_R_EN, WB_MEM_R_EN;
wire ID_MEM_W_EN, EXE_MEM_W_EN, MEM_MEM_W_EN;
wire ID_WB_EN, EXE_WB_EN, MEM_WB_EN, WB_WB_en;
wire[1:0] ID_Branch_Type, EXE_Branch_Type;

wire[31:0] EXE_ALU_result, MEM_ALU_result, WB_ALU_result;
wire[31:0] EXE_Br_Addr;
wire EXE_Br_taken;

wire[31:0] ST_val;
wire[31:0] MEM_Mem_read_value, WB_Mem_read_value;

wire Freeze, is_immediate, is_immediate2, mem_w_en, ready;
wire[1:0] branch_type;

wire[1:0] sel1, sel2, sel3;

wire[4:0] ID_src1, ID_src2, EXE_src1, EXE_src2;

IF_Stage IF(.clk(CLOCK_50), .rst(SW[0]), .Br_taken(EXE_Br_taken) , .Br_Addr(EXE_Br_Addr), .Freeze(Freeze || ~ready),.PC(pc_IF), .Instruction(instruction));
IF_Stage_reg IF_reg(.clk(CLOCK_50), .rst(SW[0]), .Flush(EXE_Br_taken), .PC_in(pc_IF), .Instruction_in(instruction), .Freeze(Freeze || ~ready), .PC(pc_ID), .Instruction(instruction_out));

Hazard_Detection_Unit hazard_detection(.src1(instruction_out[25:21]), .src2(instruction_out[20:16]), .Exe_Dest(EXE_Dest),
																		.Exe_WB_EN(EXE_WB_EN), .Mem_Dest(MEM_Dest), .Mem_WB_EN(MEM_WB_EN),
																		.is_immediate(is_immediate), .MEM_R_EN(EXE_MEM_R_EN), .MEM_W_EN(mem_w_en),
																		.Branch_Type(branch_type), .forward_en(SW[3]), .hazard_detected(Freeze));

Forward_Unit forward_unit(.src1(EXE_src1), .src2(EXE_src2), .Exe_Dest(EXE_Dest), .Mem_Dest(MEM_Dest), .Mem_WB_EN(MEM_WB_EN),
													.WB_Dest(WB_Dest), .WB_WB_EN(WB_WB_en), .forward_en(SW[3]), .is_immediate(is_immediate2),
													.MEM_W_EN(EXE_MEM_W_EN), .Branch_Type(EXE_Branch_Type),
													.sel1(sel1), .sel2(sel2), .sel3(sel3));

ID_Stage ID(.clk(CLOCK_50), .rst(SW[0]), .Instruction(instruction_out), .WB_Write_Enable(ID_WB_Write_Enable), .WB_Dest(ID_WB_Dest), .WB_Data(ID_WB_Data), .Freeze(Freeze),
				.Dest(ID_Dest), .Reg2(ID_Reg2), .Val2(ID_Val2), .Val1(ID_Val1), .EXE_CMD(ID_EXE_CMD), .MEM_R_EN(ID_MEM_R_EN), .MEM_W_EN(ID_MEM_W_EN),
				.WB_EN(ID_WB_EN), .Branch_Type(ID_Branch_Type), .Is_Immediate(is_immediate), .MEM_W_EN2(mem_w_en), .Branch_Type2(branch_type),
				.src1(ID_src1), .src2(ID_src2));
ID_Stage_reg ID_reg(.clk(CLOCK_50), .rst(SW[0]), .Flush(EXE_Br_taken), .Dest_in(ID_Dest), .Reg2_in(ID_Reg2), .Val2_in(ID_Val2), .Val1_in(ID_Val1),
										.PC_in(pc_ID), .EXE_CMD_in(ID_EXE_CMD), .MEM_R_EN_in(ID_MEM_R_EN), .MEM_W_EN_in(ID_MEM_W_EN),
										.WB_EN_in(ID_WB_EN), .Branch_Type_in(ID_Branch_Type), .is_imm_in(is_immediate),
										.src1_in(ID_src1), .src2_in(ID_src2), .Freeze(~ready),
										.Dest(EXE_Dest), .Reg2(EXE_Reg2), .Val2(EXE_Val2), .Val1(EXE_Val1),
										.PC_out(pc_EXE), .EXE_CMD(EXE_EXE_CMD), .MEM_R_EN(EXE_MEM_R_EN), .MEM_W_EN(EXE_MEM_W_EN),
										.WB_EN(EXE_WB_EN), .Branch_Type(EXE_Branch_Type), .is_imm(is_immediate2), .src1(EXE_src1), .src2(EXE_src2));

EXE_Stage EXE(.clk(CLOCK_50), .EXE_CMD(EXE_EXE_CMD), .val1(EXE_Val1), .val2(EXE_Val2), .val_src2(EXE_Reg2), .PC(pc_EXE),
				.Br_type(EXE_Branch_Type), .sel1(sel1), .sel2(sel2), .sel3(sel3), .MEM_ALU_Result(MEM_ALU_result), .Write_Value(ID_WB_Data),
				.ALU_result(EXE_ALU_result), .Br_Addr(EXE_Br_Addr), .Br_taken(EXE_Br_taken));
EXE_Stage_reg EXE_reg(.clk(CLOCK_50), .rst(SW[0]), .WB_en_in(EXE_WB_EN),
											.MEM_R_EN_in(EXE_MEM_R_EN), .MEM_W_EN_in(EXE_MEM_W_EN),
											.PC_in(pc_EXE), .ALU_result_in(EXE_ALU_result),
											.ST_val_in(EXE_Reg2), .Dest_in(EXE_Dest), .Freeze(~ready),
											.WB_en(MEM_WB_EN),
											.MEM_R_EN(MEM_MEM_R_EN), .MEM_W_EN(MEM_MEM_W_EN), .PC(pc_MEM),
											.ALU_result(MEM_ALU_result), .ST_val(ST_val), .Dest(MEM_Dest));

MEM_Stage MEM(.clk(CLOCK_50), .rst(SW[0]), .MEM_R_EN_in(MEM_MEM_R_EN),
							.MEM_W_EN_in(MEM_MEM_W_EN), .ALU_result_in(MEM_ALU_result),
							.ST_val(ST_val), .Mem_read_value(MEM_Mem_read_value),
							.ready(ready), .SRAM_DQ(SRAM_DQ), .SRAM_ADDR(SRAM_ADDR),
							.SRAM_UB_N(SRAM_UB_N), .SRAM_LB_N(SRAM_LB_N), .SRAM_WE_N(SRAM_WE_N),
							.SRAM_CE_N(SRAM_CE_N), .SRAM_OE_N(SRAM_OE_N));
MEM_Stage_reg MEM_reg(.clk(CLOCK_50), .rst(SW[0]), .WB_en_in(MEM_WB_EN),
										  .MEM_R_EN_in(MEM_MEM_R_EN), .ALU_result_in(MEM_ALU_result),
											.Mem_read_value_in(MEM_Mem_read_value), .Dest_in(MEM_Dest), .Freeze(~ready),
											.WB_en(WB_WB_en), .MEM_R_EN(WB_MEM_R_EN),
											.ALU_result(WB_ALU_result), .Mem_read_value(WB_Mem_read_value),
											.Dest(WB_Dest));

WB_Stage WB(.clk(CLOCK_50), .WB_en_in(WB_WB_en), .MEM_R_EN(WB_MEM_R_EN),
						.ALU_result(WB_ALU_result), .Mem_read_value(WB_Mem_read_value),
						.Dest_in(WB_Dest), .WB_en(ID_WB_Write_Enable),
						.Write_value(ID_WB_Data), .Dest(ID_WB_Dest));

endmodule
