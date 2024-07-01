const std = @import("std");
const Allocator = std.mem.Allocator;

pub const OpCode = enum(u8) {
    Return,
};

pub const Chunk = struct {
    const Self = @This();
    code: std.ArrayList(OpCode),

    pub fn init(allocator: Allocator) Self {
        return Self{
            .code = std.ArrayList(OpCode).init(allocator),
        };
    }

    pub fn deinit(self: *Self) void {
        self.code.deinit();
    }

    pub fn write(self: *Self, code: OpCode) !void {
        try self.code.append(code);
    }
};
