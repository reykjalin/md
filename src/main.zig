const std = @import("std");

pub fn main() !void {
    // Set up allocator.
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();

    const allocator = gpa.allocator();

    // Process arguments.
    const args = try std.process.argsAlloc(allocator);
    defer std.process.argsFree(allocator, args);

    if (args.len != 2) {
        std.log.err("incorrect usage", .{});
        std.process.exit(1);
    }

    // Get the file path.
    const file = args[1];

    // Read the file.
    const contents = try std.fs.cwd().readFileAlloc(allocator, file, std.math.maxInt(usize));
    defer allocator.free(contents);

    // Read line-by-line.
    var it = std.mem.splitScalar(u8, contents, '\n');

    const stdout_writer = std.io.getStdOut().writer();
    var stdout = std.io.bufferedWriter(stdout_writer);

    // Write lines to stdout with kitty scaling.
    while (it.next()) |line| {
        // Always end with a new line

        if (std.mem.startsWith(u8, line, "###")) {
            _ = try stdout.write("\x1b]66;s=2;");

            const line_without_hashes = std.mem.trimLeft(u8, line, "#");
            _ = try stdout.write(line_without_hashes);

            _ = try stdout.write("\x1b\\\n\n");
        } else if (std.mem.startsWith(u8, line, "##")) {
            _ = try stdout.write("\x1b]66;s=3;");

            const line_without_hashes = std.mem.trimLeft(u8, line, "#");
            _ = try stdout.write(line_without_hashes);

            _ = try stdout.write("\x1b\\\n\n\n");
        } else if (std.mem.startsWith(u8, line, "#")) {
            _ = try stdout.write("\x1b]66;s=4;");

            const line_without_hashes = std.mem.trimLeft(u8, line, "#");
            _ = try stdout.write(line_without_hashes);

            _ = try stdout.write("\x1b\\\n\n\n\n");
        } else {
            _ = try stdout.write(line);
            _ = try stdout.write("\n");
        }
    }

    try stdout.flush();
}
