const PROG_NAME: &str = env!("CARGO_PKG_NAME");
const PROG_VERSION: &str = env!("CARGO_PKG_VERSION");

fn main() {
    println!("Hello, Rust! {PROG_NAME} version {PROG_VERSION}");
}
