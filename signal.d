module signal;

import exceptions;

struct Memory {
	ubyte[] bData;
	uint[] iData;
}

class Signal {
package:
	size_t bPos;
	size_t iPos;
	size_t bStart;
	size_t iStart;
	ubyte[] bData;
	uint[] iData;
	
public:
	void setData(ubyte[] bData, uint[] iData) {
		bPos = 0;
		iPos = 0;
		bStart = bData.length;
		iStart = iData.length;
		this.bData = bData;
		this.iData = iData;
	}
	
	ubyte getByte() {
		return bData[bPos];
	}
	
	uint getInt() {
		return iData[iPos];
	}
	
	void set(ubyte b) {
		bData[bPos] = b;
	}
	
	void set(uint i) {
		iData[iPos] = i;
	}
	
	void push(ubyte b) {
		bData ~= b;
	}
	
	void push(uint i) {
		iData ~= i;
	}
	
	ubyte popByte() {
		if (bData.length == 0) throw new Misfire();
		
		ubyte ret = bData[$-1];
		size_t newLength = bData.length - 1;
		bData.length = newLength;
		if (newLength < bStart) bStart = newLength;
		
		return ret;
	}
	
	uint popInt() {
		if (iData.length == 0) throw new Misfire();
		
		uint ret = iData[$-1];
		size_t newLength = iData.length - 1;
		iData.length = newLength;
		if (newLength < iStart) iStart = newLength;
		
		return ret;
	}
	
	void rightByte() {
		bPos++;
		if (bPos == bData.length) bPos = 0;
	}
	
	void leftByte() {
		if (bPos == 0) {
			bPos = bData.length - 1;
		}
		else {
			bPos--;
		}
	}
	
	void rightInt() {
		iPos++;
		if (iPos == iData.length) iPos = 0;
	}
	
	void leftInt() {
		if (iPos == 0) {
			iPos = iData.length - 1;
		}
		else {
			iPos--;
		}
	}
	
	void fromMemory(Memory mem, size_t bLength, size_t iLength) {
		bData.length -= bLength;
		if (bStart < bData.length) bStart = bData.length;
		
		iData.length -= iLength;
		if (iStart < iData.length) iStart = iData.length;
		
		bData ~= mem.bData;
		iData ~= mem.iData;
	}
	
	void toMemory(Memory mem, size_t bLength, size_t iLength) {
		if (
			bLength > bData.length
			|| iLength > iData.length
		) throw new Misfire();
		
		mem.bData[] = bData[$-bLength .. $];
		mem.iData[] = iData[$-iLength .. $];
	}
}
