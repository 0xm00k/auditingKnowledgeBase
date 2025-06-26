//SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.30;

import {Test, console} from "forge-std/Test.sol";
import {TestVault} from "../src/TestERC4626.sol";
import {TestToken} from "./mock/TestToken.sol";
import {ERC4626,IERC20} from "@openzeppelin/contracts/token/ERC20/extensions/ERC4626.sol";

contract VaultToken is Test {

    TestVault public vault;
    TestToken public testToken;
    address public ALICE = makeAddr("ALICE");
    address public BOB = makeAddr("BOB");

        function setUp() public {
            testToken = new TestToken();
            vault = new TestVault(IERC20(testToken));
        }

    function testConvertToShares() public view{
       console.log("Number of shares: ", vault.convertToShares(1_000e18));
    }
}