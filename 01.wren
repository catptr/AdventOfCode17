// Day 01: Inverse Captcha
import "io" for File

var chars = File.read("01.txt").bytes.toList
var sum = 0
for (i in 0...chars.count) {
    var current = chars[i]
    var charToMatch = chars[(i + chars.count / 2) % chars.count]

    if (current == charToMatch) {
        // convert from ascii
        sum = sum + (current - 48)
    }
}

System.print("Sum: " + sum.toString)