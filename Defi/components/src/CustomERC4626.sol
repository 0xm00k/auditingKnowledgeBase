// SPDX-License-Identifier: MIT

pragma solidity 0.8.30;

import {ERC20, IERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {ICustomERC4626} from "./interfaces/ICustomERC4626.sol";
import {Math} from "@openzeppelin/contracts/utils/math/Math.sol";
import {SafeERC20} from "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
contract CustomERC4626 is ICustomERC4626, ERC20 {
    using Math for uint256;
    using SafeERC20 for IERC20;

    IERC20 assetToken;
    constructor(
        IERC20 _asset,
        string memory _name,
        string memory _symbol
    ) ERC20(_name, _symbol) {
        assetToken = _asset;
    }

    /*//////////////////////////////////////////////////////////////
                             USER FUNCTIONS
    //////////////////////////////////////////////////////////////*/
    function deposit(
        uint256 assets,
        address receiver
    ) external returns (uint256 shares) {
        if (receiver == address(0)) revert AddressZero();

        uint256 maxAssets = maxDeposit(receiver);

        if (assets > maxAssets) revert ExceedsMaxAssets();

        assetToken.safeTransferFrom(msg.sender, address(this), assets);

        shares = previewDeposit(assets);

        if (shares != 0) _mint(receiver, shares);
    }

    function mint(
        uint256 shares,
        address receiver
    ) external returns (uint256 assets) {
        if (receiver == address(0)) revert AddressZero();

        uint256 maxShares = maxMint(receiver);

        if (shares > maxShares) revert ExceedsMaxMint();

        assets = previewMint(shares);

        assetToken.safeTransferFrom(msg.sender, address(this), assets);

        _mint(receiver, shares);
    }

    function withdraw(
        uint256 assets,
        address receiver,
        address owner
    ) external returns (uint256 shares) {
        if (receiver == address(0) || owner == address(0)) revert AddressZero();

        uint256 maxAssets = maxWithdraw(owner);

        if (assets > maxAssets) revert ExceedsMaxWithdraw();

        shares = previewWithdraw(assets);

        _burn(owner, shares);

        assetToken.safeTransfer(receiver, assets);
    }

    function redeem(
        uint256 shares,
        address receiver,
        address owner
    ) external returns (uint256 assets) {
        if (receiver == address(0) || owner == address(0)) revert AddressZero();

        uint256 maxShares = maxRedeem(owner);

        if (shares > maxShares) revert ExceedsMaxRedeem();

        assets = previewRedeem(shares);

        _burn(owner, shares);

        assetToken.safeTransfer(receiver, assets);
    }

    /*//////////////////////////////////////////////////////////////
                             VIEW FUNCTIONS
    //////////////////////////////////////////////////////////////*/
    ///@notice are susceptible to inflation attacks
    ///!TODO
    function totalAssets() public view returns (uint256) {
        return assetToken.balanceOf(address(this));
    }
    function asset() external view returns (address) {
        return address(assetToken);
    }

    function previewWithdraw(
        uint256 assets
    ) public view returns (uint256 shares) {
        return convertAssetsToShares(assets);
    }
    function previewDeposit(
        uint256 assets
    ) public view returns (uint256 shares) {
        return convertAssetsToShares(assets);
    }
    function previewRedeem(
        uint256 shares
    ) public view returns (uint256 assets) {
        return convertSharesToAssets(shares);
    }
    function previewMint(uint256 shares) public view returns (uint256 assets) {
        return convertSharesToAssets(shares);
    }

    function convertAssetsToShares(
        uint256 assets
    ) public view returns (uint256 shares) {
        return assets.mulDiv(totalSupply() + 1, totalAssets() + 1);
    }
    function convertSharesToAssets(
        uint256 shares
    ) public view returns (uint256 assets) {
        return shares.mulDiv(totalAssets() + 1, totalSupply() + 1);
    }

    function maxMint(address) public view virtual returns (uint256 maxShares) {
        return type(uint256).max;
    }

    function maxRedeem(address owner) public view returns (uint256 maxShares) {
        return balanceOf(owner);
    }

    function maxDeposit(
        address
    ) public view virtual returns (uint256 maxShares) {
        return type(uint256).max;
    }

    function maxWithdraw(
        address owner
    ) public view returns (uint256 maxAssets) {
        return convertSharesToAssets(balanceOf(owner));
    }
}
