// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

import "remix_tests.sol";
import "../contracts/AddFiveStorage.sol";
import "../contracts/FallbackExample.sol";
import "../contracts/FundMe.sol";
import "../contracts/MockV3Aggregator.sol";
import "../contracts/SimpleStorage.sol";
import "../contracts/StorageFactory.sol";

contract CurrentContractsTest {
    function testSimpleStorageStoresAndReads() public returns (bool) {
        SimpleStorage simpleStorage = new SimpleStorage();
        simpleStorage.store(123);

        Assert.equal(simpleStorage.retrieve(), uint256(123), "stored number should match");

        simpleStorage.addPerson("Alice", 7);
        Assert.equal(simpleStorage.nameToFavoriteNumber("Alice"), uint256(7), "mapping should store the favorite number");

        return true;
    }

    function testAddFiveStorageAddsFive() public returns (bool) {
        AddFiveStorage addFiveStorage = new AddFiveStorage();
        addFiveStorage.store(10);

        Assert.equal(addFiveStorage.retrieve(), uint256(15), "store() should add five before saving");

        return true;
    }

    function testStorageFactoryCreatesAndUpdatesChildContract() public returns (bool) {
        StorageFactory factory = new StorageFactory();
        factory.createStorageContract();
        factory.generateFavNumber(0, 42);

        Assert.equal(factory.retrieveFavNumber(0), uint256(42), "factory should read the child contract value");

        return true;
    }

    function testFallbackExampleHandlesReceiveAndFallback() public returns (bool) {
        FallbackExample fallbackExample = new FallbackExample();

        (bool receiveSuccess, ) = address(fallbackExample).call{value: 1 wei}("");
        Assert.ok(receiveSuccess, "receive() call should succeed");
        Assert.equal(fallbackExample.result(), uint256(1), "receive() should set result to 1");

        (bool fallbackSuccess, ) = address(fallbackExample).call{value: 1 wei}(hex"1234");
        Assert.ok(fallbackSuccess, "fallback() call should succeed");
        Assert.equal(fallbackExample.result(), uint256(2), "fallback() should set result to 2");

        return true;
    }

    function testFundMeFundingAndWithdraw() public returns (bool) {
        MockV3Aggregator mockPriceFeed = new MockV3Aggregator(8, 2000e8);
        FundMe fundMe = new FundMe(address(mockPriceFeed));

        Assert.equal(fundMe.i_owner(), address(this), "deployer should be the owner");

        fundMe.fund{value: 1e17}();
        Assert.equal(address(fundMe).balance, uint256(1e17), "funded balance should be tracked");
        Assert.equal(fundMe.addressToAmountFunded(address(this)), uint256(1e17), "funder balance should be recorded");

        fundMe.withdraw();
        Assert.equal(address(fundMe).balance, uint256(0), "withdraw() should empty the contract balance");

        return true;
    }
}