module signal;

import exceptions;

class Signal {
private:
	size_t bPos;
	size_t iPos;
	ubyte[] bData;
	uint[] iData;
	
public:
	void setData(ubyte[] bData, uint[] iData) {
		bPos = 0;
		iPos = 0;
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
		bData.length = bData.length - 1;
		return ret;
	}
	
	ubyte popInt() {
		if (bData.length == 0) throw new Misfire();
		
		ubyte ret = bData[$-1];
		bData.length = bData.length - 1;
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
}
