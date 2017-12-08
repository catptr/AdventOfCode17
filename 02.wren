// Day 02: Corruption Checksum
import "io" for File

var checksum = File.read("02.txt").split("\n").map {|row|
    var values = row.split(" ").where {|str| !str.isEmpty }.map(Fn.new {|str| Num.fromString(str)})
    var min = values.reduce {|acc, curr| (curr < acc) ? curr : acc }
    var max = values.reduce {|acc, curr| (curr > acc) ? curr : acc }
    return max - min
}.reduce {|acc, item| acc + item}

System.print("Checksum: " + checksum.toString)