const std = @import("std");

pub fn build(b: *std.Build) void {
    // We need to define target
    // For the CPU system, we'll use WASM32
    // And we need a freestanding binary, which is given in the os_tag
    const target = b.standardTargetOptions(.{
        .default_target = .{
            .cpu_arch = .wasm32,
            .os_tag = .freestanding,
        },
    });

    // Big file sizes are unacceptable in Web Development,
    // and OptimizeMode = ReleaseSmall just fixes that
    // You can try out different optimize modes to see different results
    const optimize: std.builtin.OptimizeMode = .ReleaseSmall;

    const exe = b.addExecutable(.{
        .name = "zig-wasm",
        .root_source_file = b.path("src/main.zig"),
        .target = target,
        .optimize = optimize,
    });

    // rdynamic is used for building all functions that have
    // export keyword. For example: export fn add(...
    exe.rdynamic = true;

    // Not defining entry as disabled gives error on build, I'm not a Zig build system expert :)
    // But maybe you can give me the reason, then I'll merge that for sure!
    exe.entry = .disabled;

    b.installArtifact(exe);
}
