pragma solidity ^0.4.19;

contract UserData {
    struct User {
        address account;
        string name;
        uint item1;
        uint item2;
        uint item3;
        uint score;
    }
    User[] public user;
    
    mapping (address => uint) addressToId;
    
    // admin info
    // address adminAddress = 0x6b1e0b9e3a7c195786880ee72c89a7e21ad4ca4e;
    address adminAddress = 0x8060B09A96dBC5e28B4a5d30029B0378F6Ee9307;
    uint id = user.push(User(adminAddress, "alexander3rd", 1, 2, 3, 100)) - 1;
    
    function _getRandomValue() private view returns (uint) {
        // get random value 100000 to 999999
        // only for testing
        return uint(uint256(keccak256(block.timestamp))%900000 + 100000);
    }
    
    // get random item use by 100000-999999 random value
    function _getRandomItem(uint _value) private view returns (uint){
        uint randomItem ;
        if( 1 <= _value && _value <= 24){
            randomItem = 1;
        }else if (25 <= _value && _value <= 49){
            randomItem = 2;
        }else if (50 <= _value && _value <= 74){
            randomItem = 3;
        }else if (75 <= _value && _value <= 99){
            randomItem = 4;
        }

        return randomItem;
    }
    
    // choose random value for each item 
    function _chooseValueForItem() public {
        // if get 123456, select '12' '34' '56'
        uint temp1 = (_getRandomValue() / 10000);
        uint temp2 = (_getRandomValue() / 100) % 100;
        uint temp3 = (_getRandomValue() % 100);
        uint randomItem1 = _getRandomItem(temp1);
        uint randomItem2 = _getRandomItem(temp2);
        uint randomItem3 = _getRandomItem(temp3);
        
        user[addressToId[msg.sender]].item1 = randomItem1;
        user[addressToId[msg.sender]].item2 = randomItem2;
        user[addressToId[msg.sender]].item3 = randomItem3;
    }
    
    function insertCoin() public {
        user.push(User(msg.sender, "alexander3rd", 0, 0, 0, 0)) - 1;
        _chooseValueForItem();
    }
    
    function getItem() public view returns (uint, uint, uint){
        // get random value 100000 to 999999
        return (user[addressToId[msg.sender]].item1, user[addressToId[msg.sender]].item2, user[addressToId[msg.sender]].item3);
    }
}