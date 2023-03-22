//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract MultiSig{
    address[] public owners;
    uint public noOfVotes;

    struct Transaction{
        address to;
        uint value;
        bool complete;
    }

    mapping(uint => mapping(address=>bool)) private isConfirmed;
    mapping(address => bool) public isOwner;
    Transaction[] public transactions;

    event TransactionSubmitted(uint transactionId, address sender, address receiver, uint amount);
    event TransactionConfirmed(uint transactionId, address owner);
    event TransactionExecuted(uint transactionId);

    constructor(address[] memory _owners,uint _noOfVotes) {
        require(_owners.length > 1 && _noOfVotes > 0 && _noOfVotes <= _owners.length, "No eligible for multi signature wallet");
        for(uint i=0; i < _owners.length; i++){
            require(_owners[i] != address(0), "not a valid address");
            owners.push(_owners[i]);
            isOwner[_owners[i]] = true;
        }
        
        noOfVotes = _noOfVotes;
    }

    function requestTransaction(address _to) public payable returns(uint){
        require(_to != address(0), "not a valid address");
        require(msg.value > 0, "Send some ETH");
        uint transactionId = transactions.length;
        transactions.push(Transaction({to : _to, value: msg.value, complete: false}));
        emit TransactionSubmitted(transactionId, msg.sender, _to, msg.value);
        return(transactionId);
    }
    

    function confirmTransaction(uint _transactionId) external {
        require(isOwner[msg.sender], "Your not the owner");
        require(_transactionId > transactions.length, "wrong id");
        require(!isConfirmed[_transactionId][msg.sender], "you have confirmed the transaction already");
        isConfirmed[_transactionId][msg.sender] = true;
        emit TransactionConfirmed(_transactionId, msg.sender);
        
        if(isTransactionConfirmed(_transactionId)){
            executeTransaction(_transactionId);
        }
    }

    function executeTransaction(uint _transactionId) internal returns(bool) {
        require(_transactionId > transactions.length, "wrong id");
        require(!transactions[_transactionId].complete, "already executed");
        (bool success, ) = transactions[_transactionId].to.call{value: transactions[_transactionId].value}("");
        require(success, "transaction failed");
        emit TransactionExecuted(_transactionId);
        transactions[_transactionId].complete = true;
        return (transactions[_transactionId].complete);

    }

    function isTransactionConfirmed(uint _transactionId) internal view returns(bool){
        require(_transactionId > transactions.length, "wrong id");
        uint confirmationCount;

        for(uint i=0; i < owners.length; i++){
            if(isConfirmed[_transactionId][owners[i]]){
                confirmationCount++;
            }

        }
        return( confirmationCount >= noOfVotes);
    }

}
