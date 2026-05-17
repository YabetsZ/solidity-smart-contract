// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

interface AggregatorV3Interface {
    function latestRoundData()
        external
        view
        returns (
            uint80 roundId,
            int256 answer,
            uint256 startedAt,
            uint256 updatedAt,
            uint80 answeredInRound
        );
}

library PriceConverter {
    function getPrice(address priceFeedAddress) internal view returns (uint256) {
        AggregatorV3Interface priceFeed = AggregatorV3Interface(priceFeedAddress);
        (, int256 answer, , , ) = priceFeed.latestRoundData();
        return uint256(answer * 1e10);
    }

    function getConversionRate(uint256 ethAmount, address priceFeedAddress) internal view returns (uint256) {
        uint256 ethPrice = getPrice(priceFeedAddress);
        return (ethPrice * ethAmount) / 1e18;
    }
}// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

import {AggregatorV3Interface} from "@chainlink/contracts@1.2.0/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";


library PriceConverter{
    function getConversionRate(uint256 _ethAmount) public view returns(uint256){
      //2000000000000000000000  
      uint256 price = getPrice();
      uint256 ethAmountInUsd = (price * _ethAmount) / 1e18;
      return  ethAmountInUsd; 
    }

    function getPrice() private  view returns (uint256){
      AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
       (, int256 answer,,,) = priceFeed.latestRoundData();
       // gives 1 ethereum in USD
       return uint256(answer * 1e10);
    }
}