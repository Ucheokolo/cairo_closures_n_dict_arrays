use super::dict_as_struct::{UserDatabase, UserDatabaseTrait};

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
}
