
/// A trait for hash state accumulators.
pub trait HashStateTrait<S> {
    fn update(self: S, value: felt252) -> S;
    fn finalize(self: S) -> felt252;
}

/// Extension trait for hash state accumulators.

pub trait HashStateExTrait<S, T> {
    /// Extension trait for hash state accumulators.
    fn update_with(self: S, value: T) -> S;
}

/// A trait for values that can be hashed.
pub trait Hash<T, S, +HashStateTrait<S>> {
    /// Updates the hash state with the given value.
    fn update_state(state: S, value: T) -> S;
}

#[derive(Copy, Drop)]
pub struct StructForHash {
    pub first: felt252,
    pub second: felt252,
    pub third: (u32, u32),
    pub last: bool
}