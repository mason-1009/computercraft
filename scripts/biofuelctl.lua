--define program macros
cnsts = {}

--assign program macros
cnsts["Monitor"] = "monitor_5"

cnsts["Solid Firebox"] = "solid_fueled_boiler_firebox_0"
cnsts["Liquid Firebox"] = "liquid_fueled_boiler_firebox_1"

cnsts["Ethanol Tank"] = "rcirontankvalvetile_0"
cnsts["Biofuel Tank"] = "rcirontankvalvetile_1"
cnsts["Juice Tank"] = "rcirontankvalvetile_2"
cnsts["Sludge Tank"] = "rcirontankvalvetile_4"

cnsts["Energy Cell"] = "tile_thermalexpansion_cell_reinforced_name_0"

cnsts["Fermenter 1"] = "factory_3_name_3"
cnsts["Fermenter 2"] = "factory_3_name_4"

cnsts["Still 1"] = "factory_6_name_3"
cnsts["Still 2"] = "factory_6_name_4"
cnsts["Still 3"] = "factory_6_name_5"

--define global peripheral objects
monitor = nil

sfirebox = nil
lfirebox = nil

ethanolTank = nil
biofuelTank = nil
juiceTank = nil
sludgeTank = nil

encell = nil

fermenter1 = nil
fermenter2 = nil

still1 = nil
still2 = nil
still3 = nil

--define functions
function attachPeripherals()
    print(string.format("Attaching monitor.id=%s", cnsts["Monitor"]))
    monitor = peripheral.wrap(cnsts["Monitor"])

    print(string.format("Attaching firebox.liquid.id=%s", cnsts["Liquid Firebox"]))
    lfirebox = peripheral.wrap(cnsts["Liquid Firebox"])

    print(string.format("Attaching firebox.solid.id=%s", cnsts["Solid Firebox"]))
    sfirebox = peripheral.wrap(cnsts["Solid Firebox"])

    print(string.format("Attaching tank.ethanol.id=%s", cnsts["Ethanol Tank"]))
    ethanolTank = peripheral.wrap(cnsts["Ethanol Tank"])

    print(string.format("Attaching tank.biofuel.id=%s", cnsts["Biofuel Tank"]))
    biofuelTank = peripheral.wrap(cnsts["Biofuel Tank"])

    print(string.format("Attaching tank.juice.id=%s", cnsts["Juice Tank"]))
    juiceTank = peripheral.wrap(cnsts["Juice Tank"])

    print(string.format("Attaching tank.sludge.id=%s", cnsts["Sludge Tank"]))
    sludgeTank = peripheral.wrap(cnsts["Sludge Tank"])

    print(string.format("Attaching machine.still1.id=%s", cnsts["Still 1"]))
    still1 = peripheral.wrap(cnsts["Still 1"])

    print(string.format("Attaching machine.still2.id=%s", cnsts["Still 2"]))
    still2 = peripheral.wrap(cnsts["Still 2"])

    print(string.format("Attaching machine.still3.id=%s", cnsts["Still 3"]))
    still3 = peripheral.wrap(cnsts["Still 3"])

    print(string.format("Attaching machine.fermenter1.id=%s", cnsts["Fermenter 1"]))
    fermenter1 = peripheral.wrap(cnsts["Fermenter 1"])

    print(string.format("Attaching machine.fermenter2.id=%s", cnsts["Fermenter 2"]))
    fermenter2 = peripheral.wrap(cnsts["Fermenter 2"])

    print(string.format("Attaching machine.energycell.id=%s", cnsts["Energy Cell"]))
    encell = peripheral.wrap(cnsts["Energy Cell"])
end

function padBufferStr(input1, width)
    return (input1..string.rep(" ", width-string.len(input1)))
end

function padBufferStrEndJustified(input1, input2, width)
    return (input1..string.rep(" ", width-string.len(input1..input2))..input2)
end

function convBooleanRunning(status)
    if status == true then
        return "running"
    else
        return "stopped"
    end
end

