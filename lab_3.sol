// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;
contract tipJar {
    uint tipAmount;
    address public owner;
    modifier nonZeroValue() { 
        if (!(msg.value > 0)) revert();
     _; }
    modifier isOwner() {
        require (msg.sender == owner, "you are not owner");
        _;
    }
    event transferOwner(address indexed oldOwner, address indexed newOwner);
    constructor(){
        owner = msg.sender;
        emit transferOwner(address(0), owner);
    }
    function transferOwneship(address newOwner) public isOwner{
        emit transferOwner(owner, newOwner);
        owner = newOwner;
    }
    function tip(uint _tipAmount) public payable nonZeroValue{
        require(msg.value==_tipAmount);
        tipAmount=_tipAmount;
    }
    function withdraw() public isOwner{
        
     payable(owner).transfer(tipAmount);

    }
    function balance() public view returns (uint){
        return address(this).balance;
    }


}