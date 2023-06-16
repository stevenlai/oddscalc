const std = @import("std");

pub fn americanOddsToPercentage(odds: i32) f64 {
    const fOdds = @intToFloat(f32, odds);
    if (odds > 0) {
        return (100.0 / (fOdds + 100.0) * 100.0);
    } else if (odds < 0) {
        return -1 * ((fOdds * -1.0) / (fOdds - 100.0)) * 100.0;
    } else {
        return 0.0;
    }
}

test "negative line" {
    const odds: i32 = try std.fmt.parseInt(i32, "-310", 10);
    const percOdds = americanOddsToPercentage(odds);
    const expectedPerc: f64 = 75.61;
    try std.testing.expectApproxEqAbs(expectedPerc, percOdds, 0.02);
}

test "positive line" {
    const odds: i32 = try std.fmt.parseInt(i32, "500", 10);
    const percOdds = americanOddsToPercentage(odds);
    const expectedPerc: f64 = 16.67;
    try std.testing.expectApproxEqAbs(expectedPerc, percOdds, 0.02);
}
pub fn main() !void {
    var it = std.process.ArgIterator.init();
    _ = it.next();
    if (it.next()) |odds| {
        const parsedOdds = try std.fmt.parseInt(i32, odds, 10);
        const percentage = americanOddsToPercentage(parsedOdds);
        std.debug.print("The implied probability for the given odds is: {d:.2} %\n", .{percentage});
    } else {
        std.debug.print("Need to pass in odds\n", .{});
    }
}
