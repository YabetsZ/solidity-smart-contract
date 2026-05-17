# Fund Me Smart Contract

## Overview

This project contains a crowdfunding-style Solidity contract that accepts ETH contributions, tracks how much each wallet has funded, and lets the owner withdraw the collected balance. It also includes a `PriceConverter` library that checks the ETH/USD value using a Chainlink price feed so the contract can enforce a minimum USD contribution.

There are two variants in this folder:

- `FundMe.sol` for the standard Remix workflow
- `zkSyncContract/FundMezkSync.sol` for the zkSync deployment workflow

## What the Contract Teaches

- State variables and persistence on chain
- Mappings and dynamic arrays
- Custom errors and modifiers
- Libraries with `using for`
- Chainlink price feed integration
- `payable` functions, `receive`, and `fallback`
- Secure owner-only withdrawals

## Files In This Project

### `FundMe.sol`

Main crowdfunding contract.

### `PriceConverter.sol`

Library used by `FundMe` to convert ETH to USD using a price feed.

### `zkSyncContract/FundMezkSync.sol`

Alternative version configured for zkSync with a different compiler target and price feed address.

## Contract Components

### `PriceConverter` Library

#### `getPrice()`

- Returns the current ETH price in USD scaled to 18 decimals
- Reads the latest price from the configured Chainlink price feed
- Internal and view only

#### `getConversionRate(uint256 ethAmount)`

- Converts an ETH amount into its USD value
- Uses `getPrice()` and normalizes the result to 18 decimals
- Internal and view only

### `FundMe` Contract

#### State Variables

- `mapping(address => uint256) public addressToAmountFunded`
  - Stores how much each wallet has contributed
  - Public, so Solidity creates a getter automatically
- `address[] public funders`
  - Stores every wallet that has funded the contract
  - Public, so Solidity creates a getter for indexed access
- `address public i_owner`
  - Stores the contract deployer
  - Used to restrict withdrawals
- `uint256 public constant MINIMUM_USD = 5 * 10 ** 18`
  - Minimum contribution required in USD terms
  - The value is scaled to 18 decimals

#### Custom Error

- `NotOwner()`
  - Thrown when a non-owner tries to call `withdraw()`
  - Cheaper than a long revert string

#### Constructor

- Sets `i_owner` to `msg.sender`
- Establishes the deployer as the only withdrawal owner

#### Modifier

- `onlyOwner`
  - Prevents unauthorized withdrawal
  - Reverts with `NotOwner()` if the caller is not the owner

#### Functions

##### `fund()`

- Visibility: public
- Mutability: payable
- Purpose: accepts ETH contributions
- Behavior:
  - Converts `msg.value` to USD using `PriceConverter`
  - Requires the contribution to meet `MINIMUM_USD`
  - Adds the sender’s address to `funders`
  - Increases the sender’s funded total in `addressToAmountFunded`

##### `getVersion()`

- Visibility: public
- Mutability: view
- Purpose: returns the Chainlink price feed version
- Useful for checking the feed connection in Remix

##### `withdraw()`

- Visibility: public
- Mutability: state-modifying
- Restricted by `onlyOwner`
- Purpose: sends the full contract balance to the owner
- Behavior:
  - Iterates through `funders`
  - Resets each funder’s stored contribution to zero
  - Clears the `funders` array
  - Uses `.call{value: ...}("")` to transfer the balance

##### `receive()`

- Visibility: external
- Mutability: payable
- Purpose: handles plain ETH transfers with empty calldata
- Internally calls `fund()` so direct transfers are treated as funding

##### `fallback()`

- Visibility: external
- Mutability: payable
- Purpose: handles calls with unmatched function selectors or non-empty calldata
- Internally calls `fund()` so unexpected ETH transfers still count as funding

## zkSync Version

The `zkSyncContract/FundMezkSync.sol` file contains the same core behavior with a zkSync-oriented setup.

### Differences to note

- Uses `pragma solidity ^0.8.24`
- Uses a different ETH/USD feed address in `PriceConverter`
- Is meant to be compiled and deployed with the zkSync workflow in Remix

## How The Data Works

### `addressToAmountFunded`

This mapping lets the contract answer questions like: how much has a given wallet funded so far?

### `funders`

This array records the order of contributors. It is used during withdrawal to clear stored balances before the contract balance is sent out.

### Why Both Mapping and Array Exist

- The mapping makes lookup fast for a single address
- The array makes it possible to iterate through every funder during `withdraw()`

## Running The Contract In Remix

### Standard Version

1. Open Remix IDE
2. Create or open `FundMe.sol` and `PriceConverter.sol`
3. Make sure the compiler version is set to a compatible Solidity 0.8.x version, ideally `0.8.18`
4. Compile both files
5. Deploy `FundMe`
6. Send ETH through `fund()` using an amount that meets the minimum USD requirement
7. Call `getVersion()` to confirm the price feed connection
8. Call `withdraw()` from the owner account to collect the funds

### zkSync Version

1. Open Remix IDE
2. Place `FundMezkSync.sol` inside a folder named `contracts`
3. Switch to the zkSync plugin workflow in Remix
4. Set the compiler to a compatible `0.8.24` version
5. Compile the contract
6. Deploy through the zkSync flow
7. Fund the contract and test withdrawal from the owner account

## Example Workflow

### Standard Contract

1. Deploy `FundMe`
2. Call `fund()` with enough ETH to satisfy the USD minimum
3. Check `addressToAmountFunded(yourAddress)` to confirm the contribution was recorded
4. Inspect `funders(0)` if you are the first contributor
5. Call `getVersion()` to see the feed version
6. Call `withdraw()` from the deployer account
7. Confirm the contract balance returns to zero

### zkSync Contract

1. Deploy the zkSync version
2. Fund it with a qualifying ETH amount
3. Verify the contribution was stored
4. Withdraw from the owner account

## Important Behavior To Understand

- `fund()` can be triggered directly or indirectly through `receive()` and `fallback()`
- `withdraw()` always clears contributor bookkeeping before moving the balance
- The owner is set once in the constructor and does not change afterward
- The minimum contribution is checked in USD terms, not raw ETH terms
- Public mappings and arrays create automatic getters, but arrays only support indexed reads, not full iteration in the getter

## Notes On The Price Feed

- The contract depends on a Chainlink ETH/USD aggregator address that is hardcoded in the library
- The feed address differs between the standard version and the zkSync version
- The feed returns data in a format that is scaled before conversion to USD math

## Practical Learning Takeaways

1. How to combine a contract with a library
2. How to store per-user contribution data on chain
3. Why owner-only withdrawal logic matters
4. How to enforce a contribution minimum using a price feed
5. How `receive()` and `fallback()` make a contract more flexible when receiving ETH
