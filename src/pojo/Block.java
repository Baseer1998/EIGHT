package com.voidmain.pojo;

import java.util.Arrays;

public class Block {
	
	private int blockId;
	private int previousHash;
	private String data;
	private int hash;
	
	public Block(){
	}
	
	public Block(String data, int previousHash) {
		this.data = data;
		this.previousHash = previousHash;
		this.hash  = Arrays.hashCode(new Integer[]{data.hashCode(), previousHash});
	}

	public int getPreviousHash() {
		return previousHash;
	}

	public void setPreviousHash(int previousHash) {
		this.previousHash = previousHash;
	}

	public String getData() {
		return data;
	}

	public void setData(String data) {
		this.data = data;
	}

	public int getHash() {
		return hash;
	}

	public void setHash(int hash) {
		this.hash = hash;
	}

	public int getBlockId() {
		return blockId;
	}

	public void setBlockId(int blockId) {
		this.blockId = blockId;
	}

	@Override
	public String toString() {
		return "Block [blockId=" + blockId + ", previousHash=" + previousHash
				+ ", data=" + data + ", hash=" + hash + "]";
	}
}
