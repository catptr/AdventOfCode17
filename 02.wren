// Day 02: Corruption Checksum
import "io" for File

var checksum = File.read("02.txt").split("\n").map {|row|
    var values = row.split(" ").where {|str| !str.isEmpty }.map(Fn.new {|str| Num.fromString(str)})
    
    for (a in values) {
        for (b in values) {
            if (a != b) {
                if (a % b == 0) return a / b
            }
        }
    }
    return 0 // not required with our input but you never know...
}.reduce {|acc, item| acc + item}

System.print("Checksum: " + checksum.toString)