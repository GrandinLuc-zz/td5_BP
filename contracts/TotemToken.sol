pragma solidity ^0.6.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/math/SafeMath.sol";
import "@openzeppelin/contracts/access/Ownable.sol";


contract TotemToken is ERC20, Ownable {
    
    using SafeMath for uint;

    string private _name;
    string private _ticker;
    uint8 private _decimals;

    uint256 public totalIssuedToken;

    mapping(address => uint8) public phase;
    uint256 public count;
    mapping(uint8 => uint256) public tokenIssued;

    event Airdrop(address user, uint256 amount_);

    constructor(
        uint8 decimals_,
        uint256 amount_
    ) public ERC20("Totem", "TOT") Ownable() {
        _setupDecimals(decimals_);
        _mint(msg.sender, amount_);
        count = 0;
        totalIssuedToken = 0;
    }

    // Default phase is 0 which doesn't allow you to buy the token
    modifier allowUsers(address recipient_) {
        require(phase[recipient_] > 0, "Not allowed to buy this token");
        _;
    }


    // Different levels of distribution from 1 to 3
    function setPhase(address recipient_) public onlyOwner {
        if (count < 10) {
        phase[recipient_] = 1;
        }
        else if (count < 100) {
            phase[recipient_] = 2;
        }
        else {
            phase[recipient_] = 3;
        }
        count += 1;
    }

    function _getToken(uint256 amount_) internal allowUsers(msg.sender) returns(uint256) {
        SafeMath.add(totalIssuedToken, amount_);
        if (phase[msg.sender] == 1) {

            transferFrom(owner(), msg.sender, 5000*amount_);
            SafeMath.add(tokenIssued[1], 5000*amount_);
            
        }
        else if (phase[msg.sender] == 2) {
            transferFrom(owner(), msg.sender, 2000*amount_);
            SafeMath.add(tokenIssued[2], 20000*amount_);
            SafeMath.add(totalIssuedToken, 2000*amount_);
        }
        else if (phase[msg.sender] == 3) {
            transferFrom(owner(), msg.sender, 1000*amount_);
            SafeMath.add(tokenIssued[3], 1000*amount_);
            SafeMath.add(totalIssuedToken, 1000*amount_);
        }
    }

    function airdrop(address payable recipient_, uint256 amount_) public payable onlyOwner {
        _mint(recipient_, amount_);
        emit Airdrop(recipient_, amount_);
    }

    receive () external payable {
        _getToken(msg.value);
    }

}