pragma solidity ^0.8.0;

contract Voting {
    mapping (string => uint8) public votesReceived;
    string[] public candidateList;

    constructor(string[] memory candidateNames) {
        candidateList = candidateNames;
    }

    function addCandidate(string memory candidate) public {
        candidateList.push(candidate);
    }

    function voteForCandidate(string memory candidate) public {
        require(validCandidate(candidate));
        votesReceived[candidate] += 1;
    }

    function totalVotesFor(string memory candidate) public view returns (uint8) {
        require(validCandidate(candidate));
        return votesReceived[candidate];
    }

    function validCandidate(string memory candidate) public view returns (bool) {
        for(uint i = 0; i < candidateList.length; i++) {
            if (keccak256(bytes(candidateList[i])) == keccak256(bytes(candidate))) {
                return true;
            }
        }
        return false;
    }

    function winningCandidate() public view returns (string memory) {
        string memory winner = candidateList[0];
        uint8 winningVoteCount = votesReceived[winner];

        for(uint i = 1; i < candidateList.length; i++) {
            if (votesReceived[candidateList[i]] > winningVoteCount) {
                winner = candidateList[i];
                winningVoteCount = votesReceived[winner];
            }
        }

        return winner;
    }
}
