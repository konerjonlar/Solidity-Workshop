// SPDX-License-Identifier: MIT

pragma solidity >=0.8.2 <0.9.0;

interface IAction{
    function iAmReady() external pure returns(string memory); 
}

abstract contract Whois {
    // Function to get the name of the contract caller
    function whoAmI() public virtual returns(string memory);

    // Extra method with no specific description
    function extraMethod() public {

    }
}

contract VeliUysal {
    // Function to get the full name
    function getFullName() public pure returns(string memory){
        return "Veli Uysal";
    }
}

contract ParibuHub is IAction, Whois, VeliUysal {

    bool public allowed; 
    uint public count;
    int public signedCount;
    address public owner;
    mapping(address => mapping(address => bool)) public allowance;
    string[] public errorMessages;

    struct Account {
        string name;
        string surname;
        uint256 balance;
    }

    Account account;
    mapping(address => Account) public accountValues;
    Account[3] public admins;
    uint private index;

    constructor(){
        owner = msg.sender;
        errorMessages.push("is not allowed");
        errorMessages.push("only owner");
        errorMessages.push("placeholder");
    }

    // Function to get the size of errorMessages array
    function getSizeOfErrorMessages() public view returns(uint256){
        return errorMessages.length;
    }
    
    // Function to set the allowed state
    function setAllowed(bool _allowed) public {
        allowed = _allowed;
    } 

    // Modifier to check if the caller is allowed
    modifier isAllowed() {
        require(allowance[owner][msg.sender], errorMessages[0]);
        _;
    }   

    // Modifier to check if the caller is the owner
    modifier onlyOwner(){
        require(owner == msg.sender, errorMessages[1]);
        _;
    }

    // Function to increment 'count' by 1
    function oneIncrement() public {
        ++count;
    }

    // Function to increment 'count' by a specified amount, requires caller to be allowed
    function increment(uint _increment) public isAllowed {
        count = count + _increment;
    }

    // Function to increment 'signedCount' by a specified amount
    function signedIncrement(int _increment) public {
        signedCount = signedCount + _increment;
    }

    // Function to assign allowance to an address, requires caller to be the owner
    function assignAllowance(address _address) public onlyOwner {
        allowance[owner][_address] = true;
    }

    // Function to assign values to the 'account' struct
    function assignValue(string memory _name, string memory _surname, uint256 _balance) public {
        account.name = _name;
        account.surname = _surname;
        account.balance = _balance;
    }

    // Function to assign values to the 'account' struct using another 'Account' struct
    function assignValue2(Account memory _account) public {
        account = _account;
    }

    // Function to get the 'account' struct
    function getAccount() public view returns(Account memory){
        Account memory _account = account;
        return _account;
    }

    // Function to assign values to the 'accountValues' mapping
    function assingAddressValues(Account memory _account) public {
        accountValues[msg.sender] = _account;
    }

    // Function to add an admin to the 'admins' array
    function addAdmin(Account memory admin) public {
       require(index < 3, "Has no slot");
        admins[index++] = admin;
    }

    // Function to get all admins in the 'admins' array
    function getAllAdmins() public view returns (Account[] memory) {
        Account[] memory _admins = new Account[](admins.length);
        for (uint i = 0; i < admins.length; i++) {
            _admins[i] = admins[i];
        }
        return _admins;
    }

    // Implementation of the 'iAmReady' function from the 'IAction' interface
    function iAmReady() external pure returns(string memory){
        return "I am ready!";
    }

    // Implementation of the 'whoAmI' function from the 'Whois' contract
    function whoAmI() public override pure returns(string memory){
        return "0xVeliUysal";
    }
}
