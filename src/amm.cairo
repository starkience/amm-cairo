use starknet::ContractAddress;

#[starknet::interface]
pub trait IAMM<TContractState> {
    fn get_account_token_balance(self: @TContractState, account_id: ContractAddress, token_type: u16) -> u128;
    fn get_pool_token_balance(self: @TContractState, token_type: u126) -> u128;
    fn swap(ref self: TContractState, token_from: u128, amount_from: u128) -> u128;
}



#[starknet::contract]
mod AMM {
    use starknet::{ContractAddress, get_caller_address, storage_access::StorageBaseAddress};

    #[storage]
    struct Storage {
        account_balance: LegacyMap::<balance<ContractAddress, token_type>,
        pool_balance: LegacyMap::<token_type, balance>,
        balance: u128,
        token_type: u16
    }

    #[abi(embed_v0)]
    impl AMM of super::IAMM<ContractState> {
        // define account balance as felt252
        // view get_account_token_balance
        // view set_pool_token_balance

        fn get_account_token_balance(self: ContractState, account_id: ContractAddress, token_type: u126) -> u128 {
            let account_token_balance = self.account_balance.read(balance);
            account_token_balance
        }
        fn get_pool_token_balance(self: ContractState, token_type: u126) -> u128 {
           let pool_token_balance = self.pool_balance.read(balance);
           pool_token_balance
        }
        fn swap(ref self: ContractState, token_from: u128, amount_from: u128) {
            let account_id = get_caller_address();

            // add swap function logic here
        }
    }



    #[generate_trait]
    impl InternalAMM of InternalAMMTrait {
        fn modify_account_balance(ref self: 
        ContractState, 
        account_id: u128,
        token_type: u128,
        amount: u128
    ) {
        let mut current_balance = self.account_balance.read();
        let new_balance = current_balance + amount;
        let MAX_BALANCE = 1000000000;
        assert!(self.new_balance.read() <= MAX_BALANCE, "New balance exceeds maximum allowed balance");
        self.account_balance.write(account_id, token_type, new_balance);

      }
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


