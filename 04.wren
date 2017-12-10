// Day 04: High-Entropy Passphrases
import "io" for File, Stdout

var hasNoDuplicates = Fn.new {|list|
    var map = {}
    
    for (item in list) {
        map[item] = 0
    }

    return list.count == map.count
}

var input = File.read("04.txt")
var result = input.split("\n").map {|row| row.replace("\r", "") }.map {|row| row.split(" ") }.where(hasNoDuplicates).count
System.print("Number of valid passphrases: %(result)")