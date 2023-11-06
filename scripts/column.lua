function checkInventory(required)
    local sum = 0
    for slot = 1, 16, 1 do
        sum = sum + turtle.getItemCount(slot)
    end
    if sum >= required then
        return true
    else
        return false
    end
end

function cycleSlot()
    for slot = 1, 16, 1 do
        if turtle.getItemCount(slot) > 0 then
            turtle.select(slot)
            break
        end
    end
end

function buildColumn(height)
    if checkInventory(height) == false then
        print("Not enough items in the turtle inventory")
        return
    else
        for pos = 1, height, 1 do
            cycleSlot()
            turtle.place()
            if pos < height then
                turtle.up()
            end
        end
        --return to ground
        for pos = 1, height - 1, 1 do
            turtle.down()
        end
    end
    print("Placed " ..tostring(height) .." blocks in total")
end

function init(args)
    if table.getn(args) < 1 then
        print("Not enough arguments")
        print("Usage: column.exe <height>")
        return
    else
        local columnHeight = args[1] * 1
        if columnHeight < 1 then
            print("Error: height must be greater than 0")
        else
            print("Building column of " ..tostring(columnHeight) .." blocks")
            buildColumn(columnHeight)
            print("Done")
        end
    end
end

init({...})
