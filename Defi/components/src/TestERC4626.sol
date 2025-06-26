// SPDX-License-Identifier: MIT

pragma solidity 0.8.30;

import {ERC4626,IERC20} from "@openzeppelin/contracts/token/ERC20/extensions/ERC4626.sol";
import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

 contract TestVault is ERC4626 {

    constructor(IERC20 _asset) ERC4626(_asset) ERC20("TestVault","TV"){
    }
 }