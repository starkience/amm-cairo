#[starknet::contract]
mod AMM {
    use starknet::{ContractAddress, get_caller_address, storage_access::StorageBaseAddress};



    #[storage]
    struct Storage {
        account_balance: LegacyMap::<ContractAddress, felt>,
        balance: felt,
        token_type: felt,
        pool_balance: LegacyMap::<token_type, balance>
    }


    #[event]


    #[derive(Drop, starknet::Event)]
    enum Event {
    }

}



// trait & Impl
//set_pool_token_balance
// get_pool balance
//do_swapget_opposite_token

//external
//swap
//add_demo_token
//init_pool