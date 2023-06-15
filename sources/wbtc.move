module testnet_coins::wbtc {
    use std::option;
    use sui::url;
    use sui::coin;
    use sui::transfer;
    use sui::tx_context::TxContext;
    use testnet_coins::faucet;

    struct WBTC has drop {}

    const AIRDROP_AMOUNT: u64 = 10_000_000;

    fun init(otw: WBTC, ctx: &mut TxContext) {
        let (treasury_cap, metadata) = coin::create_currency<WBTC>(
            otw,
            8,
            b"wBTC",
            b"Wrapped BTC",
            b"fake BTC on testnet",
            option::some(url::new_unsafe_from_bytes(
                b"https://s2.coinmarketcap.com/static/img/coins/200x200/1.png"),
            ),
            ctx,
        );
        transfer::public_freeze_object(metadata);
        transfer::public_share_object(
            faucet::new(treasury_cap, AIRDROP_AMOUNT, ctx)
        );
    }
}