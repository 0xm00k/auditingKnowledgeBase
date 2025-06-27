// SPDX-License-Identifier: MIT

pragma solidity 0.8.30;

interface ICustomERC4626 {
    error AddressZero();
    error ExceedsMaxAssets();
    error ExceedsMaxWithdraw();
    error ExceedsMaxRedeem();
    error ExceedsMaxMint();
    /*//////////////////////////////////////////////////////////////
                             USER FUNCTIONS
    //////////////////////////////////////////////////////////////*/
    function deposit(
        uint256 assets,
        address receiver
    ) external returns (uint256 shares);
    function mint(
        uint256 shares,
        address receiver
    ) external returns (uint256 assets); //! how it handles approval??
    function withdraw(
        uint256 assets,
        address receiver,
        address owner
    ) external returns (uint256 shares);
    function redeem(
        uint256 shares,
        address receiver,
        address owner
    ) external returns (uint256 assets);
    /*//////////////////////////////////////////////////////////////
                             VIEW FUNCTIONS
    //////////////////////////////////////////////////////////////*/
    function totalAssets() external view returns (uint256);
    function asset() external view returns (address);
    function previewWithdraw(
        uint256 assets
    ) external view returns (uint256 shares);
    function previewDeposit(
        uint256 assets
    ) external view returns (uint256 shares);
    function previewRedeem(
        uint256 shares
    ) external view returns (uint256 assets);
    function previewMint(uint256 shares) external view returns (uint256 assets);
    function convertAssetsToShares(
        uint256 assets
    ) external view returns (uint256 shares);
    function convertSharesToAssets(
        uint256 shares
    ) external view returns (uint256 assets);
    function maxMint(
        address receiver
    ) external view returns (uint256 maxShares); //uint256 max
    function maxRedeem(address owner) external view returns (uint256 maxShares); //balanceOf
    function maxDeposit(
        address receiver
    ) external view returns (uint256 maxShares); //uint256 max
    function maxWithdraw(
        address owner
    ) external view returns (uint256 maxAssets); //!not sure
}
