// SPDX-License-Identifier: MIT
pragma solidity >=0.8.10 <=0.8.11;

/** MEAT */
contract Meat {
    string private meatId;
    string private meatType;

    // Constructor
    constructor(string memory _meatId, string memory _meatType) {
        meatId = _meatId;
        meatType = _meatType;
    }

    // Setter
    function setId(string memory _meatId) public { meatId = _meatId; }
    function setType(string memory _meatType) public { meatType = _meatType; }

    // Getter
    function getMeatId() public view returns (string memory) { return meatId; }
    function getMeatType() public view returns (string memory) { return meatType; }
    // function toString() public view returns (Meat) { return this; }
}

/** SHIPPING LOG */
contract ShippingLog {
    string private meatId;
    string private containerId;
    uint256 private timestamp;

    constructor(string memory _meatId, string memory _containerId) {
        meatId = _meatId;
        containerId = _containerId;
        timestamp = block.timestamp;
    }

    // Setter
    function setMeatId(string memory _meatId) public { meatId = _meatId; }
    function setContainerId(string memory _containerId) public { containerId = _containerId; }
    function setTimestamp(uint256 _timestamp) public { timestamp = _timestamp; }

    // Getter
    function getMeatId() public view returns (string memory) { return meatId; }
    function getContainerId() public view returns (string memory) { return containerId; }
    function getTimestamp() public view returns (uint256) { return timestamp; }
}

/** CONTAINER */
contract Container {
    string private containerId;
    string private deviceId;
    string private location;

    // Constructor
    constructor(string memory _containerId, string memory _deviceId, string memory _location) {
        containerId = _containerId;
        deviceId = _deviceId;
        location = _location;
    }

    // Setter
    function setContainerId(string memory _containerId) public { containerId = _containerId; }
    function setDeviceId(string memory _deviceId) public { deviceId = _deviceId; }
    function setLocation(string memory _location) public { location = _location; }

    // Getter
    function getContainerId() public view returns (string memory) { return containerId; }
    function getDeviceId() public view returns (string memory) { return deviceId; }
    function getLocation() public view returns (string memory) { return location; }
}

/** TEMPERATURE */
contract Temperature {
    string private tempValue;
    string private deviceId;
    uint256 private timestamp;

    // Constructor
    constructor(string memory _tempValue, string memory _deviceId) {
        tempValue = _tempValue;
        deviceId = _deviceId;
        timestamp = block.timestamp;
    }

    // Setter
    function setTempValue(string memory _tempValue) public { tempValue = _tempValue; }
    function setDeviceId(string memory _deviceId) public { deviceId = _deviceId; }
    function setTimestamp(uint256 _timestamp) public { timestamp = _timestamp; }

    // Getter
    function getTempValue() public view returns (string memory) { return tempValue; }
    function getDeviceId() public view returns (string memory) { return deviceId; }
    function getTimestamp() public view returns (uint256) { return timestamp; }
}
