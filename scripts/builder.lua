function countInventory()
    local sum = 0
    for slot = 1, 16 do
        sum = sum + turtle.getItemCount(slot)
    end
    return sum
end

function cycleInventory()
    for slot = 1, 16 do
        if turtle.getItemCount(slot) > 0 then
            turtle.select(slot)
            break
        end
    end
end

function waitUntilFueled()
    local inputString = ""
    print("Turtle needs to be refuelled")
    print("Add some burnable items to the turtle and type CONT")

    while true do
        inputString = read()
        if inputString == "CONT" then
            for slot = 1, 16 do
                turtle.select(slot)
                turtle.refuel()
            end
            print("Current Fuel Level: " ..tostring(turtle.getFuelLevel()))
            break
        else
            print("Wrong input: type CONT to continue")
        end
    end
end

function waitUntilInvFilled()
    local inputString = ""
    print("Turtle has run out of items")
    print("Add some building items and type CONT")

    while true do
        inputString = read()
        if inputString == "CONT" then
            cycleInventory()
            break
        else
            print("Wrong input: type CONT to continue")
        end
    end
end

function waitUntilCleared()
    local inputString = ""
    print("An object is blocking the path of the Turtle")
    print("Clear the path and type CONT to continue")

    while true do
        inputString = read()
        if inputString == "CONT" then
            break
        else
            print("Wrong input: type CONT to continue")
        end
    end
end

function sanityCheck()
    while turtle.getFuelLevel() == 0 do
        waitUntilFueled()
    end

    while countInventory() == 0 do
        waitUntilInvFilled()
    end

    if turtle.getItemCount() == 0 then
        cycleInventory()
    end

end

function strafe(currentRow)
    if currentRow % 2 == 0 then
        turtle.turnLeft()
        sanityCheck()
        turtle.forward()
        turtle.turnLeft()
    else
        turtle.turnRight()
        sanityCheck()
        turtle.forward()
        turtle.turnRight()
    end
end

function runRow(length)
    for move = 1, length do
        sanityCheck()
        turtle.placeDown()
        if move < length then
            turtle.forward()
        end
    end
end

function runArea(width, length)
    for row = 1, width do
        runRow(length)
        if row < width then
            strafe(row)
        end
    end

    if width % 2 == 0 then
        turtle.turnRight()
        for move = 1, width - 1 do
            sanityCheck()
            turtle.forward()
        end
        turtle.turnRight()
    else
        turtle.turnLeft()
        for move = 1, width - 1 do
            sanityCheck()
            turtle.forward()
        end

        turtle.turnLeft()

        for move = 1, length - 1 do
            turtle.forward()
        end

        turtle.turnLeft()
        turtle.turnLeft()
    end

    turtle.up()
end

function buildCube(height, width, length)
    for stack = 1, height do
        runArea(width, length)
    end
end

function init(args)
    if table.getn(args) < 3 then
        print("Error: not enough arguments")
        print("Usage: builder <width> <length> <height>")
    else
        local width = args[1] * 1
        local length = args[2] * 1
        local height = args[3] * 1
        buildCube(height, width, length)
    end
end

init({...})
