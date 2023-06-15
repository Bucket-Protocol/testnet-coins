module testnet_coins::weth {
    use std::option;
    use sui::url;
    use sui::coin;
    use sui::transfer;
    use sui::tx_context::TxContext;
    use testnet_coins::faucet;

    struct WETH has drop {}

    const AIRDROP_AMOUNT: u64 = 10_00000000;

    fun init(otw: WETH, ctx: &mut TxContext) {
        let (treasury_cap, metadata) = coin::create_currency<WETH>(
            otw,
            8,
            b"wETH",
            b"Wrapped ETH",
            b"fake ETH on testnet",
            option::some(url::new_unsafe_from_bytes(
                b"https://s2.coinmarketcap.com/static/img/coins/200x200/1027.png"),
            ),
            ctx,
        );
        transfer::public_freeze_object(metadata);
        transfer::public_share_object(
            faucet::new(treasury_cap, AIRDROP_AMOUNT, ctx)
        );
    }
}