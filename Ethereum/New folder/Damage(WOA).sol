pragma solidity ^0.5.8;

contract Damage {
    //state variable
    uint public damageCount;
    mapping(uint => RoadDamage) public reported;


    struct RoadDamage {
        string damType;
        string URL;
        string lat;
        string long;
        string[] date;
        int priority;
        uint damageReportCount;
    }


    //For new Damages to be Reported
    function newDamage(string memory _damTy, string memory _URL, string memory _lat, string memory _long, string memory _date) public {
        damageCount ++;

        reported[damageCount] = RoadDamage(_damTy, _URL, _lat, _long, new string[](0), 0, 1);
        reported[damageCount].date.push(_date);
        reported[damageCount].damageReportCount = 1;
    }

    //For Already Existing Damages
    function append(uint _index, string memory _date) public {
        reported[_index].damageReportCount += 1;
        reported[_index].date.push(_date);

    }

    //For Checking Already Created Damage Thread
    function getDamage(uint _index) public view  returns (string memory, string memory, string memory) {
        if (_index <= damageCount && _index != 0)
        {
            return (reported[_index].damType, reported[_index].lat, reported[_index].long);
        }
        return ("", "", "");
    }

    //Return Image URL
    function getDamageImg(uint _index) public view returns (string memory){
        if (_index <= damageCount && _index != 0)
        {
            return (reported[_index].URL);
        }
        return ("");
    }

    function popFULL(uint _index) public {
        reported[_index].damType = reported[damageCount].damType;
        reported[_index].URL = reported[damageCount].URL;
        reported[_index].lat = reported[damageCount].lat;
        reported[_index].long = reported[damageCount].long;
        reported[_index].date = reported[damageCount].date;
        reported[_index].damageReportCount = reported[damageCount].damageReportCount;

        delete reported[damageCount];

        damageCount -= 1;
    }

    function deleteDamage(uint _index)public returns (bool){
        if (_index <= damageCount && _index != 0)
        {
            popFULL(_index);
            return true;
        }
        return false;
    }
}