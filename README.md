# payz Nullifier Registry

This isolated contract records opaque `bytes32` nullifiers after the existing
purchase-access deletion action. It does not process payments, move tokens,
settle purchases, or fulfill orders.

- Source license: Apache-2.0 (`SPDX-License-Identifier: Apache-2.0`)
- Project: payz
- Website: https://payz.world
- Authorized writer: the platform wallet supplied as `platformWallet` when the
  contract is deployed
- Public verification: `isUsed(bytes32)` and the `NullifierUsed` event
- Worker submission is disabled unless `PAYZ_NULLIFIER_REGISTRY_ENABLED=true`
  is explicitly configured alongside the contract address, chain ID, RPC, and
  platform wallet.

The contract has no owner-transfer or submitter-rotation function. Replacing the
authorized submitter requires deploying a new registry contract.

## Ethereum Mainnet deployment

- Chain ID: `1`
- Contract address: `0xcbd2218c622ae8d8088a82a72b4df6c5375487e5`
- Deployment transaction: `0xcba14e69f9257a7fd4071943815bcee2adf251e03c417fda2ce46f93d63b4b44`
- Block: `26139201`
- Deployed at: `2026-10-07T08:05:35Z`
- Authorized submitter: `0x18F4939f0e7B8a39fAa0AFdb205CEB21fa7060c5`
- Runtime bytecode is present; constructor input matches the compiled creation bytecode.
- On-chain writer and project metadata getters were verified.
- Gas used: `357238`; actual fee: `0.00004511 ETH`.

The production worker configuration has been approved and prepared. The
currently published version remains API-only until the user publishes the
updated VM process configuration. On its first start, the worker records an
activation timestamp and processes only later explicit access-deletion events;
it does not backfill earlier deletions.
