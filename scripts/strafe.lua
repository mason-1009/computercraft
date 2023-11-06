local args = {...}

function strafeLeft(times)
    turtle.turnLeft()
    for i = 1, times, 1 do
        turtle.forward()
    end
    turtle.turnRight()
end

function strafeRight(times)
    turtle.turnRight()
    for i = 1, times, 1 do
        turtle.forward()
    end
    turtle.turnLeft()
end

if table.getn(args) < 2 then
    print("Usage: strafe.exe <direction> <times>")
else
    if args[1] == "left" then
        strafeLeft(args[2] * 1)
    elseif args[1] == "right" then
        strafeRight(args[2] * 1)
    end
end
