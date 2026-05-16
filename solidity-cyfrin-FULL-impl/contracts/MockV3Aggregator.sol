// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

import {AggregatorV3Interface} from "./PriceConverter.sol";

contract MockV3Aggregator is AggregatorV3Interface {
    uint8 public immutable decimals;
    int256 private s_answer;

    constructor(uint8 _decimals, int256 _initialAnswer) {
        decimals = _decimals;
        s_answer = _initialAnswer;
    }

    function updateAnswer(int256 newAnswer) external {
        s_answer = newAnswer;
    }

    function latestRoundData()
        external
        view
        override
        returns (
            uint80 roundId,
            int256 answer,
            uint256 startedAt,
            uint256 updatedAt,
            uint80 answeredInRound
        )
    {
        return (0, s_answer, 0, 0, 0);
    }
}