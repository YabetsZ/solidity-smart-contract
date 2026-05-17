# Storage Factory Smart Contracts

A collection of Solidity smart contracts demonstrating core blockchain and smart contract design patterns. These contracts teach essential concepts including state management, contract factories, inheritance, and contract interaction.

## Overview

This project contains three main contracts that work together to demonstrate important Solidity patterns:

- **SimpleStorage**: A basic contract that stores and retrieves a favorite number, with the ability to manage a list of people and their favorite numbers
- **StorageFactory**: Implements the factory pattern to dynamically create and manage multiple SimpleStorage contract instances
- **AddFiveStorage**: An advanced SimpleStorage variant that demonstrates contract inheritance and function overriding

These contracts showcase fundamental blockchain development concepts used in decentralized applications (dApps).

## Contract Architecture

### SimpleStorage Contract

**Purpose**: Manages storage of favorite numbers with associated person data.

**Solidity Version**: `0.8.19`

**State Variables**:
- `myFavoriteNumber` (uint256): Stores a single favorite number
- `listOfPeople` (Person[] public): Dynamic array storing Person struct instances
- `nameToFavoriteNumber` (mapping): Maps person names to their favorite numbers

**Data Structures**:
```
struct Person {
    uint256 favoriteNumber;     // The person's favorite number
    string name;                // The person's name
}
```

**Functions**:

1. **store(uint256 _favoriteNumber)** `public virtual`
   - Purpose: Stores a favorite number in the contract state
   - Parameters: `_favoriteNumber` - The number to store
   - Returns: None
   - State-Modifying: Yes
   - Why virtual?: Allows child contracts to override this function with custom logic

2. **retrieve()** `public view returns (uint256)`
   - Purpose: Retrieves the currently stored favorite number
   - Parameters: None
   - Returns: The stored favorite number (uint256)
   - State-Modifying: No (read-only with view designation)

3. **addPerson(string memory _name, uint256 _favoriteNumber)** `public`
   - Purpose: Adds a new person to the list and creates a name-to-number mapping
   - Parameters: `_name` - Person's name, `_favoriteNumber` - Their favorite number
   - Returns: None
   - State-Modifying: Yes (modifies listOfPeople array and nameToFavoriteNumber mapping)

### StorageFactory Contract

**Purpose**: Creates and manages multiple independent SimpleStorage contract instances.

**Solidity Version**: `0.8.19` (with `^` - compatible with newer versions)

**State Variables**:
- `listOfSimpleStorageContracts` (SimpleStorage[] public): Array storing deployed SimpleStorage contract instances

**Key Concept - The Factory Pattern**: This contract demonstrates how to programmatically deploy new contracts and store references to them. This is essential for building scalable applications where contract creation is dynamic.

**Functions**:

1. **createSimpleStorageContract()** `public`
   - Purpose: Deploys a new SimpleStorage contract instance and stores its reference
   - Parameters: None
   - Returns: None
   - Details: Uses the `new` keyword to deploy a fresh SimpleStorage contract
   - Why important?: Demonstrates dynamic contract creation on the blockchain

2. **sfStore(uint256 _simpleStorageIndex, uint256 _simpleStorageNumber)** `public`
   - Purpose: Calls the store function on a specific SimpleStorage contract instance
   - Parameters: `_simpleStorageIndex` - Index in the contracts array, `_simpleStorageNumber` - Number to store
   - Returns: None
   - Details: Accesses contracts via array index and calls their store function
   - Why important?: Shows how to interact with contract instances through stored references

3. **sfGet(uint256 _simpleStorageIndex)** `public view returns (uint256)`
   - Purpose: Retrieves the favorite number from a specific SimpleStorage contract instance
   - Parameters: `_simpleStorageIndex` - Index of the target contract
   - Returns: The favorite number from the specified contract
   - Details: Queries a specific contract's state without modification

### AddFiveStorage Contract

**Purpose**: Demonstrates contract inheritance and function overriding in Solidity.

**Solidity Version**: `0.8.19`

**Inheritance**: Extends SimpleStorage

**Functions**:

1. **store(uint256 _favoriteNumber)** `public override`
   - Purpose: Stores a favorite number with a twist - adds 5 to the input value
   - Parameters: `_favoriteNumber` - Base number to store
   - Behavior: Stores `_favoriteNumber + 5` instead of the exact value
   - Returns: None
   - State-Modifying: Yes
   - Why override?: Demonstrates how child contracts can modify parent behavior while inheriting other functionality
   - What's inherited?: `myFavoriteNumber`, `listOfPeople`, `nameToFavoriteNumber`, `retrieve()`, `addPerson()`

## Key Learning Points

