// Day 03: Spiral Memory

class Grid {
    // Create a square grid
    construct new(size) {
        _size = size
        _list = List.filled(size * size, 0)
    }

    size { _size }

    [x, y] { _list[y * _size + x] }
    [x, y]=(value) {
        _list[y * _size + x] = value
    }
}

var sumNeighbors = Fn.new {|memory, startX, startY|
    var sum = 0
    for (y in (startY-1)..(startY+1)) {
        if (y >= 0 && y < memory.size) {
            for (x in (startX-1)..(startX+1)) {
                if (x >= 0 && x < memory.size) {
                    sum = sum + memory[x, y]
                }
            }
        }
    }

    memory[startX, startY] = sum
}

var x = 0
var y = 0

var stepLength = 1
var stepsUntilTurn = stepLength

var turnCount = 0

var xStep = 1
var yStep = 0

var memory = Grid.new(9) // Minimum size that will fit our solution, found by empirical testing
var origin = (9 / 2).floor // zero based integer index

// initial 1
memory[origin, origin] = 1

var result = 0
var numIterations = 0

// input: 265149
while (true) {
    numIterations = numIterations + 1

    x = x + xStep
    y = y + yStep

    sumNeighbors.call(memory, origin + x, origin + y)
    if (memory[origin + x, origin + y] > 265149) {
        result = memory[origin + x, origin + y]
        break
    }

    stepsUntilTurn = stepsUntilTurn - 1

    if (stepsUntilTurn == 0) {
        var oldX = xStep
        xStep = yStep * -1
        yStep = oldX

        turnCount = turnCount + 1

        stepsUntilTurn = stepLength
        if (turnCount == 2) {
            stepsUntilTurn = stepLength = stepLength + 1
            turnCount = 0
        }
    }
}

System.print("Result is %(result) after %(numIterations) iterations")