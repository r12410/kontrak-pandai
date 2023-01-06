// contracts/WhiteList.sol
// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

contract Whitelist {
    address public owner;
    constructor(){
        owner = msg.sender;
    }
    error notOwner(string message, address caller);
    modifier onlyOwner() {
        if(msg.sender != owner){
            revert notOwner("you are not the owner", msg.sender);
        }
        _;
    }

    mapping(address => bool) internal isWhitelisted;

//add or remove users, onlyOwner
    function addUses(address _newUser) external onlyOwner {
        isWhitelisted[_newUser] = true;
    }
    function removeUser(address _newUser) external onlyOwner {
        isWhitelisted[_newUser] = true;
    }

//check status, public
    function check() external view returns(string memory) {
        if(isWhitelisted[msg.sender] == true) {
            return "you are a member my friend";
        } else {
            return "oops.. you are not a member my friend";
        }
    }
//special function, only members
    modifier onlyMembers(){
        require(isWhitelisted[msg.sender] == true, "you re not a member");
        _;
    }
    function special() external view onlyMembers returns(string memory) {
        return "very special password is: apple";
    }
}