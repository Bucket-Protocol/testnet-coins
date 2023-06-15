module testnet_coins::faucet {
    use sui::coin::{Self, TreasuryCap};
    use sui::transfer;
    use sui::object::{Self, UID};
    use sui::tx_context::{Self, TxContext};

    struct Faucet<phantom T> has key, store {
        id: UID,
        airdrop_amount: u64,
        cap: TreasuryCap<T>,
    }

    public fun new<T>(
        cap: TreasuryCap<T>,
        airdrop_amount: u64,
        ctx: &mut TxContext,
    ): Faucet<T> {
        Faucet {
            id: object::new(ctx),
            airdrop_amount,
            cap,
        }
    }

    public entry fun airdrop<T>(faucet: &mut Faucet<T>, ctx: &mut TxContext) {
        transfer::public_transfer(
            coin::mint(&mut faucet.cap, faucet.airdrop_amount, ctx),
            tx_context::sender(ctx),
        );
    }
}