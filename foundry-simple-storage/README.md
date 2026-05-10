# Foundry Simple Storage

## Overview

This project is a small Foundry-based Solidity workspace that demonstrates how to:

- write and deploy a basic storage contract
- interact with contract state through a script
- test state changes with Foundry tests
- prepare the project for local or testnet deployment

The main contract stores a favorite number and a list of people paired with their favorite numbers.

## Project Structure

- `src/SimpleStorage.sol`: main Solidity contract
- `script/DeploySimpleStorage.s.sol`: deployment script
- `test/SimpleStorageTest.t.sol`: unit tests
- `foundry.toml`: Foundry configuration
- `.env.example`: example environment variables

## Contract Breakdown

### State Variables

- `uint256 myFavoriteNumber`
  - Stores a single favorite number on chain
- `Person[] public listOfPeople`
  - Dynamic array of people records
- `mapping(string => uint256) public nameToFavoriteNumber`
  - Maps a name to a favorite number

### Struct

- `Person`
  - `favoriteNumber`: the person’s stored number
  - `name`: the person’s name

### Functions

#### `store(uint256 _favoriteNumber)`

- Visibility: public
- Mutability: state-modifying
- Purpose: updates `myFavoriteNumber`

#### `retrieve()`

- Visibility: public
- Mutability: view
- Returns: the stored favorite number
- Purpose: reads the current value without changing state

#### `addPerson(string memory _name, uint256 _favoriteNumber)`

- Visibility: public
- Mutability: state-modifying
- Purpose: adds a new `Person` to the array and updates the name lookup mapping

## Deployment Script

The deploy script creates a new `SimpleStorage` instance inside `run()`.

### Script Flow

1. Start broadcasting transactions
2. Deploy `SimpleStorage`
3. Stop broadcasting
4. Return the deployed contract instance

This is the standard Foundry pattern for deployment scripts.

## Tests

The test file checks two main behaviors:

- `store()` should update the stored number
- `addPerson()` should update the name-to-number mapping

The test setup deploys a fresh contract before each test.

## Local Setup

### Requirements

- Git
- Foundry

### Compile

Run:

```bash
forge build
```

### Test

Run:

```bash
forge test
```

### Deploy Locally

1. Start a local Anvil chain
2. Use one of Anvil’s private keys in your `.env`
3. Deploy with the Foundry script

Example:

```bash
forge script script/DeploySimpleStorage.s.sol --broadcast --rpc-url <RPC_URL> --private-key <PRIVATE_KEY>
```

### Deploy to a Testnet

1. Set `RPC_URL` to a testnet endpoint
2. Set `PRIVATE_KEY` to a funded test account
3. Run the deployment script with `--broadcast`

Example:

```bash
forge script script/DeploySimpleStorage.s.sol --broadcast --rpc-url <RPC_URL> --private-key <PRIVATE_KEY>
```

## zkSync Workflow

The repository also includes a zkSync workflow for the same contract pattern.

### What to know

- Use the zkSync-compatible toolchain
- Start the local zkSync node if you want to test locally
- Use the zkSync deployment flags when creating or broadcasting the contract

## Learning Points

1. How state variables persist on chain
2. How structs group related data
3. How arrays and mappings solve different lookup problems
4. How Foundry scripts deploy contracts
5. How Foundry tests verify contract behavior

## Notes

- The contract uses Solidity `>=0.8.0 <0.9.0`
- Public mappings and arrays generate automatic getters
- The project is intentionally small so the core concepts are easy to study