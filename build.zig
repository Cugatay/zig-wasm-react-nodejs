const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});

    const optimize = b.standardOptimizeOption(.{});
    // const optimize: std.builtin.OptimizeMode = .ReleaseSmall;

    const lib = b.addStaticLibrary(.{
        .name = "zig-wasm",
        .root_source_file = b.path("src/root.zig"),
        .target = target,
        .optimize = optimize,
    });

    b.installArtifact(lib);

    const exe = b.addExecutable(.{
        .name = "zig-wasm",
        .root_source_file = b.path("src/main.zig"),
        .target = target,
        .optimize = optimize,
    });

    b.installArtifact(exe);

    // const exe_check = b.addExecutable(.{
    //     .name = "foo",
    //     .root_source_file = b.path("src/main.zig"),
    //     .target = target,
    //     .optimize = optimize,
    // });
    //
    // const check = b.step("check", "Check if it compiles");
    // check.dependOn(&exe_check.step);
}
