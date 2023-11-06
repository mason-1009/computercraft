function cycleItemSlot(itemFilter)
    for slot = 1, 16, 1 do
        turtle.select(slot)
        if turtle.getItemCount() > 0 then
            break
        end
    end
end

function strafe(column)
    if column % 2 == 0 then
        turtle.turnLeft()
        if turtle.detect() then
            turtle.dig()
        end
        turtle.forward()
        turtle.turnLeft()
    else
        turtle.turnRight()
        if turtle.detect() then
            turtle.dig()
        end
        turtle.forward()
        turtle.turnRight()
    end
end

function runRow(length)
    for movement = 1, length, 1 do
        if turtle.detectDown() == false then
            if turtle.getItemCount() == 0 then
                cycleItemSlot()
            end
            turtle.placeDown()
        end
        if movement < length then
            if turtle.detect() then
                turtle.dig()
            end
            turtle.forward()
        end
    end
end

function runPlane(width, length)
    for column = 1, width, 1 do
        runRow(length)
        if column < width then
            strafe(column)
        end
    end
    if width % 2 == 0 then
        turtle.turnRight()
        for move = 1, width - 1, 1 do
            if turtle.detect() then
                turtle.dig()
            end
            turtle.forward()
        end
        turtle.turnRight()
    else
        turtle.turnLeft()
        for move = 1, width - 1, 1 do
            if turtle.detect() then
                turtle.dig()
            end
            turtle.forward()
        end
        turtle.turnLeft()
        for move = 1, length - 1, 1 do
            if turtle.detect() then
                turtle.dig()
            end
            turtle.forward()
        end
        turtle.turnLeft()
        turtle.turnLeft()
    end
end

function runCube(width, length, height)
    for y = 1, height, 1 do
        runPlane(width, length)
        if turtle.detectUp() then
            turtle.digUp()
        end
        if y < height then
            turtle.up()
        end
    end
end

function init(arguments)
    if table.getn(arguments) < 3 then
        print("Not enough arguments")
        print("Usage: builder.exe <item_id> <x> <y> <z>")
        print()
        print("Set item_id to a minecraft builder string")
    else
        local length = arguments[1] * 1
        local width = arguments[2] * 1
        local height = arguments[3] * 1
        if length > 0 and width > 0 and height > 0 then
            runCube(length, width, height)
        end
    end
end

init({...})
