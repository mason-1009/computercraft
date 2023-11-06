local args = {...}

--define global variables
monitor = peripheral.wrap("monitor_0")
encellRoster = {}
monWidth = 0
monHeight = 0

--define functions
function populateRoster(filepath)
    local fileHandle = fs.open(filepath, "r")
    local lineBuffer = ""
    while true do
        lineBuffer = fileHandle.readLine()
        if lineBuffer == nil then
            break
        else
            table.insert(encellRoster, peripheral.wrap(lineBuffer))
        end
    end
    fileHandle.close()
end

function initScreen()
    --uses global monitor variable
    monitor.setTextScale(1.5)
    monWidth, monHeight = monitor.getSize()
    monitor.clear()
end

function redraw()
    monitor.clear()
    monitor.setCursorPos(1, 1)
    monitor.write(string.rep("-", monWidth))
    monitor.setCursorPos(1, monHeight)
    monitor.write(string.rep("-", monWidth))
end

function bufferLineWrite(start, stop, y, text)
    monitor.setCursorPos(start, y)
    monitor.write(text ..string.rep(" ", (stop-start+1)-string.len(text)))
end

function infScreenLoop()
    --loop until everything dies
    while true do
        for screen = 1, table.getn(encellRoster), 1 do
            redraw()
            for cycle = 1, 50, 1 do
                os.sleep(0.1)

                bufferLineWrite(3, monWidth-3, 3, string.format("Cell ID: %i", screen))
                bufferLineWrite(3, monWidth-3, 4,
                    string.format("Energy Stored: %i", encellRoster[screen].getEnergyStored()))
                bufferLineWrite(3, monWidth-3, 5,
                    string.format("Max Energy: %i", encellRoster[screen].getMaxEnergyStored()))
                bufferLineWrite(3, monWidth-3, 6,
                    string.format("Charged: %i percent",
                        math.ceil(encellRoster[screen].getEnergyStored()/encellRoster.getMaxEnergyStored()*100)))
            end
        end
    end
end

function init()
    if table.getn(args) > 0 then
        initScreen()
        populateRoster(args[1])
    end
end
