const std = @import("std");
const chunk = @import("chunk.zig");

pub fn main() !void {
    const config = .{ .safety = true };
    var gpa = std.heap.GeneralPurposeAllocator(config){};
    defer _ = gpa.deinit();

    const allocator = gpa.allocator();
    var a_chunk = chunk.Chunk.init(allocator);
    defer a_chunk.deinit();

    try a_chunk.write(chunk.OpCode.Return);
    a_chunk.disassemble("test chunk");
}

test "simple test" {
    var list = std.ArrayList(i32).init(std.testing.allocator);
    defer list.deinit(); // try commenting this out and see if zig detects the memory leak!
    try list.append(42);
    try std.testing.expectEqual(@as(i32, 42), list.pop());
}
