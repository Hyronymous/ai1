module brain;

import signal;
import ops;

import std.random;

final class Brain {
private:
	interface INode {
		void process(Signal s);
	}
	
	struct NodeDefinition {
		BrainOp[] ops;
	}

	INode head;
	NodeDefinition[] nodeTypes;
	
	uint reg1;
	uint reg2;
	uint reg3;
	
	uint counter;
	
	final class ProcessNode : INode {
	private:
		BrainOp[] ops;
		
	public:
		void process(Signal sig) {
			foreach (op; ops) final switch (op) {
			case BrainOp.MORPH:
				
			break;
			case BrainOp.MORPH_X:
				
			break;
			case BrainOp.CREATE_NODE_BEFORE:
				
			break;
			case BrainOp.CREATE_NODE_AFTER:
				
			break;
			case BrainOp.CREATE_IF_BEFORE:
				
			break;
			case BrainOp.CREATE_IF_AFTER:
				
			break;
			case BrainOp.CREATE_LOOP_BEFORE:
				
			break;
			case BrainOp.CREATE_LOOP_AFTER:
				
			break;
			
			case BrainOp.RANDB_1:
				reg1 = uniform!ubyte;
			break;
			case BrainOp.RANDB_2:
				reg2 = uniform!ubyte;
			break;
			case BrainOp.RANDI_1:
				reg1 = uniform!uint;
			break;
			case BrainOp.RANDI_2:
				reg2 = uniform!uint;
			break;
			
			case BrainOp.STOREB:
				sig.set( cast(ubyte)reg3 );
			break;
			case BrainOp.LOADB_1:
				reg1 = sig.getByte;
			break;
			case BrainOp.LOADB_2:
				reg2 = sig.getByte;
			break;
			
			case BrainOp.STOREI:
				sig.set( reg3 );
			break;
			case BrainOp.LOADI_1:
				reg1 = sig.getInt;
			break;
			case BrainOp.LOADI_2:
				reg2 = sig.getInt;
			break;
			
			case BrainOp.PUSHB:
				sig.push( cast(ubyte)reg3 );
			break;
			case BrainOp.POPB_1:
				reg1 = sig.popByte;
			break;
			case BrainOp.POPB_2:
				reg2 = sig.popByte;
			break;
			
			case BrainOp.ADD:
				reg3 = reg2 + reg1;
			break;
			case BrainOp.SUB:
				reg3 = reg2 - reg1;
			break;
			case BrainOp.MUL:
				reg3 = reg2 * reg1;
			break;
			case BrainOp.DIV:
				reg3 = reg2 / reg1;
			break;
			
			case BrainOp.XOR:
				reg3 = reg2 ^ reg1;
			break;
			case BrainOp.AND:
				reg3 = reg2 & reg1;
			break;
			case BrainOp.OR:
				reg3 = reg2 | reg1;
			break;
			case BrainOp.NOT:
				reg3 = !reg3;
			break;
			
			case BrainOp.SHIFTL_1:
				reg1 <<= reg3;
			break;
			case BrainOp.SHIFTL_2:
				reg2 <<= reg3;
			break;
			case BrainOp.SHIFTR_1:
				reg1 >>>= reg3;
			break;
			case BrainOp.SHIFTR_2:
				reg2 >>>= reg3;
			break;
			
			case BrainOp.MOD:
				reg3 = reg2 % reg1;
			break;
			case BrainOp.POW:
				reg3 = reg1^^reg2;
			break;
			
			case BrainOp.ESCAPE:
				// TODO
			break;
			
			case BrainOp.REMEMBER:
				
			break;
			case BrainOp.RECALL:
				
			break;
			}
		}
	}


	final class IfNode : INode {
	public:
		void process(Signal st) {}
	}

	final class ForNode : INode {
	public:
		void process(Signal st) {}
	}

	
public:
	void doStuff() {
		
	}
}
