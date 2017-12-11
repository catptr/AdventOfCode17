// Day 05: A Maze of Twisty Trampolines, All Alike
import "io" for File

var jumpOffsets = File.read("05.txt").split("\n").map {|s| Num.fromString(s) }.toList

var numSteps = 0
var ip = 0

var startTime = System.clock
while (ip < jumpOffsets.count) {
    var offset = jumpOffsets[ip]
    
    if (offset >= 3) {
        jumpOffsets[ip] = offset - 1
    } else {
        jumpOffsets[ip] = offset + 1
    }

    ip = ip + offset
    numSteps = numSteps + 1
}

System.print("Number of steps to exit: %(numSteps), took %(System.clock - startTime) seconds.")