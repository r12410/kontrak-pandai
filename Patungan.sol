// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

/*********************************/
/*    Learning Purposes ONLY     */
/*   DO NOT USE IN PRODUCTION    */
/*********************************/

contract Patungan {
    uint256 fundGoal = 10 ether;
    uint256 minContribution = 0.01 ether;

    address payable destinationWallet = payable(0xE670CC07ee986B18e38489deD6987044FF21325c);

    mapping(address => uint256) addressContributions;

    function donate() public payable {
        require(msg.value >= minContribution, "Tidak mencapai target");
        addressContributions[msg.sender] = msg.value;
    }

    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }

    function withdraw() public {
        require(address(this).balance >= fundGoal, "Tidak dapat menarik dana. Target tidak tercapai");
        destinationWallet.transfer(address(this).balance);
    }

    function returnFunds() public {
        require(address(this).balance < fundGoal, "Tidak dapat mengembalikan. Target proyek telah tercapai");
        require(addressContributions[msg.sender] != 0, "Situ belum mengirimkan dukungan");
        uint256 amount = addressContributions[msg.sender];
        payable(msg.sender).transfer(amount);
    }

    // Need to have a fallback function for the contract to be able to receive funds
    receive() external payable {}
}