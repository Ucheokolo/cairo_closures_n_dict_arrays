use core::fmt::{Display, Formatter, Error};
use core::poseidon::PoseidonTrait;
use super::{dict_as_struct::{UserDatabase, UserDatabaseTrait}};


fn adapt() {
    let x = 8;
    let my_closure = |value| x * (value + 3);
    // {
    //     x * (value + 3)
    // };
    println!("my_closure(1) = {}", my_closure(1));
}

fn closure_type(num: u32) {
    let expensive_closure = |num: u32| -> u32 {
        num
    };
    println!("expensive closure is {}", expensive_closure(num));
}

fn dbs() {
    let mut db = UserDatabaseTrait::<u64>::new();
    db.update_user('Alex', 100);
    db.update_user('Maria', 80);

    db.update_user('Alex', 40);
    db.update_user('Maria', 0);

    let alex_latest_balance = db.get_balance('Alex');
    let maria_latest_balance = db.get_balance('Maria');

    println!("Alex's balance is: {}", alex_latest_balance);
    println!("Maria's balance is: {}", maria_latest_balance);

    assert!(alex_latest_balance == 40, "Expected 40");
    assert!(maria_latest_balance == 0, "Expected 0");
}

// fn hashes() -> felt252 {
//     let struct_to_hash = StructForHash{ first: 0, second: 1, third: (1,2), last: false};

//     let hash = PoseidonTrait::new().update_with(struct_to_hash).finalize();
//     hash
// }

#[derive(Copy, Drop)]
struct Point {
    x: u8,
    y: felt252,
}

impl PointDisplay of Display<Point> {
    fn fmt(self: @Point, ref f: Formatter) -> Result<(), Error> {
        let str: ByteArray = format!("Point ({}, {})", *self.x, *self.y);
        f.buffer.append(@str);
        Result::Ok(())
    }
}

fn arrays(a: u128, b: u128, c: u128, d: u128, e: u128) -> Array<u128>{
    let mut arr = ArrayTrait::<u128>::new();
    arr.append(a);
    arr.append(b);
    arr.append(c);
    arr.append(d);
    arr.append(e);
    let arc = @arr;
    arr.append(7);
    let mut arr2 = ArrayTrait::<u128>::new();
    for i in 0..arr.len() {
        arr2.append(*arc.at(i));
        println!("{}", *arr.at(i));
    };
    arr2
}

fn main() {
    let double = |value| value * 2;
    println!("Double of 2 is {}", double(2_u8));
    println!("Double of 4 is {}", double(4_u8));

    let sum = |x: u32, y: u32, z: u16| {
        x + y + z.into()
    };
    println!("Result: {}", sum(1, 2, 3));
    adapt();
    closure_type(9);
    dbs();
    let p = Point {x: 34, y: 'Zenda'};
    println!("{}", p);
    arrays(4, 6, 8, 0, 2);

}
