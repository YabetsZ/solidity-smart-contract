# solidity-cyfrin-FULL-impl

## Overview

This workspace is a collection of Solidity examples and Remix deployment helpers. It covers simple storage, inheritance, contract factories, fallback behavior, and a funded contract that uses a local price feed abstraction.

## What's Included

### Contracts

- `SimpleStorage.sol` stores a favorite number, a list of people, and a name-to-number mapping.
- `AddFiveStorage.sol` inherits from `SimpleStorage` and adds 5 before saving.
- `StorageFactory.sol` deploys and interacts with multiple `SimpleStorage` contracts.
- `FundMe.sol` accepts ETH funding above a USD threshold and lets the owner withdraw.
- `FallbackExample.sol` demonstrates `receive()` and `fallback()` behavior.
- `PriceConverter.sol` converts ETH values to USD using a price feed address.
- `MockV3Aggregator.sol` provides a local test price feed.

`FundMe.sol` expects a price feed address in its constructor. In Remix tests, `MockV3Aggregator.sol` is used to provide that dependency locally.

### Scripts

- `deploy_with_ethers.ts`
- `deploy_with_web3.ts`
- `ethers-lib.ts`
- `web3-lib.ts`

### Tests

- `tests/CurrentContracts_test.sol` exercises the current contract set.

## Learning Goals

- Understand how state is stored and read in Solidity.
- See inheritance and overriding in a small contract.
- Deploy and interact with child contracts from a factory.
- Learn how `receive()` and `fallback()` differ.
- See how a funding contract uses a price feed and owner-only withdrawal.
- Practice Remix-style testing against the actual contracts in the workspace.

## Running In Remix

1. Open the `contracts/` folder in Remix.
2. Compile the contracts you want to inspect.
3. Deploy the contract from the deploy panel.
4. Use the deployed contract buttons to call the public functions.

## Testing

The `tests/CurrentContracts_test.sol` file covers:

- storing and reading values in `SimpleStorage`
- the `+5` override in `AddFiveStorage`
- deployment and interaction in `StorageFactory`
- `receive()` and `fallback()` behavior in `FallbackExample`
- funding and withdrawal behavior in `FundMe` using `MockV3Aggregator`

## Cleanup Notes

- Generated Remix cache folders were removed.
- Stale template tests were removed.
- The README now describes the actual contracts in this repository.
