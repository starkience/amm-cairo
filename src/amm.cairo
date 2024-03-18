    use starknet::ContractAddress;

    #[starknet::interface]
    pub trait IAMM<TContractState> {
        fn get_account_token_balance(self: @TContractState, account_id: ContractAddress, token_type: u16) -> u128;
        fn get_pool_token_balance(self: @TContractState, token_type: u16) -> u128;
        fn swap(ref self: TContractState, token_from: u128, amount_from: u128) -> u128;
        fn get_opposite_token(self: @TContractState, token_type: u16) -> u16;
        fn set_pool_token_balance(ref self: TContractState, token_type: u128, new_balance: u128);
        fn do_swap(ref self: TContractState, account_id: ContractAddress, token_from: u128, token_to: u128, amount_from: u128) -> u128;
    }

    const MAX_BALANCE: u256 = 1000000000;
    const TOKEN_TYPE_A: u8 = 1;
    const TOKEN_TYPE_B: u8 = 2;

    #[starknet::contract]
    mod AMM {
        use starknet::{ContractAddress, get_caller_address, storage_access::StorageBaseAddress};

        #[storage]
        struct Storage {
            account_balance: LegacyMap::<balance,(ContractAddress, token_type)>,
            pool_balance: LegacyMap::<balance, token_type>,
            balance: u128,
            token_type: u16,
        }

        #[abi(embed_v0)]
        impl AMM of super::IAMM<ContractState> {
            // define account balance as felt252
            // view get_account_token_balance
            // view set_pool_token_balance

            fn get_account_token_balance(self: @ContractState, account_id: ContractAddress, token_type: u16) -> u128 {
                let account_token_balance = self.account_balance.read((account_id, token_type));
                account_token_balance
            }
            fn get_pool_token_balance(self: @ContractState, token_type: u16) -> u128 {
            let pool_token_balance = self.pool_balance.read(token_type);
            pool_token_balance
            }
            fn swap(ref self: ContractState, token_from: u128, amount_from: u128) {
                let account_id = get_caller_address();
                assert((token_from - TOKEN_TYPE_A) * (token_from - TOKEN_TYPE_B) == 0, "token_from must be TOKEN_TYPE_A or TOKEN_TYPE_B");
                assert(amount_from < BALANCE_UPPER_BOUND, "amount_from must be less than BALANCE_UPPER_BOUND");

                let account_from_balance = get_account_token_balance(account_id, token_from);
                assert!(amount_from <= account_from_balance, "Not enough funds");

                let amount_to = get_opposite_token(token_from); // assuming token_from is the variable containing the token type to be swapped
                let amount_to = do_swap(account_id, token_from, token_to, amount_from);
                return amount_to;
            }
            fn get_opposite_token(self: @ContractState, token_type: u16) -> u16 {
                let token_type = self.token_type.read();
                if token_type == TOKEN_TYPE_A {
                    return TOKEN_TYPE_B;
                } else {
                    TOKEN_TYPE_A;
                }
            }
            fn do_swap (ref self:
                ContractState, account_id: ContractAddress, token_from: u128, token_to: u128, amount_from: u128) -> u128 {
                    let amm_from_balance = self.get_pool_token_balance(token_from);
                    let amm_to_balance = self.get_pool_token_balance(token_to);
                    let amount_to = amm_to_balance * amount_from / (amm_from_balance + amount_from);

                    self.modify_account_balance(account_id, token_from, -(amount_from as i128));
                    self.modify_account_balance(account_id, token_to, amount_to as i128);
                    self.set_pool_token_balance(token_from, amm_from_balance + amount_from);
                    self.set_pool_token_balance(token_to, amm_to_balance - amount_to);

                    return amount_to;
                }
            
        }



        #[generate_trait]
        impl InternalAMM of InternalAMMTrait {
            fn modify_account_balance(ref self: 
            ContractState, 
            account_id: ContractAddress,
            token_type: u16,
            amount: u128
        ) {
            let mut current_balance = self.account_balance.read();
            let new_balance = current_balance + amount;
            assert!(self.new_balance.read() <= MAX_BALANCE, "New balance exceeds maximum allowed balance");
            self.account_balance.write(account_id, token_type, new_balance);
        }

        }
    }