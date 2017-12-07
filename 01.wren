// Day 01: Inverse Captcha
import "io" for File

var chars = File.read("01.txt").bytes.toList
var sum = 0
for (i in 0...chars.count) {
    var current = chars[i]
    // if current is the last character, wrap around and get the first
    var next = (i == chars.count - 1) ? chars[0] : chars[i + 1]

    if (current == next) {
        // convert from ascii
        sum = sum + (current - 48)
    }
}

System.print("Sum: " + sum.toString)