function getTankLevel(tankInfo)
    local total = 0
    for index = 1, table.getn(tankInfo), 1 do
        if tankInfo[index].contents == nil then
            total = total + 0
        else
            total = total + tankInfo[index].contents["amount"]
        end
    end
    return total
end

function drawScreen(scrWidth, scrHeight)
    local buffer = nil

    monitor.setCursorPos(1, 1)
    monitor.write("Biofuel Processing Plant")

    monitor.setCursorPos(1, 2)
    monitor.write(string.rep("-", scrWidth))

    monitor.setCursorPos(1, scrHeight)
    monitor.write(string.rep("-", scrWidth))

    buffer = padBufferStr(string.format("Solid Firebox:   %s", convBooleanRunning(sfirebox.isBurning())), scrWidth)
    monitor.setCursorPos(1, 4)
    monitor.write(buffer)

    buffer = padBufferStr(string.format("Liquid Firebox:  %s", convBooleanRunning(lfirebox.isBurning())), scrWidth)
    monitor.setCursorPos(1, 5)
    monitor.write(buffer)

    buffer = padBufferStr(string.format("Fermenter 1:     %s", convBooleanRunning(fermenter1.hasWork())), scrWidth)
    monitor.setCursorPos(1, 7)
    monitor.write(buffer)

    buffer = padBufferStr(string.format("Fermenter 2:     %s", convBooleanRunning(fermenter2.hasWork())), scrWidth)
    monitor.setCursorPos(1, 8)
    monitor.write(buffer)

    buffer = padBufferStr(string.format("Still 1:         %s", convBooleanRunning(still1.hasWork())), scrWidth)
    monitor.setCursorPos(1, 10)
    monitor.write(buffer)

    buffer = padBufferStr(string.format("Still 2:         %s", convBooleanRunning(still2.hasWork())), scrWidth)
    monitor.setCursorPos(1, 11)
    monitor.write(buffer)

    buffer = padBufferStr(string.format("Still 3:         %s", convBooleanRunning(still3.hasWork())), scrWidth)
    monitor.setCursorPos(1, 12)
    monitor.write(buffer)

    buffer = padBufferStr(string.format("Firebox #1 Temp: %iC", lfirebox.getTemperature()), scrWidth)
    monitor.setCursorPos(1, 14)
    monitor.write(buffer)

    buffer = padBufferStr(string.format("Firebox #2 Temp: %iC", sfirebox.getTemperature()), scrWidth)
    monitor.setCursorPos(1, 15)
    monitor.write(buffer)

    buffer = padBufferStr(string.format("Stored Energy:   %i RF", encell.getEnergyStored()), scrWidth)
    monitor.setCursorPos(1, 17)
    monitor.write(buffer)

    buffer = padBufferStr(string.format("Biofuel Tank:    %i mB", getTankLevel(biofuelTank.getTankInfo())), scrWidth)
    monitor.setCursorPos(1, 19)
    monitor.write(buffer)

    buffer = padBufferStr(string.format("Ethanol Tank:    %i mB", getTankLevel(ethanolTank.getTankInfo())), scrWidth)
    monitor.setCursorPos(1, 20)
    monitor.write(buffer)

    buffer = padBufferStr(string.format("Juice Tank:      %i mB", getTankLevel(juiceTank.getTankInfo())), scrWidth)
    monitor.setCursorPos(1, 21)
    monitor.write(buffer)

    buffer = padBufferStr(string.format("Sludge Tank:     %i mB", getTankLevel(sludgeTank.getTankInfo())), scrWidth)
    monitor.setCursorPos(1, 22)
    monitor.write(buffer)
end

function ctlLoop()
    monitor.setTextScale(1)
    local width, height = monitor.getSize()
    --draw screen loop
    while true do
        drawScreen(width, height)
    end
end

function init(args)
    if table.getn(args) > 0 then
        print("You put arguments into the program")
        print("Why?")
    end

    print("Attaching peripheral devices on network...")
    attachPeripherals()
    --start main control loop
    ctlLoop()
end

init({...})
