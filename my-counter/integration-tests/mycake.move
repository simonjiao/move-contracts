//# init -n test --public-keys Chef=0x98826ab91a9a5d85dec536418090aa6342991bc8f947613721c8165e7102b132 

//# faucet --addr Chef --amount 10000000000000000

//# faucet --addr guest --amount 10000000000000000

//# run --signers Chef
script {
    use Chef::Cake;
    fun init(signer: signer) {
        Cake::init(&signer);
    }
}
// check: EXECUTED

//# run --signers Chef
script {
    use StarcoinFramework::Signer;
    use StarcoinFramework::Account;
    use Chef::Cake;
    fun make_cake(signer: signer) {
        let cake = Cake::make_cake(&signer , 1 * 1000 * 1000 * 1000);
        Account::deposit<Cake::Cake>( Signer::address_of(&signer) , cake );
        assert!( Account::balance<Cake::Cake>(@Chef) == 1 * 1000 * 1000 * 1000 , 1001);
    }
}
// check: EXECUTED

//# run --signers Chef
script {
    use Chef::Cake;
    fun destroy_cake(signer: signer) {
        let cake = Cake::make_cake(&signer , 1 * 1000 * 1000 * 1000);
        Cake::destroy_cake(&signer, cake);
    }
}
// check: EXECUTED

//# run --signers Chef
script {
    use StarcoinFramework::Account;
    use Chef::Cake;
    fun send_cake(signer: signer) {
        let cake = Cake::make_cake(&signer , 1 * 1000 * 1000 * 1000);
        Cake::send_cake(@guest, cake);
        assert!( Account::balance<Cake::Cake>(@guest) == 1 * 1000 * 1000 * 1000 , 1001);
    }
}
// check: EXECUTED
