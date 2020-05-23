package com.voidmain.service;

import java.util.List;

import com.voidmain.pojo.Block;

public class BlockChainService {

	public static boolean validate(List<Block> blockChain) {
        boolean result = true;
        Block lastBlock = null;
        for(int i = blockChain.size() -1; i >= 0; i--) {
            if(lastBlock == null) {
                lastBlock = blockChain.get(i);
            }
            else {
                Block current = blockChain.get(i);
                if(lastBlock.getPreviousHash() != current.getHash()) {
                    result = false;
                    break;
                }
                lastBlock = current;
            }
        }
        return result;
    }
}
