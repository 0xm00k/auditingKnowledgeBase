## Introduction

Every protocol defines a set of invariants—conditions that must always hold true throughout its operation. These invariants are critical to ensuring the protocol behaves as intended and remains secure under all circumstances.



## Why I Missed the Vulnerability

I didn’t pay close attention to the protocol’s invariants and failed to verify whether they were consistently upheld across all functions.



## What to Look Out For
- Identify and clearly document the protocol’s invariants before starting the audit.
- Ensure that each function maintains these invariants and does not introduce state changes that violate them.
- Pay special attention to edge cases and cross-function interactions that may break invariants.
- Add automated invariant checks where possible using tools or test assertions.

> Created on 30/06/2025