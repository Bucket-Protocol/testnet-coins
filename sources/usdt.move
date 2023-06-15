module testnet_coins::usdt {
    use std::option;
    use sui::url;
    use sui::coin;
    use sui::transfer;
    use sui::tx_context::TxContext;
    use testnet_coins::faucet;

    struct USDT has drop {}

    const AIRDROP_AMOUNT: u64 = 10000_000000;

    fun init(otw: USDT, ctx: &mut TxContext) {
        let (treasury_cap, metadata) = coin::create_currency<USDT>(
            otw,
            6,
            b"USDT",
            b"Tether USD",
            b"fake USDT on testnet",
            option::some(url::new_unsafe_from_bytes(
                b"https://s2.coinmarketcap.com/static/img/coins/200x200/825.png"),
            ),
            ctx,
        );
        transfer::public_freeze_object(metadata);
        transfer::public_share_object(
            faucet::new(treasury_cap, AIRDROP_AMOUNT, ctx)
        );
    }
}