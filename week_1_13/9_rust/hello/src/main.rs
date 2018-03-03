extern crate rand;

use std::io;
use std::cmp::Ordering;
use rand::Rng;

fn main() {
    let secret_number = rand::thread_rng().gen_range(1, 101);
    println!("The number is {}", secret_number);

    loop {
        println!("Please input your guess.");

        let mut guess = String::new();

        io::stdin().read_line(&mut guess)
            .expect("Failed to read line");
        let guess: u32 = match guess.trim().parse() {
            Ok(num) => num,
            Err(_) => continue,
        };

        match guess.cmp(&secret_number) {
            Ordering::Less => println!("Too Low"),
            Ordering::Greater => println!("Too High"),
            Ordering::Equal => {
                println!("You guessed it right!");
                break;
            }
        }
    }

    let mut x = 5;
    println!("x = {}", x);
    // mutable variables are allowed to be reassigned
    x = 6;
    println!("x = {}", x);
    // Consts require a type declaration
    const MAX_VAL: u32 = 100_000; // you can use '_' for separation of a number with no ill effect
    println!("MAX_VAL = {}", MAX_VAL);
    let y = 5;
    let y = x + 1;
    let y = x * 2;
    println!("y = {}", y);
    let spaces = "     ";
    // shadowed immutables can change their type when you shadow them
    let spaces = spaces.len();
    println!("spaces = {}", spaces);
    // Int types:   [i|u][8|16|32|64]
    // Float types: f[32|64]
    // Tuples
    let tup: (u32, f64, i8) = (32_000, 52.6, 32);
    let (a,b,c) = tup;
    println!("a = {}, b = {}, c = {}", a, b, c);
    // access tuple values using dot notation with index
    let d = tup.0;
    println!("d = {}", d);
    // Arrays
    let ary = [1,2,3,4,5];
    let first = ary[0];
    println!("first = {}", first);
    let second = ary[1];
    println!("second = {}", second);
    // Functions
    foo(1024);
    expression(5);  // should print 7
    let ret = ret_val(4);
    println!("ret = {}", ret);
    // If statement special stuff
    let result = if ret == 16 {
        12
    } else {
        24
    };
    // Loops
    let x = 10;
    loop { // Infinite loop until break
        let x = x + 10;
        break;
    }
    let a = [1,2,3,4,5];
    for element in a.iter() {
        print!("{} ", element);
    }
    println!("\nCountdown time:");
    for num in (1..4).rev() {
        print!("{}...", num);
    }
    println!("LIFTOFF!");
    // Strings
    let mut s = String::from("hello");
    s.push_str(", world!");
    let s2 = s;  // At this point, s is now INVALID, it has been de-referenced
    let mut s3 = s2.clone(); // Now s3 is a _deep copy_ of s2, so both still exist:
    println!("s2 = {}, s3 = {}", s2, s3);
    s3.push_str("  How are you?");
    println!("s2 = {}, s3 = {}", s2, s3);
    // Ownership
    let s = String::from("hello");
    take_ownership(s);  // Ownership of "s" passes to the function, no longer in scope for main()
    // At this point, s is no longer valid!
    let i = 32;
    make_copy(i); // i's value is _copied_ to the function
    // "i" is STILL VALID here! has not left scope yet
}

fn foo(x: i32) {
    println!("x = {}", x);
}

fn expression(x: i32) {
    let y = {
        let a = x;
        a + 2 // lack of semicolon here makes this an expression which returns the result of this line
    };
    println!("y = {}", y);
}

fn ret_val(x: i32) -> i32 {
    x * x
}

fn take_ownership(s: String) {
    println!("{}", s);
}

fn make_copy(i: u32) {
    println!("{}", i);
}
