--peripheral global object constants
cnsts = {}

cnsts["Monitor"] = ""
cnsts["PIM"] = ""

--define global peripheral objects
monitor = nil
pim = nil

function padCenterString(string1, width)
    local emptySpace = width - string.len(string1)
    local halfWidth = math.floor(emptySpace/2)
    --if string is odd pad one char to left
    --looks good enough
    return (string.rep(emptySpace-halfWidth)..string1..string.rep(" ", halfWidth))
end

function padStringLeft(string1, width)
    return (string.rep(" ", width-string.len(string1))..string1)
end

function padStringRight(string1, width)
    return (string1..string.rep(" ",width-string.len(string)))
end

function playerDetect()
    --get info about screen
    local width, height = monitor.getSize()

    monitor.clear()
    
    monitor.setCursorPos(1, 1)
    monitor.write("Player Detected")

    monitor.setCursorPos(1, 2)
    monitor.write(string.rep("-", width))

    --gather info about player
    local name = pim.getInventoryName()
    local invSize = pim.getInventorySize()
