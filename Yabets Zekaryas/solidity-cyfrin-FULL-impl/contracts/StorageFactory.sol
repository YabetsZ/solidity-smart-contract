// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

import "./SimpleStorage.sol";

contract StorageFactory {

    SimpleStorage[] public simpleStorage;

    function createStorageContract() public {
        SimpleStorage simpleStore = new SimpleStorage();
        simpleStorage.push(simpleStore);
    }

    function generateFavNumber(uint256 _storageIndex, uint256 _favNumber) public {
        simpleStorage[_storageIndex].store(_favNumber);
    }

    function retrieveFavNumber(uint256 _storageIndex) public view returns (uint256) {
        return simpleStorage[_storageIndex].retrieve();
    }

}