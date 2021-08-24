// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/Pausable.sol";




// Name: Zaeem Tariq
// Assignment 3b
// Roll.No: PIAIC79218

contract ASSGNMT_ERC20 is ERC20,Ownable,Pausable{
    using SafeMath for uint;
    uint public cap;
    uint currentDate;
    uint256 public curentTime;
    uint256 public timelimit;
    constructor() ERC20("DemoToken","er20"){
        uint InitialSupply = 10000 * ( 10 ** uint(decimals()));
        cap = InitialSupply.mul(2);
        _mint(msg.sender, InitialSupply);
        curentTime = block.timestamp; 
        timelimit = 0;
    }
    
    function generateToken(address account,uint amount) public whenNotPaused onlyOwner{
        require(curentTime > timelimit, "You can not Transfer Token util time exceeds.");
        require(account != address(0),"INVALID ADDRESS");
        require(amount >0, "Enter amount");
        require(totalSupply().add(amount) < cap, "OverFlow");
        _mint(account,amount);
    }
    
    function startTran() public whenPaused onlyOwner{
        _unpause();
    }
    
    function stopTran() public whenNotPaused onlyOwner{
        _pause();
    }
    
    function transferTokens(address receiver, uint amount) public{
       // address own = owner();
        transfer(receiver, amount);
    }
    
    //Function for setting time Limit for transaction of tokens
    function setTimeLimitForTransaction(uint256 numOfDays) public onlyOwner{
        timelimit = block.timestamp + (numOfDays * 1 days );
    }
    
}

