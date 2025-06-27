
## Introduction
Some tokens, such as USDC and USDT, use fewer than 18 decimals. If a contract assumes all tokens have 18 decimals, it can lead to incorrect token amount calculations.

## Why I missed the vulnerability
Although I initially identified the bug, I underestimated its impact and did not thoroughly test the extent of the issue.

## What to look out for
`code snippet:`

````solidity
uint256 loanRatio = (debt * 10 ** 18) / collateral;
````

* Check if the contract accepts arbitrary tokens.
* Verify whether it assumes all tokens use 18 decimals (e.g., uses 1e18 in calculations).
* Perform comprehensive testing with tokens that have varying decimal places to uncover hidden issues.


> Created on 27/06/2025