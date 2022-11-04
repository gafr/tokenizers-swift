use uniffi_macros;

uniffi_macros::include_scaffolding!("lib");

fn add(a: u32, b: u32) -> u32 {
    a + b
}

#[no_mangle]
pub extern "C" fn hello_world() {
    println!("Hello World!");
}
