--defining global variables
totalBlockUsedCount = 0
originalFuelLevel = turtle.getFuelLevel()

--defining functions
function countTotal()
    local count = 0
    for slot = 1, 16 do
        count = count + turtle.getItemCount(slot)
    end
    return count
end

function cycleSlots()
    if countTotal() == 0 then
        return false
    else
        if turtle.getItemCount() == 0 then
            print("Out of items in current slot, cycling...")
            for slot = 1, 16 do
                if turtle.getItemCount(slot) > 0 then
                    turtle.select(slot)
                end
            end
        end
    end
end

function waitUntilRefill()
    print("Warning: Turtle empty")
    print("Fill up inventory and type CONT to continue")
    local input = ""
    while true do
        input = read()
        if input ~= "CONT" then
            print("Incorrect input: type CONT to continue")
        else
            break
        end
    end
    print("Continuing...")
end

function waitUntilClear()
    print("Warning: Object blocking Turtle path")
    print("Remove object and type CONT to continue")
    local input = ""
    while true do
        input = read()
        if input ~= "CONT" then
            print("Incorrect input: type CONT to continue")
        else
            break
        end
    end
    print("Continuing...")
end

function waitUntilFueled()
    print("Warning: Out of fuel")
    print("Add fuel to inventory and type CONT to continue")
    local input = ""
    while true do
        input = read()
        if input ~= "CONT" then
            print("Incorrect input: type CONT to continue")
        else
            break
        end
    end
    print("Adding fuel to stores...")
    --loop inventory for fuel
    for slot = 1, 16 do
        turtle.select(slot)
        print("Attempting to burn slot #" ..tostring(slot))
    end

    print("Done refuelling")
end

function buildCol()
    local moves = 0
    while turtle.detectDown() == false do
        if turtle.getFuelLevel() == 0 then
            waitUntilFueled()
        end
        turtle.down()
        moves = moves + 1
    end

    for pos = 1, moves do
        if turtle.getFuelLevel() == 0 then
            waitUntilFueled()
        end
        turtle.up()
        if cycleSlots() == false then
            waitUntilRefill()
            cycleSlots()
        end
        turtle.placeDown()
        totalBlockUsedCount = totalBlockUsedCount + 1
        if totalBlockUsedCount % 50 == 0 then
            print("Placed " ..tostring(totalBlockUsedCount) .." blocks in total")
        end
    end
end

function strafe(rowNum)
    if rowNum % 2 == 0 then
        turtle.turnLeft()
        
        if turtle.getFuelLevel() == 0 then
            waitUntilFueled()
        end

        turtle.forward()
        turtle.turnLeft()
    else
        turtle.turnRight()

        if turtle.getFuelLevel() == 0 then
            waitUntilFueled()
        end

        turtle.forward()
        turtle.turnRight()
    end
end

function runRow(length)
    for move = 1, length do
        buildCol()
        if move < length then
            if turtle.detect() then
                waitUntilClear()
            else
                if turtle.getFuelLevel() == 0 then
                    waitUntilFueled()
                end
                turtle.forward()
            end
        end
    end
end

function runArea(width, length)
    for move = 1, width do
        runRow(length)
        if move < width then
            strafe(move)
        end
    end
    
    if width % 2 == 0 then
        turtle.turnRight()
        for move = 1, width - 1 do
            if turtle.getFuelLevel() == 0 then
                waitUntilFueled()
            end
            turtle.forward()
        end
        turtle.turnRight()
    else
        turtle.turnLeft()
        for move = 1, width - 1 do
            if turtle.getFuelLevel() == 0 then
                waitUntilFueled()
            end
            turtle.forward()
        end
        
        turtle.turnLeft()
        
        for move = 1, length - 1 do
            if turtle.getFuelLevel() == 0 then
                waitUntilFueled()
            end
            turtle.forward()
        end

        turtle.turnLeft()
        turtle.turnLeft()
    end
end

function init(args)
    if table.getn(args) < 2 then
        print("Error: please specify a length and a width")
        print("Usage: landbridge <x> <y>")
    else
        local width = args[1] * 1
        local length = args[2] * 1
        print("Starting...")
        runArea(width, length)
        print("Done. Have a nice day!")
    end
end

--init program
init({...})
