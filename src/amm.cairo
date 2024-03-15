use starknet::ContractAddress;

#[starknet::interface]
pub trait IAMM<TContractState> {
    fn swap(ref self: TContractState,token_from: u128, amount_from: u128) -> u128;
    fn add_demo_token
}



#[starknet::contract]
mod AMM {
    use starknet::{ContractAddress, get_caller_address, storage_access::StorageBaseAddress};

    #[storage]
    struct Storage {
        account_balance: LegacyMap::<balance<ContractAddress, token_type>,
        balance: u128,
        token_type: u16,
        pool_balance: LegacyMap::<token_type, balance>
    }

    #[abi(embed_v0)]
    impl AMM of super::IAMM<ContractState> {
        // define account balance as felt252
        fn swap(ref self: ContractState, token_from: u128, amount_from: u128) {


        }
    }



    #[generate_trait]
    impl InternalAMM of InternalAMMTrait {
        fn modify_account_balance(ref self: ContractState, 
        account_id: u128,
        token_type: u128,
        amount: felt52
    ) {
        let current_balance = account_balance.read(); // finish contract balance change function

        
    }
        
        
        
        dress: ContractAddress, caller_address: ContractAddress)
            self.balances.read(ContractAddress)
        }
        fn update_balance(ref self: ContractAddress, mut delta: u128) -> bool {
            let current_balance = self.get_balance(ContractAddress);
            let new_balance: u128 =  current_balance + delta;
            assert(!new_balance >= 0, "Balance cannot be negative");
            self.set_balance(ContractAddress, new_balance_u128);
            true

        fn set_balance(ref self: ContractAddress,  new_balance: u128) {
            self.balance.write(ContractAddress, new_balance);
        }
        }




        fn modify_account_balance( 
            ref self: ContractState,
            account_balance: felt252   
        ) {
            // calculate the new balance
            self.account_balance.write()



        }

        
    }





// trait & Impl
//set_pool_token_balance
// get_pool balance
//do_swapget_opposite_token

//external
//swap ___
//add_demo_token ___
//init_pool ___


