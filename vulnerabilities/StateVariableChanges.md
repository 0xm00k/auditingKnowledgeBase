## Introduction
Improper handling of state variable changes can break contract logic, especially when read and write operations are not coordinated correctly across functions.

## Why I missed the vulnerability
I overlooked the issue because I didn’t trace how state variables were modified or used across different functions.

## What to look out for
- Carefully trace how state variables are modified within each function.
- Test interactions between multiple functions that read from or write to the same state variable.
- Ensure that a change made in one function doesn’t unintentionally affect the behavior of another.

> Created on 27/06/2025