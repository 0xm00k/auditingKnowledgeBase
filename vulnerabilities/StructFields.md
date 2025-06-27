## Introduction
Structs with many fields can be difficult to manage, making it easy to overlook unused or unValidated fields. It’s important to ensure that all struct fields are either used for state changes, read operations, or properly validated within the function or contract logic.

## Why I missed the vulnerability
I didn’t verify that all fields in the struct were used within the function.

## What to look out for
- Ensure all fields in the struct are meaningfully used or validated in the function.

> Created on 27/06/2025