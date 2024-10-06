//! SPDX-License-Identifier: MIT
const std = @import("std");
const builtin = @import("builtin");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const lib = b.addStaticLibrary(.{
        .name = "zbf",
        .target = target,
        .optimize = optimize,
    });
    lib.linkLibC();
    lib.addCSourceFiles(
        .{
            .files = &.{
                "libbf.c",
                "cutils.c",
            },
            .flags = &.{
                "-DCONFIG_BIGNUM=1",
                "-DUSE_FFT_MUL=1",
                "-DUSE_BF_DEC=1",
            },
        },
    );
    // lib.addIncludePath(b.path("."));
    lib.installHeadersDirectory(b.path("."), "", .{
        .include_extensions = &.{
            "libbf.h",
            "cutils.h",
        },
    });
    b.installArtifact(lib);
}
