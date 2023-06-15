module testnet_coins::usdc {
    use std::option;
    use sui::url;
    use sui::coin;
    use sui::transfer;
    use sui::tx_context::TxContext;
    use testnet_coins::faucet;

    struct USDC has drop {}

    const AIRDROP_AMOUNT: u64 = 10000_000000;

    fun init(otw: USDC, ctx: &mut TxContext) {
        let (treasury_cap, metadata) = coin::create_currency<USDC>(
            otw,
            6,
            b"USDC",
            b"Circle USD",
            b"fake USDC on testnet",
            option::some(url::new_unsafe_from_bytes(
                b"https://s2.coinmarketcap.com/static/img/coins/200x200/3408.png"),
            ),
            ctx,
        );
        transfer::public_freeze_object(metadata);
        transfer::public_share_object(
            faucet::new(treasury_cap, AIRDROP_AMOUNT, ctx)
        );
    }
}