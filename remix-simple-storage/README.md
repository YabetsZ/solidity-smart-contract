# Simple Storage Smart Contract

## Overview

This is a beginner-friendly Solidity smart contract that demonstrates fundamental concepts of blockchain programming. The contract allows users to store their favorite number and manage a list of people with their associated favorite numbers.

## Contract Concepts and Components

### State Variables

- **`myFavoriteNumber`** (uint256): Stores a single favorite number. This is the primary storage variable for a default user number.

### Data Structures

- **`Person` Struct**: A custom data structure containing:
  - `favoriteNumber` (uint256): A person's favorite number
  - `name` (string): A person's name

### Dynamic Arrays

- **`listOfPeople`** (Person[]): A public dynamic array that stores multiple Person structs. This allows the contract to maintain a growing list of people and their favorite numbers.

### Mappings

- **`nameToFavoriteNumber`** (mapping): A key-value store that maps a person's name (string) to their favorite number (uint256). This enables quick lookup of a person's favorite number by their name.

## Functions

### 1. `store(uint256 _favoriteNumber)`
- **Type**: Public function (state-modifying)
- **Purpose**: Sets the `myFavoriteNumber` state variable to the provided value
- **Usage**: Call this function to store your favorite number on the blockchain
- **Parameter**: `_favoriteNumber` - The number you want to store

### 2. `retrieve()`
- **Type**: Public view function (read-only)
- **Returns**: uint256 (the stored favorite number)
- **Purpose**: Returns the value of `myFavoriteNumber` without modifying state
- **Usage**: Call this function to read the stored favorite number

### 3. `addPerson(string memory _name, uint256 _favoriteNumber)`
- **Type**: Public function (state-modifying)
- **Purpose**: Adds a new person to the contract
- **What it does**:
  1. Creates a new `Person` struct with the provided name and favorite number
  2. Adds this person to the `listOfPeople` array
  3. Updates the `nameToFavoriteNumber` mapping for quick lookup
- **Parameters**:
  - `_name` - The person's name
  - `_favoriteNumber` - Their favorite number

## Key Learning Points

1. **State Variables**: Understanding how data persists on the blockchain
2. **Structs**: Creating custom data types to group related information
3. **Arrays**: Storing collections of data that can grow dynamically
4. **Mappings**: Creating efficient key-value associations for quick lookups
5. **View Functions**: Reading data without consuming gas or modifying state
6. **Public Functions**: Creating functions that can be called externally
7. **Memory Keyword**: Understanding how strings are handled as function parameters

## Getting Started and Running the Code

### Prerequisites
- A web browser with internet access

### Step-by-Step Guide

1. **Open Remix IDE**: Visit the Remix Ethereum IDE in your browser
2. **Create a New File**: 
   - Click on the file explorer icon on the left sidebar
   - Create a new file named `SimpleStorage.sol`
3. **Paste the Code**: Copy the contents of `SimpleStorage.sol` and paste it into the Remix editor
4. **Compile the Contract**:
   - Click on the Solidity Compiler icon in the left sidebar
   - Select version 0.8.19 (or compatible version)
   - Click the "Compile SimpleStorage.sol" button
5. **Deploy the Contract**:
   - Click on the Deploy & Run Transactions icon in the left sidebar
   - Make sure you're on a test network (JavaScript VM is fine for testing)
   - Click the "Deploy" button
6. **Interact with the Contract**:
   - After deployment, you'll see the contract instance with all available functions
   - **Test `store()`**: Enter a number and click `store` to save it
   - **Test `retrieve()`**: Click `retrieve` to see your stored number
   - **Test `addPerson()`**: Enter a name and number, click `addPerson` to add a person
   - **Test `listOfPeople`**: Click to view all added people
   - **Test `nameToFavoriteNumber`**: Enter a name to look up their favorite number

## Example Workflow

1. Call `store(42)` to store the number 42
2. Call `retrieve()` to confirm the number is 42
3. Call `addPerson("Alice", 7)` to add Alice with favorite number 7
4. Call `addPerson("Bob", 13)` to add Bob with favorite number 13
5. Look up "Alice" in `nameToFavoriteNumber` to get 7
6. View the `listOfPeople` array to see both Alice and Bob stored

## Solidity Version

- **Pragma**: `pragma solidity 0.8.19`
- This contract is designed for Solidity version 0.8.19 and may work with other 0.8.x versions
