module MyCounterAddr::MyCounter {
    use StarcoinFramework::Signer;

    struct Counter has key {
        value: u64,
    }

    public fun init(account: &signer) {
        move_to(account, Counter { value: 0 });
    }

    public fun incr(account: &signer) acquires Counter {
        let counter = borrow_global_mut<Counter>(Signer::address_of(account));
        counter.value = counter.value + 1;
    }
}
