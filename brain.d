module brain;

import signal;
import ops;

import core.bitop;
import std.random;

final class Brain {
private:
	interface INode {
		INode process();
	}
	
	struct NodeDefinition {
		BrainOp[] ops;
	}
	
	enum Flag : ubyte {
		LESS = 0x1,
		EQUAL = 0x2,
		ZERO = 0x4,
		
		CMP_MASK = 0x3
	}

	INode head;
	INode prev;
	Signal sig;
	
	NodeDefinition[] nodeTypes;
	Memory[ void* ] memories;
	
	uint reg1;
	uint reg2;
	uint reg3;
	
	ubyte flags;
	
	final class ProcessNode : INode {
	private:
		BrainOp[] ops;
		
	public:
		INode next = null;
		
		INode process() {
			for (size_t pos = 0; pos < ops.length; pos++) switch (ops[pos]) {
			case BrainOp.MORPH:
			/*
				foreach (def; nodeTypes) {
					if () {
						
					}
				}
			*/
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
			case BrainOp.RANDI_1:
				reg1 = uniform!uint;
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
			
			case BrainOp.TEST:
				flags = 0;
				if (reg1 < reg2) flags |= Flag.LESS;
				if (reg1 == reg2) flags |= Flag.EQUAL;
				if (reg3 == 0) flags |= Flag.ZERO; 
			break;
			
			case BrainOp.JUMP_EQ:
				if ((flags & Flag.EQUAL) != 0) pos += reg3;
			break;
			case BrainOp.JUMP_NE:
				if ((flags & Flag.EQUAL) == 0) pos += reg3;
			break;
			case BrainOp.JUMP_Z:
				if ((flags & Flag.ZERO) != 0) pos += reg3;
			break;
			case BrainOp.JUMP_NZ:
				if ((flags & Flag.ZERO) == 0) pos += reg3;
			break;
			
			case BrainOp.JUMP_LT:
				if ((flags & Flag.LESS) != 0) pos += reg3;
			break;
			case BrainOp.JUMP_GT:
				if ((flags & Flag.CMP_MASK) == 0) pos += reg3;
			break;
			case BrainOp.JUMP_LTE:
				if ((flags & Flag.CMP_MASK) != 0) pos += reg3;
			break;
			case BrainOp.JUMP_GTE:
				ubyte comp = flags & Flag.CMP_MASK;
				if (comp == 0 || comp == Flag.EQUAL) pos += reg3;
			break;
			
			case BrainOp.MOVEB_L:
				sig.leftByte;
			break;
			case BrainOp.MOVEB_R:
				sig.rightByte;
			break;
			case BrainOp.MOVEI_L:
				sig.leftInt;
			break;
			case BrainOp.MOVEI_R:
				sig.rightInt;
			break;
			
			case BrainOp.ESCAPE:	// Scan for the next ForNode and exit the loop
				INode test = next;
				while (test !is null) {
					if (auto node = cast(ProcessNode)test) {
						test = node.next;
					}
					else if (auto node = cast(ForNode)test) {
						if (node.set) {	// This is a loop that we're in
							node.set = false;	// Clean up
							return node.exunt;
						}
						else {	// This is a loop that we're outside of. Bypass
							test = node.exunt;
						}
					}
					else {	// IfNode
						IfNode node = cast(IfNode)test;
						test = node.left;	// No way to guess which path will be shorter, but eventually the two paths will merge again
					}
				}
			break;
			case BrainOp.REMEMBER:
				Memory* mem = (&this in memories);
				if (mem is null) {
					mem = new Memory;
					sig.toMemory(*mem, reg1, reg2);
					memories[&this] = *mem;
				}
				else {
					sig.fromMemory(*mem, reg1, reg2);
					reg1 = cast(uint)mem.bData.length;
					reg2 = cast(uint)mem.iData.length;
				}
			break;
			
			default:
				reg3 = opConsts[ ops[pos] - BrainOp.CONST_0 ];
			break;
			}
			
			return next;
		}
	}


	final class IfNode : INode {
	public:
		INode left;
		INode right;
		
		INode process() {
			if (popcnt(reg3) < 16) {
				return left;
			}
			else {
				return right;
			}
		}
	}

	final class ForNode : INode {
	public:
		INode exunt;
		INode loop;

		bool set = false;
		uint counter;
		
		INode process() {
			if (!set) {
				set = true;
				counter = reg3;
			}
			
			if (counter == 0) {
				set = false;
				return exunt;
			}
			else {
				counter--;
				return loop;
			}
		}
	}
	
public:
	void process(Signal sig) {
		INode curr = head;
		
		prev = null;
		this.sig = sig;
		
		while (curr !is null) {
			INode next = curr.process();
			prev = curr;
			curr = next;
		}
	}
}
