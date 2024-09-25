const std = @import("std");
const data = @import("data.zig");

pub fn main() !void {
    var prng = std.rand.DefaultPrng.init(blk: {
        var seed: u64 = undefined;
        try std.posix.getrandom(std.mem.asBytes(&seed));
        break :blk seed;
    });
    const rand = prng.random();
    const n = rand.intRangeAtMost(usize, 0, 1664);

    var name = data.names[n];

    if (std.mem.eql(u8, name, "")) {
        name = "Anonymous";
    }

    std.debug.print("\"{s}\"\n-{s}\n", .{ data.quotes[n], data.names[n] });
}

test "simple test" {
    var list = std.ArrayList(i32).init(std.testing.allocator);
    defer list.deinit(); // try commenting this out and see if zig detects the memory leak!
    try list.append(42);
    try std.testing.expectEqual(@as(i32, 42), list.pop());
}
