// SPDX-License-Identifier: MIT

pragma solidity 0.8.30;

interface ICustomERC4626V2 {
    error AddressZero();
    error InvalidAmount();
    error ExceedsMaxDeposit();
    error ExceedsMaxWithdraw();
    error ExceedsMaxRedeem();
    error ExceedsMaxMint();
    /*//////////////////////////////////////////////////////////////
                             USER FUNCTIONS
    //////////////////////////////////////////////////////////////*/
    function deposit(
        uint256 assets,
        address recipient
    ) external returns (uint256 shares);

    function mint(
        uint256 shares,
        address recipient
    ) external returns (uint256 assets);

    function withdraw(
        uint256 assets,
        address owner,
        address recipient
    ) external returns (uint256 shares);

    function redeem(
        address shares,
        address owner,
        address recipient
    ) external returns (uint256 assets);

    /*//////////////////////////////////////////////////////////////
                             VIEW FUNCTIONS
    //////////////////////////////////////////////////////////////*/
    function totalAssets() external view returns (uint256);

    function asset() external view returns (address);

    function convertAssetsToShares(
        uint256 assets
    ) external view returns (uint256 shares);

    function convertSharesToAssets(
        uint256 shares
    ) external view returns (uint256 assets);

    function previewDeposit(
        uint256 assets
    ) external view returns (uint256 shares);

    function previewMint(uint256 shares) external view returns (uint256 assets);

    function previewWithdraw(
        uint256 assets
    ) external view returns (uint256 shares);

    function previewRedeem(
        uint256 shares
    ) external view returns (uint256 assets);

    function maxDeposit(address) external view returns (uint256);

    function maxMint(address) external view returns (uint256);

    function maxWithdraw(address recipient) external view returns (uint256);

    function maxRedeem(address recipient) external view returns (uint256);
}
