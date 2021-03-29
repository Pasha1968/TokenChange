pragma solidity ^0.5.0;

import "./DappToken.sol";
import "./DaiToken.sol";

contract TokenFarm
{
	string public name = "Dapp Token Farm";
    address public owner;
    DappToken public dappToken;
    DaiToken public daiToken;

    address[] public stakers;

    mapping(address => uint) public stakingBalance;
    mapping(address => bool) public hasStaked;
    mapping(address => bool) public isStaking;

    constructor(DappToken _dappToken, DaiToken _daiToken) public {
    	dappToken = _dappToken;// кудат сюда можно писать ефир, и чисто говорить юзеру, что он моежт их менять
    	daiToken = _daiToken;
    	owner = msg.sender;

    
    }
    //Deposit 
    function stakeTokens(uint _amount) public{
    	require(_amount > 0, "amount cannot be 0");
    	daiToken.transferFrom(msg.sender,address(this),_amount);	

    	//update stalking balnce
    	stakingBalance[msg.sender] = _amount + stakingBalance[msg.sender];


    	// save new users
    	if(!hasStaked[msg.sender]) {
            stakers.push(msg.sender);
        }

        hasStaked[msg.sender] = true;

    }

    // Withdraw
    function unstakeTokens() public {
        // Fetch  balance
        uint balance = stakingBalance[msg.sender];

        // Require amount greater than 0
        require(balance > 0, "staking balance cannot be 0");

        // Transfer Mock Dai tokens to this contract for staking
        daiToken.transfer(msg.sender, balance);

        // Balance
        stakingBalance[msg.sender] = 0;

        // Update status
        isStaking[msg.sender] = false;
    }
    function issueTokens() public {
    	require(msg.sender == owner, "caller must be the owner");
    	for(uint i=0;i<stakers.length;i++){
    		address recipient = stakers[i];
    		uint balance = stakingBalance[recipient];
    		if (balance > 0){
    			dappToken.transfer(recipient, balance);
    		} 
    	}
    }
    
}