// states
parameter IF 		= 5'b00000, // Instruction Fetch
			ID 		= 5'b00001, // Instruction Decode 
			Mem_Acc = 5'b00010, // 
			LD_RD 	= 5'b00011, // Read memory
			LD_WB 	= 5'b00100,
			SV_WB 	= 5'b00101, // Write memory
			R_Exe 	= 5'b00110, // Execute R type
			R_SA 	= 5'b11110, // R type with SA nums
			R_WB 	= 5'b00111, // R type writeback
			I_Exe 	= 5'b01010, // Execute I type
			I_WB 	= 5'b01011, // I type writeback
			Lui_WB 	= 5'b01100, 
			Beq_Exe = 5'b01000, 
			Bne_Exe = 5'b01101,
			J 		= 5'b01001, // jump
			Jr 		= 5'b01110, // jump register
			JAL 	= 5'b01111, // 
			JALr	= 5'b11111,
            BGEZAL_Exe  = 5'b10001;
			
// define datapath signal output for states
//`define Datapath_signals {PCWrite,PCWriteCond,IorD,MemRead,MemWrite,IRWrite,MemtoReg,PCSource,ALUSrcB,ALUSrcA,RegWrite,RegDst,Branch,CPU_MIO}
//                          1       1           1    1       1        1       2        2        3       1       1        2      1      1
//                          1       2           3    4       5        6       7        9        11      14      15       16     18     19
//                                          B  A
parameter value_IF			= 19'b1000010000001000001,
			value_ID		= 19'b0000000000011000000,
			value_Mem_Acc	= 19'b0000000000010100000,
			value_LD_RD		= 19'b0011000000010100001,
			value_LD_WB		= 19'b0000000100000010000,
			value_SV_WB		= 19'b0010100000010100001,
			value_R_Exe		= 19'b0000000000000100000,
			value_R_SA		= 19'b0000000000100100000,
			value_R_WB		= 19'b0000000000000110100,
			value_I_Exe		= 19'b0000000000010100000,
			value_I_WB		= 19'b0000000000010110000,
			value_Lui_WB	= 19'b0000001100011010000,
			value_Beq_Exe	= 19'b0100000001000100010,
			value_Bne_Exe	= 19'b0100000001000100010,
			value_J			= 19'b1000000010011000000,
			value_Jr		= 19'b1000000000000100000,
			value_JAL		= 19'b1000001010011011000,
			value_JALr		= 19'b1000001000000111000,
           value_BGEZAL_Exe = 19'b0100001001101111010;
            
// define OPCodes
parameter OP_R 		= 6'b000000,
			OP_LUi 	= 6'b001111,
			OP_LW 	= 6'b100011,
			OP_LWx 	= 6'b100010,
			OP_LH 	= 6'b100001,
			OP_LHx 	= 6'b100000,
			OP_LHu 	= 6'b100101,
			OP_LHux	= 6'b100100,
			OP_SW 	= 6'b101011,
			OP_SWx 	= 6'b101010,
			OP_SH 	= 6'b101001,
			OP_SHx 	= 6'b101000,
			OP_ADDi	= 6'b001000,
			OP_SLTi	= 6'b001010,
			OP_SLTiu= 6'b001011,
			OP_ANDi	= 6'b001100,
			OP_ORi	= 6'b001101,
			OP_XORi	= 6'b001110,
			OP_BEQ	= 6'b000100,
			OP_BNE	= 6'b000101,
            OP_J    = 6'b000010,
            OP_JAL  = 6'b000011,
            OP_BGEZAL = 6'b000001;


// define ALU Func Codes
parameter ALU_ADD	 = 6'b100000,
			ALU_SUB	 = 6'b100010,
			ALU_SLT	 = 6'b101010,
			ALU_SLTu = 6'b101011,
			ALU_AND	 = 6'b100100,
			ALU_OR	 = 6'b100101,
			ALU_XOR	 = 6'b100110,
			ALU_NOR	 = 6'b100111,
			ALU_SLL	 = 6'b000000,
			ALU_SLLv = 6'b000100,
			ALU_SRL	 = 6'b000010,
			ALU_SRLv = 6'b000110,
			ALU_SRA	 = 6'b000011,
			ALU_SRAv = 6'b000111,
			ALU_Jr	 = 6'b001000,
			ALU_JALr = 6'b001001;

// define ALU opcode
parameter AND	= 4'b0000,
			OR 	= 4'b0001,
			ADD	= 4'b0010,
			SUB	= 4'b0110,
			NOR	= 4'b0100,
			SLT	= 4'b0111,
			SLTu = 4'b1001,
			XOR	= 4'b1000,
			SLL	= 4'b0011, // A as data, B as payload
			SRA = 4'b1010,
			SRL	= 4'b0101,
            EQUAL = 4'b1011;

// define RAM Control
parameter Full = 000,
			Fullx = 001,
			FullNA = 010,
			FullxNA = 011,
			Halfux = 100,
			Halfu = 101,
			Halfx = 110,
			Half = 111;
