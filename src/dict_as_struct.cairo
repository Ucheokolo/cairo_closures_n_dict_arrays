use core::fmt::{Display, Formatter, Error};

use core::dict::Felt252Dict;
pub struct UserDatabase<T> {
    pub users_updates: u64,
    pub balances: Felt252Dict<T>,
}

pub trait UserDatabaseTrait<T> {
    fn new() -> UserDatabase<T>;
    fn update_user<+Drop<T>>(ref self: UserDatabase<T>, name: felt252, balances: T);
    fn get_balance<+Copy<T>>(ref self: UserDatabase<T>, name: felt252) -> T;
}

impl UserDatabaseDestruct<T, +Drop<T>, +Felt252DictValue<T>> of Destruct<UserDatabase<T>> {
    fn destruct(self: UserDatabase<T>) nopanic {
        self.balances.squash();
    }
}

impl UserDatabaseImpl<T, +Felt252DictValue<T>> of UserDatabaseTrait<T> {
    fn new() -> UserDatabase<T> {
        UserDatabase { users_updates: 0, balances: Default::default() }
    }

    fn update_user<+Drop<T>>(ref self: UserDatabase<T>, name: felt252, balances: T) {
        self.balances.insert(name, balances);
        self.users_updates += 1;
    }

    fn get_balance<+Copy<T>>(ref self: UserDatabase<T>, name: felt252) -> T {
        self.balances.get(name)
    }
}


// Simulating a Dynamic Array with Dicts
trait MemoryVecTrait<V, T> {
    fn new() -> V;
    fn get(ref self: V, index: usize) -> Option<T>;
    fn at(ref self: V, index: usize) -> T;
    fn push(ref self: V, value: T) -> ();
    fn set(ref self: V, index: usize, value: T);
    fn len(self: @V) -> usize;
}

struct MemoryVec<T> {
    data: Felt252Dict<Nullable<T>>,
    len: usize,
}
// Since we again have Felt252Dict<T> as a struct member, we need to implement the Destruct<T> trait
// to tell the compiler how to make MemoryVec<T> go out of scope.

impl DestructMemoryVect<T, +Drop<T>> of Destruct<MemoryVec<T>> {
    fn destruct(self: MemoryVec<T>) nopanic {
        self.data.squash();
    }
}

// impl MemoryVecImpl<T, +Drop<T>, +Copy<T>> of MemoryVecTrait<MemoryVec<T>, T> {
//     fn new() -> MemoryVec<T> {
//         MemoryVec { data: Default::default(), len: 0 }
//     }

//     fn get(ref self: MemoryVec<T>, index: usize) -> Option<T> {
//         if index < self.len() {
//             Option::Some(self.data.get(index.into()).deref())
//         } else {
//             Option::None
//         }
//     }

//     fn at(ref self: MemoryVec<T>, index: usize) -> T {
//         assert!(index < self.len(), "Index out of bound");
//         self.data.get(index.into()).deref()
//     }

//     fn push(ref self: MemoryVec<T>, value: T) -> () {
//         self.data.insert(self.len.into(), NullableTrait::new(value));
//         self.len.wrapping_add(1_usize);
//     }

//     fn set(ref self: MemoryVec<T>, index: usize, value: T) {
//         assert!(index < self.len(), "Index out of bounds");
//         self.data.insert(index.into(), NullableTrait::new(value));
//     }

//     fn len(self: @MemoryVec<T>) -> usize {
//         *self.len
//     }
// }


