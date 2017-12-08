// Day 03: Spiral Memory

var x = 0
var y = 0

var direction = 0

var stepLength = 1
var stepsUntilTurn = stepLength

var turnCount = 0

var xStep = 1
var yStep = 0

// input: 265149
for (i in 1...265149) {
    x = x + xStep
    y = y + yStep

    stepsUntilTurn = stepsUntilTurn - 1

    if (stepsUntilTurn == 0) {
        direction = direction + Num.pi / 2 // rotate 90 degrees
        xStep = direction.cos.round
        yStep = direction.sin.round

        turnCount = turnCount + 1

        stepsUntilTurn = stepLength
        if (turnCount == 2) {
            stepsUntilTurn = stepLength = stepLength + 1
            turnCount = 0
        }
    }
}

var distance = x.abs + y.abs
System.print("Distance: " + distance.toString)