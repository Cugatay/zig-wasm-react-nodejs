// const std = @import("std");

extern fn print(i32) void;

export fn add(a: i32, b: i32) i32 {
    const result = a + b;
    print(result);
    return result;
}

// extern "env" fn jsLog(ptr: [*]const u8, len: usize) void;
