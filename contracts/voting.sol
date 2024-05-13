// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract voting {
  struct Candidate {
    uint id;
    string name;
    uint voteCount;
  }

  struct Voter {
    bool voted; // true when voter has voted
    bool validated; //true when voter has registered
  }

  //array of Voter
  mapping(address => Voter) public voters;
//  voters[0x5B38Da6a701c568545dCfcB03FcB875f56beddC4].voted = false
//  voters[0x5B38Da6a701c568545dCfcB03FcB875f56beddC4].validated = false

  mapping(uint => Candidate) public candidates;
  //candidates[1].id = 1;
  //candidates[1].name = "Charles"
  //candidates[1].voteCount = 0

  uint public candCounter;
  uint public voterCounter;

  constructor() {
    addCandidate("Contestant 1"); //testing
    addCandidate("Contestant 2"); //testing
  }

  event votedEvent(uint indexed _candId);
  event registrationSuccess(address _voterAddr);

//rules: voter belum terdaftar
  modifier voterMustNotExist(address _voter) {
    require(!voters[_voter].validated, "voter already registered");
    _;
  }

  modifier voterMustExist(address _voter) {
    require(voters[_voter].validated,"voter not registered in the system");
    _;
  }

  modifier voteReq(address _voter, uint _candId) {
    //require a registered and valid voters
    require(voters[_voter].validated, "Voter not registered");
    
    //require voters haven't voted before
    require(!voters[_voter].voted, "Voter already voted");
    
    //vote a valid candidate
    require(_candId > 0 && _candId <= candCounter, "Candidate ID not valid");
    _;
  }

  function addCandidate (string memory _name) private {
    candCounter++;
    candidates[candCounter] = Candidate(candCounter,_name,0);
    //candidates[1]
  }

  function registerVoter(address addr) public voterMustNotExist(addr) {
    voterCounter++;
    voters[addr] = Voter(false,true);

    emit registrationSuccess(addr);
  }

  function getVoter(address _voter) public voterMustExist(_voter) view returns(bool) {
    //check voter is registered before
    if (_voter == _voter && voters[_voter].validated) {
      return(true);
    } else {
      return(false);
    }
  }

  function vote (uint _candId) public voteReq(msg.sender, _candId) {
    
    voters[msg.sender].voted = true;
    candidates[_candId].voteCount++;

    emit votedEvent(_candId);
  }
}