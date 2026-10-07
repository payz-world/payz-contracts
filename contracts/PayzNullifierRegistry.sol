// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.24;

/// @title payz Nullifier Registry
/// @notice Publishes only opaque nullifiers after a customer explicitly closes purchase access.
/// @dev The platform wallet is supplied as the immutable sole submitter at deployment.
/// @custom:website https://payz.world
contract PayzNullifierRegistry {
    address public immutable authorizedSubmitter;
    string public constant projectName = "payz";
    string public constant projectWebsite = "https://payz.world";
    string public constant projectLicense = "Apache-2.0";

    mapping(bytes32 => bool) private usedNullifiers;

    event NullifierUsed(bytes32 indexed nullifier);

    error UnauthorizedSubmitter();
    error ZeroNullifier();
    error NullifierAlreadyUsed(bytes32 nullifier);

    constructor(address platformWallet) {
        if (platformWallet == address(0)) revert UnauthorizedSubmitter();
        authorizedSubmitter = platformWallet;
    }

    modifier onlyAuthorizedSubmitter() {
        if (msg.sender != authorizedSubmitter) revert UnauthorizedSubmitter();
        _;
    }

    function consume(bytes32 nullifier) external onlyAuthorizedSubmitter {
        if (nullifier == bytes32(0)) revert ZeroNullifier();
        if (usedNullifiers[nullifier]) revert NullifierAlreadyUsed(nullifier);

        usedNullifiers[nullifier] = true;
        emit NullifierUsed(nullifier);
    }

    function isUsed(bytes32 nullifier) external view returns (bool) {
        return usedNullifiers[nullifier];
    }
}
