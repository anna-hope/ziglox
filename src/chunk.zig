const std = @import("std");
const Allocator = std.mem.Allocator;

fn disassemble_instruction(code: OpCode, offset: u8) u8 {
    std.debug.print("{:0>4} ", .{offset});

    switch (code) {
        .Return => {
            std.debug.print("{}\n", .{code});
            return offset + 1;
        },
    }
}

pub const OpCode = enum(u8) {
    Return,
};

pub const Chunk = struct {
    const Self = @This();
    codes: std.ArrayList(OpCode),

    pub fn init(allocator: Allocator) Self {
        return Self{
            .codes = std.ArrayList(OpCode).init(allocator),
        };
    }

    pub fn deinit(self: *Self) void {
        self.codes.deinit();
    }

    pub fn write(self: *Self, code: OpCode) !void {
        try self.codes.append(code);
    }

    pub fn disassemble(self: Self, name: []const u8) void {
        std.debug.print("== {s} ==\n", .{name});
        var offset: u8 = 0;

        for (self.codes.items) |code| {
            offset += disassemble_instruction(code, offset);
        }
    }
};
