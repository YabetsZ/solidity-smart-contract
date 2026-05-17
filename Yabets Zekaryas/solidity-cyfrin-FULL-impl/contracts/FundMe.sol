// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

import {PriceConverter} from "./PriceConverter.sol";

error NotOwner();

contract FundMe {
    using PriceConverter for uint256;
    uint256 public constant MINIMUM_USD = 5e18;

    address[] public funders;
    mapping(address => uint256) public addressToAmountFunded;

    address public immutable i_owner;
    address private immutable i_priceFeed;

    constructor(address priceFeed) {
        i_owner = msg.sender;
        i_priceFeed = priceFeed;
    }

    modifier onlyOwner {
        if (msg.sender != i_owner) {
            revert NotOwner();
        }
        _;
    }
    
    function fund() public payable {
        require(msg.value.getConversionRate(i_priceFeed) >= MINIMUM_USD, "Not enough ETH to proceed");
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] += msg.value;
    }

    function withdraw() public onlyOwner {
        for (uint256 funderIndex = 0; funderIndex < funders.length; funderIndex++) {
            addressToAmountFunded[funders[funderIndex]] = 0;
        }

        funders = new address[](0);

        (bool sent, ) = payable(msg.sender).call{value: address(this).balance}("");
        require(sent, "Transaction failed");
    }

    receive() external payable {
        fund();
    }

    fallback() external payable {
        fund();
    }

}