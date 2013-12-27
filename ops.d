module ops;

enum BrainOp : ubyte {
	MORPH,
	MORPH_X,
	
	CREATE_NODE_BEFORE,
	CREATE_NODE_AFTER,
	CREATE_IF_BEFORE,
	CREATE_IF_AFTER,
	CREATE_LOOP_BEFORE,
	CREATE_LOOP_AFTER,
	
	RANDB_1,
	RANDB_2,
	RANDI_1,
	RANDI_2,
	
	STOREB,
	LOADB_1,
	LOADB_2,
	
	STOREI,
	LOADI_1,
	LOADI_2,
	
	PUSHB,
	POPB_1,
	POPB_2,
	
	ADD,
	SUB,
	MUL,
	DIV,
	
	XOR,
	AND,
	OR,
	NOT
	
	SHIFTL_1,
	SHIFTL_2,
	SHIFTR_1,
	SHIFTR_2,
	
	MOD,
	POW,
	
	ESCAPE,
	
	REMEMBER,
	RECALL
}