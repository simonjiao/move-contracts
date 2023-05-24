module Chef::Cake {

    use StarcoinFramework::Signer;
    use StarcoinFramework::Token;
    use StarcoinFramework::Account;

    struct Cake has copy, drop, store {}

    public fun admin() : address {
        @Chef
    }

    public fun init(account: &signer) {
        assert!( admin() == Signer::address_of(account), 10000);
        Token::register_token<Cake>(account, 9);
    }

    public fun make_cake(account: &signer, amount: u128) : Token::Token<Cake> {
        assert!( admin() == Signer::address_of(account), 10000);
        Token::mint<Cake>(account, amount)
    }

    public fun destroy_cake(account: &signer, cake: Token::Token<Cake>) {
        assert!(admin() == Signer::address_of(account), 10000);
        Token::burn(account, cake);
    }

    public fun send_cake(_to: address, cake: Token::Token<Cake>) {
        Account::deposit(@Chef, cake);
    }

    public fun add(x: u128, y: u128) : u128 {
        x + y
    }

    #[test]
    fun add_test() {
        assert!(add(19,1)==20,101);
    }
}