### 1. State Management
These contracts demonstrate how data persists on the blockchain. When you call `store()`, you're permanently recording data on the network that survives contract calls.

### 2. Public vs Internal vs Virtual Functions
- **public**: Externally callable, part of contract's API
- **virtual**: Can be overridden by child contracts, enabling extensibility
- **view**: Read-only operations that don't modify state
- **override**: Implementation of a virtual parent function

### 3. Contract Factories
StorageFactory demonstrates how to create contracts dynamically. This pattern is crucial for building scalable platforms where users need their own contract instances.

### 4. Inheritance and Polymorphism
AddFiveStorage shows how Solidity supports object-oriented patterns. Child contracts can:
- Inherit all parent functionality
- Override specific functions with custom implementations
- Use parent functions unchanged

### 5. Data Structures
- **Structs**: Organize related data (Person struct bundles name and number)
- **Arrays**: Manage collections of data (`Person[]`)
- **Mappings**: Create fast lookups by key (`address => balance` patterns)

## Getting Started

### Prerequisites
- Access to Remix IDE (no local installation required)
- Basic understanding of Solidity syntax

### Step-by-Step Deployment in Remix

1. **Access Remix**
   - Open Remix IDE in your web browser

2. **Create the Files**
   - In the file explorer, create three new files: `SimpleStorage.sol`, `StorageFactory.sol`, and `AddFiveStorage.sol`
   - Copy the respective contract code into each file

3. **Compile the Contracts**
   - Navigate to the "Solidity Compiler" tab (left sidebar)
   - Select compiler version `0.8.19`
   - Click "Compile" for each file
   - Verify no errors appear

4. **Deploy SimpleStorage (First)**
   - Switch to the "Deploy & Run Transactions" tab
   - Select "SimpleStorage" from the contract dropdown
   - Click the "Deploy" button
   - A deployed contract instance appears under "Deployed Contracts"

5. **Add a Person**
   - Expand the SimpleStorage contract in "Deployed Contracts"
   - Under `addPerson`, enter values: name = "Alice", favoriteNumber = 42
   - Click the "addPerson" button to execute

6. **Store and Retrieve**
   - Under `store`, enter 100 and click to store a favorite number
   - Click `retrieve` to see the stored value (100)

7. **Deploy StorageFactory**
   - Select "StorageFactory" from the contract dropdown
   - Deploy it the same way as SimpleStorage

8. **Create SimpleStorage via Factory**
   - Click `createSimpleStorageContract` to deploy a new SimpleStorage instance managed by the factory
   - Call it multiple times to create several contracts

9. **Interact with Factory-Created Contracts**
   - Use `sfStore` with index 0 and value 55 to store in the first created contract
   - Use `sfGet` with index 0 to retrieve the value (should be 55)

10. **Deploy AddFiveStorage**
    - Deploy AddFiveStorage the same way
    - Call `store` with value 10
    - Call `retrieve` - you'll see 15 (because the function adds 5)

## Example Workflow

### Scenario: Managing Storage Values for Multiple Users

```
1. Deploy StorageFactory
2. Create 3 SimpleStorage contracts via createSimpleStorageContract()
3. For Contract 0:
   - Call sfStore(0, 25) → stores 25
   - Call sfGet(0) → returns 25
4. For Contract 1:
   - Call sfStore(1, 50) → stores 50
   - Call sfGet(1) → returns 50
5. For Contract 2:
   - Call sfStore(2, 100) → stores 100
   - Call sfGet(2) → returns 100
```

### Scenario: Using Inheritance with AddFiveStorage

```
1. Deploy AddFiveStorage
2. Call store(10) → internally stores 15 (10 + 5)
3. Call retrieve() → returns 15
4. Call addPerson("Bob", 20) → inherited from SimpleStorage, works unchanged
5. Call retrieve() to see the inherited retrieve function works normally
```

## Testing Functions in Remix

To verify each function works correctly:

| Contract | Function | Test Input | Expected Output |
|----------|----------|-----------|-----------------|
| SimpleStorage | store(50) | 50 | ✓ Transaction succeeds |
| SimpleStorage | retrieve() | — | 50 |
| SimpleStorage | addPerson("Eve", 99) | "Eve", 99 | ✓ Transaction succeeds |
| StorageFactory | createSimpleStorageContract() | — | ✓ New contract deployed |
| StorageFactory | sfStore(0, 75) | 0, 75 | ✓ Stored in contract 0 |
| StorageFactory | sfGet(0) | 0 | 75 |
| AddFiveStorage | store(10) | 10 | ✓ Stores 15 internally |
| AddFiveStorage | retrieve() | — | 15 |
