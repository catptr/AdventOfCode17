// Day 06: Memory Reallocation
var indexOfMaxValue = Fn.new {|memory|
    var currMax = 0
    var result = -1
    for (i in 0...memory.count) {
        if (memory[i] > currMax) {
            currMax = memory[i]
            result = i
        }
    }

    return result
}

var indexOf = Fn.new {|list, item|
    for (i in 0...list.count) {
        if (list[i] == item) {
            return i
        }
    }

    return -1
}

// http://www.cse.yorku.ca/~oz/hash.html
// Lists of numbers are basically just strings so why not use a string hashing function?
var djb2 = Fn.new {|list|
    var hash = 5381

    for (item in list) {
        hash = ((hash << 5) + hash) + item // hash * 33 + item
    }

    return hash
}

// This list is our input
var memory = [2, 8, 8, 5, 4, 2, 3, 1, 5, 5, 1, 2, 15, 13, 5, 14]
var banksToFill = memory.count - 1

var seenConfigurations = [djb2.call(memory)]
var numCycles = 0

var result = 0

var startTime = System.clock
while (true) {
    var bankToEmpty = indexOfMaxValue.call(memory)

    var fullAmount = memory[bankToEmpty]

    var loopsRequired = (fullAmount / banksToFill).floor
    var amountToGive = banksToFill * loopsRequired

    // If we have enough so that everyone can have at least 1 block each then everyone has to get the
    // exact same amount. If we have blocks left we give those back to the bank we took them from.
    // However, if we have fewer than is required so that every bank gets 1 block each, just give them
    // all away. This is only mentioned in the example:
    // "The fourth, first, and second banks get two blocks each, and the third bank gets one back."
    if (loopsRequired == 0) {
        amountToGive = fullAmount
    }
    
    var pointer = (bankToEmpty + 1) % memory.count
    for (i in 1..amountToGive) {
        memory[pointer] = memory[pointer] + 1

        pointer = (pointer + 1) % memory.count
        if (pointer == bankToEmpty) {
            pointer = (pointer + 1) % memory.count
        }
    }

    var leftOvers = fullAmount - amountToGive
    memory[bankToEmpty] = leftOvers

    numCycles = numCycles + 1
    
    var hash = djb2.call(memory)
    if (seenConfigurations.contains(hash)) {
        // How many cycles from start of loop
        result = numCycles - indexOf.call(seenConfigurations, hash)
        break
    } else {
        seenConfigurations.add(hash)
    }
}

System.print("%(numCycles) redistribution cycles had to be completed which took %(System.clock - startTime) seconds.")
System.print("The loop is %(result) cycles long.")