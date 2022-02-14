// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.1;

contract StartStopUpdateExample 
{
    address owner;
    bool public paused = false;

    constructor()
    {
        owner = msg.sender;
    }

    function sendMoney() public payable
    {

    }

    function setPaused(bool _paused) public
    {
        require(msg.sender == owner, "You're not the owner");
        paused = _paused;
    }

    function withdrawAllMoney(address payable _to) public
    {
        require(msg.sender == owner, "You're not the owner");
        require(!paused, "Contract is paused");

        // Transfer all money from this smart contrat to the address _to
        _to.transfer(address(this).balance);
    }

    function destroySmartContract(address payable _to) public
    {
        require(msg.sender == owner, "You're not the owner");

        selfdestruct(_to);
    }
}

