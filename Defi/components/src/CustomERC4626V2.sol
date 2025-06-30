// SPDX-License-Identifier: MIT

pragma solidity 0.8.30;

import {ICustomERC4626V2} from "./interfaces/ICustomERC4626V2.sol";
import {ERC20, IERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {Math} from "@openzeppelin/contracts/utils/math/Math.sol";

abstract contract CustomERC4626V2 is ICustomERC4626V2, ERC20 {
    using Math for uint256;

    IERC20 public assetToken;
    constructor(
        string memory _name,
        string memory _symbol,
        address _asset
    ) ERC20(_name, _symbol) {
        if (_asset == address(0)) revert AddressZero();
        assetToken = IERC20(_asset);
    }

    /*//////////////////////////////////////////////////////////////
                             USER FUNCTIONS
    //////////////////////////////////////////////////////////////*/
    function deposit(
        uint256 assets,
        address recipient
    ) external override returns (uint256 shares) {
        if (recipient == address(0)) revert AddressZero();
        if (assets == 0) revert InvalidAmount();

        uint256 maxAssets = maxDeposit(recipient);
        if (assets > maxAssets) revert ExceedsMaxDeposit();

        shares = previewDeposit(assets);

        assetToken.transferFrom(msg.sender, address(this), assets);

        _mint(recipient, shares);
    }

    function mint(
        uint256 shares,
        address recipient
    ) external returns (uint256 assets) {
        if (recipient == address(0)) revert AddressZero();
        if (shares == 0) revert InvalidAmount();

        uint256 maxShares = maxMint(recipient);

        if (shares > maxShares) revert ExceedsMaxMint();

        assets = previewMint(shares);

        assetToken.transferFrom(msg.sender, address(this), assets);

        _mint(recipient, shares);
    }

    function withdraw(
        uint256 assets,
        address owner,
        address recipient
    ) external returns (uint256 shares) {
        if (recipient == address(0) || owner == address(0))
            revert AddressZero();
        if (assets == 0) revert InvalidAmount();

        uint256 maxAssets = maxWithdraw(owner);

        if (assets > maxAssets) revert ExceedsMaxWithdraw();

        shares = previewWithdraw(assets);

        _burn(owner, shares);

        assetToken.transfer(recipient, assets);
    }

    function redeem(
        uint256 shares,
        address owner,
        address recipient
    ) external returns (uint256 assets) {
        if (recipient == address(0) || owner == address(0))
            revert AddressZero();
        if (shares == 0) revert InvalidAmount();

        uint256 maxShares = maxRedeem(owner);

        if (shares > maxShares) revert ExceedsMaxRedeem();

        assets = previewRedeem(shares);

        _burn(owner, shares);

        assetToken.transfer(recipient, assets);
    }

    /*//////////////////////////////////////////////////////////////
                             VIEW FUNCTIONS
    //////////////////////////////////////////////////////////////*/
    function totalAssets() public view returns (uint256) {
        return assetToken.balanceOf(address(this));
    }
    function convertAssetsToShares(
        uint256 assets
    ) public view returns (uint256 shares) {
        return
            assets.mulDiv(
                totalSupply() + 10 ** _offsetDecimals(),
                totalAssets() + 1
            );
    }

    function convertSharesToAssets(
        uint256 shares
    ) public view returns (uint256 assets) {
        return
            shares.mulDiv(
                totalAssets() + 1,
                totalSupply() + 10 ** _offsetDecimals()
            );
    }

    function previewDeposit(uint256 assets) public view returns (uint256) {
        return convertAssetsToShares(assets);
    }

    function previewMint(uint256 shares) public view returns (uint256) {
        return convertSharesToAssets(shares);
    }

    //!confirm
    function previewWithdraw(uint256 assets) public view returns (uint256) {
        return convertAssetsToShares(assets);
    }

    //!confirm
    function previewRedeem(uint256 shares) public view returns (uint256) {
        return convertSharesToAssets(shares);
    }

    /** max shares */
    function maxMint(address) public pure returns (uint256) {
        return type(uint256).max;
    }

    /**
     max Assets
     */
    function maxDeposit(address) public pure returns (uint256) {
        return type(uint256).max;
    }

    /** max shares */
    function maxRedeem(address owner) public view returns (uint256) {
        return balanceOf(owner);
    }

    /**
     max Assets
     */
    function maxWithdraw(address owner) public view returns (uint256) {
        return balanceOf(owner);
    }

    /** to prevent first deposit inflation */
    function _offsetDecimals() internal pure returns (uint256) {
        return 0;
    }
}
