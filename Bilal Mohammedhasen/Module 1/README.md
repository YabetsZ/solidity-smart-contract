# Module 1 — Solidity Fundamentals

![Module 1 Completion](Module-1%20Completion.png.png)

This module covers the foundational building blocks of Solidity: primitive data types, enums, constructors, and the different kinds of functions (pure, view, state-changing, and overloaded). Each exercise is a small, self-contained contract paired with a Foundry test file.

## Table of Contents

- Overview
- Project Structure
- Prerequisites
- Setup
- Running the Tests
- Exercises
- Learning Outcomes

## Overview

Module 1 is split into two thematic groups:

- `basic-data-types`: Practice declaring and using Solidity's primitive types (bool, uint, int, string, enum).
- `functions`: Practice constructors, pure/view functions, state-changing functions, and overloaded functions.

Every exercise is a fully working contract under `<exercise>/Contract.sol` with a matching test in `<exercise>/Contract.t.sol`.

## Project Structure

```
Module 1/
├── README.md
├── basic-data-types/
│   ├── 1_booleans/
│   ├── 2_unsigned-integer/
│   ├── 3_signed-integers/
│   ├── 4_string-literals/
│   └── 5_enums/
└── functions/
    ├── 1_arguments/
    ├── 2_increment/
    ├── 3_view-addition/
    ├── 4_console-log/
    ├── 5_pure-double/
    └── 6_double-overload/
```

## Prerequisites

- Foundry (forge, cast, anvil)
- Git
- Terminal (PowerShell, Bash, or Windows Terminal)

## Setup

From the repo root (if `foundry.toml` is not present):

```bash
forge init --no-commit --force
forge install foundry-rs/forge-std --no-commit
```

## Running the Tests

From the repository (or an exercise folder configured as a Foundry project):

```bash
forge test
forge test -vvv       # verbose
forge test --match-contract ContractTest
```

## Exercises (high level)

- Data types: booleans, unsigned integers, signed integers, string literals, enums.
- Functions: constructor with args, pure/view functions, state mutation, function overloading.

## Learning Outcomes

- Use SPDX headers and pragma versions
- Declare Solidity primitive types and enums
- Write constructors, pure/view functions, and state-changing functions
- Overload functions and write Foundry tests

---

Created from example README provided by a peer; adapt as needed.
