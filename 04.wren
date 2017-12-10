// Day 04: High-Entropy Passphrases
import "io" for File

var hasNoDuplicates = Fn.new {|list|
    var map = {}
    
    for (item in list) {
        map[item] = 0
    }

    return list.count == map.count
}

var bubbleSort = Fn.new {|list|
    var n = list.count
    while (true) {
        var swapped = false

        for (i in 1...n) {
            if (list[i - 1] > list[i]) {
                var tmp = list[i - 1]
                list[i - 1] = list[i]
                list[i] = tmp
                swapped = true
            }
        }
        if (!swapped) break
    }
}

/*
 * Anagrams should be the same word after sorting the letters
 */
var isAnagram = Fn.new {|a, b|
    if (a.count != b.count) return false

    var aBytes = a.bytes.toList
    var bBytes = b.bytes.toList

    bubbleSort.call(aBytes)
    bubbleSort.call(bBytes)

    // Why can't I just to aBytes == bBytes?
    for (i in 0...aBytes.count) {
        if (aBytes[i] != bBytes[i]) return false
    }

    return true
}

var hasNoAnagrams = Fn.new {|words|
    for (i in 0...words.count) {
        for (j in 0...words.count) {
            if (i != j) {
                if (isAnagram.call(words[i], words[j])) {
                    return false
                }
            }
        }
    }

    return true
}

var start = System.clock
var input = File.read("04.txt")
var result = input.split("\n").
    map {|row| row.replace("\r", "") }.
    map {|row| row.split(" ") }.
    where(hasNoDuplicates).
    where(hasNoAnagrams).
    count
System.print("Number of valid passphrases: %(result), took %(System.clock - start) seconds")