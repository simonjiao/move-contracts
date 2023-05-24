module MyModuleAddr::EthSigVerifier {
    use StarcoinFramework::Signature;
    use StarcoinFramework::EVMAddress::{Self, EVMAddress};
    use StarcoinFramework::Option;

    public fun verify_eth_sig(signature: vector<u8>, addr: vector<u8>, message: vector<u8>) : bool {
        let recover_address_opt = Signature::ecrecover(message, signature);
        let expect_address = EVMAddress::new(addr);
        &Option::destroy_some<EVMAddress>(recover_address_opt) == &expect_address
    }

    #[test]
    public fun verify_eth_sig_test() {
        let signature = x"90a938f7457df6e8f741264c32697fc52f9a8f867c52dd70713d9d2d472f2e415d9c94148991bbe1f4a1818d1dff09165782749c877f5cf1eff4ef126e55714d1c";
        let msg_hash = x"b453bd4e271eed985cbab8231da609c4ce0a9cf1f763b6c1594e76315510e0f1";
        let address_bytes = x"29c76e6ad8f28bb1004902578fb108c507be341b";

        assert!(verify_eth_sig(signature, address_bytes, msg_hash), 101);
    }
}
