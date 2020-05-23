package com.voidmain.pojo;

public class BlockChain {
	
	private int blockChainId;
	private int one;
	private int two;
	private int three;

	public int getOne() {
		return one;
	}

	public void setOne(int one) {
		this.one = one;
	}

	public int getTwo() {
		return two;
	}

	public void setTwo(int two) {
		this.two = two;
	}

	public int getThree() {
		return three;
	}

	public void setThree(int three) {
		this.three = three;
	}

	public int getBlockChainId() {
		return blockChainId;
	}

	public void setBlockChainId(int blockChainId) {
		this.blockChainId = blockChainId;
	}

	@Override
	public String toString() {
		return "BlockChain [blockChainId=" + blockChainId + ", one=" + one
				+ ", two=" + two + ", three=" + three + "]";
	}
}
