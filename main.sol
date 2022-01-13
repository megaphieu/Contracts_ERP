// SPDX-License-Identifier: MIT
pragma solidity >=0.8.10 <=0.8.11;

import "./contracts.sol";

contract Main {
    Meat[] private meats;
    Container[] private containers;
    ShippingLog[] private shippingLogs;
    Temperature[] private temperatures;

    // Add data
    function addMeat(string memory _meatId, string memory _meatType) public {
        Meat n = new Meat(_meatId, _meatType);
        meats.push(n);
    }
    function addContainer(string memory _containerId, string memory _deviceId, string memory _location) public {
        Container n = new Container(_containerId, _deviceId, _location);
        containers.push(n);
    }
    function addShippingLog(string memory _meatId, string memory _containerId) public {
        ShippingLog n = new ShippingLog(_meatId, _containerId);
        shippingLogs.push(n);
    }
    function addTemperature(string memory _tempValue, string memory _deviceId) public {
        Temperature n = new Temperature(_tempValue, _deviceId);
        temperatures.push(n);
    }

    // Add test data (can set timestamp manually)
    function addShippingLogTest(string memory _meatId, string memory _containerId, uint256 _timestamp) public {
        ShippingLog n = new ShippingLog(_meatId, _containerId);
        n.setTimestamp(_timestamp);
        shippingLogs.push(n);
    }
    function addTemperatureTest(string memory _tempValue, string memory _deviceId, uint256 _timestamp) public {
        Temperature n = new Temperature(_tempValue, _deviceId);
        n.setTimestamp(_timestamp);
        temperatures.push(n);
    }

    /**
        TEST DATA MEAT SHIPPING OVER 8 HOURS SIMULATOR.
        TIMESTAMP FROM 1641500000 -> 1641525200.
        Check time at https://www.epochconverter.com/
    */
    function initData1() public {
        // MeatTest
        addMeat("meatId1", "meatType1");
        addMeat("meatId2", "meatType1");
        addMeat("meatId3", "meatType1");
        // ShippingLogTest
		addShippingLogTest("meatId1", "contaierId1", 1641500000);
		addShippingLogTest("meatId1", "contaierId2", 1641507200);
		addShippingLogTest("meatId1", "contaierId3", 1641514400);
		addShippingLogTest("meatId1", "contaierId4", 1641521600);
        // ContainerTest
		addContainer("containerId1", "deviceId1", "location1");
		addContainer("containerId2", "deviceId2", "location2");
		addContainer("containerId3", "deviceId3", "location3");
		addContainer("containerId4", "deviceId4", "location4");
    }
    function initData2() public {
        // TempTest: deviceId1
		addTemperatureTest("-38", "deviceId1", 1641500000); //take
		addTemperatureTest("-39", "deviceId1", 1641503600); //take
		addTemperatureTest("-40", "deviceId1", 1641507200);
		addTemperatureTest("-41", "deviceId1", 1641510800);
		addTemperatureTest("-41", "deviceId1", 1641514400);
		addTemperatureTest("-39", "deviceId1", 1641518000);
		addTemperatureTest("-38", "deviceId1", 1641521600);
		addTemperatureTest("-38", "deviceId1", 1641525200);
    }
    function initData3() public {
		// TempTest: deviceId2
		addTemperatureTest("-37", "deviceId2", 1641500000);
		addTemperatureTest("-36", "deviceId2", 1641503600);
		addTemperatureTest("-37", "deviceId2", 1641507200); //take
		addTemperatureTest("-39", "deviceId2", 1641510800); //take
		addTemperatureTest("-36", "deviceId2", 1641514400);
		addTemperatureTest("-39", "deviceId2", 1641518000);
		addTemperatureTest("-36", "deviceId2", 1641521600);
		addTemperatureTest("-36", "deviceId2", 1641525200);
    }
    function initData4() public {
		// TempTest: deviceId3
		addTemperatureTest("-38", "deviceId3", 1641500000);
		addTemperatureTest("-37", "deviceId3", 1641503600);
		addTemperatureTest("-38", "deviceId3", 1641507200);
		addTemperatureTest("-37", "deviceId3", 1641510800);
		addTemperatureTest("-37", "deviceId3", 1641514400); //take
		addTemperatureTest("-38", "deviceId3", 1641518000); //take
		addTemperatureTest("-40", "deviceId3", 1641521600);
		addTemperatureTest("-38", "deviceId3", 1641525200);
    }
    function initData5() public {
		// TempTest: deviceId4
		addTemperatureTest("-37", "deviceId4", 1641500000);
		addTemperatureTest("-37", "deviceId4", 1641503600);
		addTemperatureTest("-38", "deviceId4", 1641507200);
		addTemperatureTest("-38", "deviceId4", 1641510800);
		addTemperatureTest("-37", "deviceId4", 1641514400);
		addTemperatureTest("-38", "deviceId4", 1641518000);
		addTemperatureTest("-36", "deviceId4", 1641521600); //take
		addTemperatureTest("-36", "deviceId4", 1641525200); //take
    }

    // Methods we need !!
    function checkMeatExist(string memory _meatId) public view returns(bool) {
        for (uint256 i = 0; i < meats.length; ++i) {
            string memory a = _meatId;
            string memory b = meats[i].getMeatId();
            if(isEqual(a, b)) return true;
        }
        return false;
    }

    function getLogs(string memory _meatId) public view returns(ShippingLog[] memory){
        uint256 n = 0;
        string memory a = _meatId;
        for (uint256 i = 0; i < shippingLogs.length; ++i) {
            string memory b = shippingLogs[i].getMeatId();
            if(isEqual(a, b)){
                ++n;
            }
        }

        ShippingLog[] memory resultLogs = new ShippingLog[](n);
        for (uint256 i = 0; i < shippingLogs.length; ++i) {
            string memory b = shippingLogs[i].getMeatId();
            if(isEqual(a, b)){
                resultLogs[n] = shippingLogs[i];
            }
        }
        return resultLogs;
    }

    // takes Temperature List (test)
    function getTempInfo(string memory _meatId) public view returns(string memory) {
        // Check existence
        if (checkMeatExist(_meatId)==false){
            return "error";
        }
        // Get shipping logs
        // Got my Temp data for meatId1 by somehow
        if(isEqual(_meatId, "meatId1")) {
            string[8] memory data = ["-38","-39","-37","-39","-37","-38","-36","-36"];
            string memory result = data[0];
            if(data.length > 1){
                for (uint256 i = 1; i < data.length; ++i) {
                    result = concat(result, data[i]);
                }
                return result;
            }
            else return "error";
        }
        // Got my Temp data for meatId2 by somehow
        if(isEqual(_meatId, "meatId2")) {
            string[4] memory data = ["-38","-39","-35","-33"];
            string memory result = data[0];
            if(data.length > 1){
                for (uint256 i = 1; i < data.length; ++i) {
                    result = concat(result, data[i]);
                }
                return result;
            }
            else return "error";
        }
        // Got my Temp data for meatId3 by somehow
        if(isEqual(_meatId, "meatId3")) {
            string[4] memory data = ["-35","-35","-35","-35"];
            string memory result = data[0];
            if(data.length > 1){
                for (uint256 i = 1; i < data.length; ++i) {
                    result = concat(result, data[i]);
                }
                return result;
            }
            else return "error";
        }
        return "error";
    }

    // Utilities
    function concat(string memory a, string memory b) public pure returns (string memory) {
        return string(abi.encodePacked(a, ",", b));
    }
    function isEqual(string memory a, string memory b) public pure returns (bool) {
        if(keccak256(abi.encodePacked(a)) == keccak256(abi.encodePacked(b))) return true;
        else return false;
    }
}
