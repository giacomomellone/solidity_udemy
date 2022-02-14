// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

contract MappingStructExample
{
    struct Payment 
    {
        uint amount;
        uint timestamps;
    }

    struct Balance
    {
        uint totalBalance;
        uint numPayments;
        mapping(uint => Payment) payments;
    }

    /// All keys are already initialized
    mapping(address => Balance) public balanceReceived;

    function getBalance() public view returns(uint) 
    {
        return address(this).balance;
    }

    function getAddressBalance(address _address) public view returns(uint) 
    {
        return address(_address).balance;
    }

    function sendMoney() public payable
    {
        balanceReceived[msg.sender].totalBalance += msg.value;

        /// No need of new keyword when creating the object
        Payment memory payment = Payment(msg.value /*amount*/, block.timestamp/*timestamp*/);

        balanceReceived[msg.sender].payments[balanceReceived[msg.sender].numPayments] = payment;
        balanceReceived[msg.sender].numPayments++;
    }

    function withdrawMoney(address payable _to, uint _amount) public 
    {
        require(balanceReceived[msg.sender].totalBalance >= _amount, "Not enough money in the account");

        balanceReceived[msg.sender].totalBalance -= _amount;
        _to.transfer(_amount);
    }

    function withdrawAllMoney(address payable _to) public
    {
        uint balanceToSend = balanceReceived[msg.sender].totalBalance;
        /// Best to set to zero before sending --> re-entrance issue
        balanceReceived[msg.sender].totalBalance = 0;

        /// Interact with the extern only at the end!
        _to.transfer(balanceToSend);
    }
}