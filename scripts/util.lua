
-- Define constants
LEFT = 1
RIGHT = 2

UP = 3
DOWN = 4

FORWARD = 5
BACK = 6

function move(direction, distance)
    for i=1, distance do
        if direction == FORWARD then
            -- Check for obstacles
            while turtle.detect() do
                turtle.dig()
            end
            
            turtle.forward()
            
        elseif direction == BACK then
            turtle.back()
        elseif direction == UP then
            while turtle.detectUp() do
                turtle.digUp()
            end
            turtle.up()
        elseif direction == DOWN then
            while turtle.detectDown() do
                turtle.digDown()
            end
            turtle.down()
        end
    end
end

function fellTree()
    if turtle.detect() then
        turtle.dig()
        turtle.forward()
    else
        return
    end
    
    local treeHeight=0
    
    while turtle.detectUp() do
        turtle.digUp()
        turtle.up()
        treeHeight = treeHeight + 1
    end
    
    -- Return to ground
    for i=1, treeHeight do
        turtle.down()
    end
    
    -- Move back to maintain position
    turtle.back()
end

function strafe(direction, distance)
    if direction == RIGHT then
        turtle.turnRight()
    elseif direction == LEFT then
        turtle.turnLeft()
    end
    
    -- Walk
    for i = 1, distance do
        turtle.forward()
    end
    
    -- Turn back
    if direction == RIGHT then
        turtle.turnLeft()
    elseif direction == LEFT then
        turtle.turnRight()
    end
end

function navVerticalSurface(width, height, callback)
    for x=1, width do
        for y=1, height-1 do
            callback()
            if x%2==0 then
                move(DOWN,1)
            else
                move(UP,1)
            end
        end
        
        callback()
        if x < width then
            strafe(RIGHT,1)
        end
    end
    
    -- Return to origin
    if width%2==0 then
        strafe(LEFT,width-1)
    else
        strafe(LEFT,width-1)
        move(DOWN,height-1)
    end
end

function navVerticalCube(width, height, length, direction, callback)
    for z=1, length do
        navVerticalSurface(width, height, callback)
        if z < length then
            move(direction,1)
        end
    end
end

function navHorizontalSurface(width, length, callback)
    for x=1, width do
        -- Run row
        for y=1, length-1 do
            callback()
            move(FORWARD,1)
        end
        callback()
        
        if x < width then
            if x%2==0 then
                turtle.turnLeft()
                move(FORWARD,1)
                turtle.turnLeft()
            else
                turtle.turnRight()
                move(FORWARD,1)
                turtle.turnRight()
            end
        end
    end
    
    -- Return to origin
    if width%2==0 then
        turtle.turnRight()
        
        move(FORWARD,width-1)
        
        turtle.turnRight()
    else
        turtle.turnLeft()
        move(FORWARD,width-1)
        turtle.turnLeft()
        move(FORWARD,length-1)
        turtle.turnLeft()
        turtle.turnLeft()
    end
end