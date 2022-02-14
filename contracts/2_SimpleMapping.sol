// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.6.0;

contract SimpleMappingExample
{
    mapping(uint => bool) public myMapping;
    mapping(address => bool) public myAddressMapping;

    function setValue(uint _index) public 
    {
        myMapping[_index] = true;
    }

    // Useful for whitelisting an address
    function setMyAddressToTrue() public
    {
        // msg.sender is a global var
        myAddressMapping[msg.sender] = true;
    }

    // Like having this function --> mapping automatically provides a getter
    // function myMapping(uint index) returns (bool)
    // {
    //     return myMapping[index];
    // }

    mapping (uint => mapping(uint => bool)) uintUintBoolMapping;

    function get_uintUintBoolMapping(uint _index1, uint _index2) public view returns (bool)
    {
        return uintUintBoolMapping[_index1][_index2];
    }

    function set_uintUintBoolMapping(uint _index1, uint _index2) public    
    {
        uintUintBoolMapping[_index1][_index2] = true;
    }
}