--What the fuck did you just fucking say
--about me you little bitch? I'll have you
--know I graduated the top of my class in
--that navy seals...

--defining constants in hash table
hardCoded = {}

hardCoded["Still_1"] = "factory_6_name_0"
hardCoded["Still_2"] = "factory_6_name_1"
hardCoded["Still_3"] = "factory_6_name_2"

hardCoded["Fermenter_1"] = "factory_3_name_1"
hardCoded["Fermenter_2"] = "factory_3_name_2"

hardCoded["Firebox"] = "liquid_fueled_boiler_firebox_0"

hardCoded["Screen"] = "monitor_4"

--defining nil peripheral objects
stills = {}
fermenters = {}

firebox = nil
monitor = nil

function convRunning(input)
    if input then
        return "Running"
    else
        return "Stopped"
    end
end

function padString(inputString, width)
    return (inputString ..string.rep(" ", width-string.len(inputString)))
end

function padStringCenter(string1, string2, width)
    return (string1 ..string.rep(" ", width-(string.len(string1..string2))) ..string2)
end

--defining functions
function drawScreenLoop()
    --get monitor size
    local width, height = monitor.getSize()

    monitor.clear()
    monitor.setTextScale(1)

    --draw header
    monitor.setCursorPos(1, 1)
    monitor.write("BioFuel Processing Status")

    monitor.setCursorPos(1, 2)
    monitor.write(string.rep("-", width))

    --draw footer
    monitor.setCursorPos(1, height)
    monitor.write(string.rep("-", width))

    --create string buffer
    local buffer = nil

    while true do
        
        --draw actual info
        monitor.setCursorPos(1, 4)
        buffer = padString(string.format("Firebox Status: %s", convRunning(firebox.isBurning())), width)
        monitor.write(buffer)

        monitor.setCursorPos(1, 5)
        buffer = padString(string.format("  Firebox Temp: %i degrees", firebox.getTemperature()), width)
        monitor.write(buffer)

        monitor.setCursorPos(1, 7)
        buffer = padString(string.format("Still #1 Status: %s", convRunning(stills[1].hasWork())), width)
        monitor.write(buffer)

        monitor.setCursorPos(1, 8)
        buffer = padString(string.format("Still #2 Status: %s", convRunning(stills[2].hasWork())), width)
        monitor.write(buffer)

        monitor.setCursorPos(1, 9)
        buffer = padString(string.format("Still #3 Status: %s", convRunning(stills[3].hasWork())), width)
        monitor.write(buffer)

        monitor.setCursorPos(1, 11)
        buffer = padString(string.format("Fermenter #1 Status: %s", convRunning(fermenters[1].hasWork())), width)
        monitor.write(buffer)

        monitor.setCursorPos(1, 12)
        buffer = padString(string.format("Fermenter #2 Status: %s", convRunning(fermenters[2].hasWork())), width)
        monitor.write(buffer)

        monitor.setCursorPos(1, 14)
        buffer = padString(string.format("System Clock: %i", os.clock()), width)
        monitor.write(buffer)
    end
end

function init()
    term.clear()
    term.setCursorPos(1, 1)

    print("Starting...")

    --attaching peripherals
    stills[1] = peripheral.wrap(hardCoded["Still_1"])
    print("Attached Still #1")
    print(string.format("id=%s", hardCoded["Still_1"]))

    stills[2] = peripheral.wrap(hardCoded["Still_2"])
    print("Attached Still #2")
    print(string.format("id=%s", hardCoded["Still_2"]))

    stills[3] = peripheral.wrap(hardCoded["Still_3"])
    print("Attached Still #3")
    print(string.format("id=%s", hardCoded["Still_3"]))

    fermenters[1] = peripheral.wrap(hardCoded["Fermenter_1"])
    print("Attached Fermenter #1")
    print(string.format("id=%s", hardCoded["Fermenter_1"]))

    fermenters[2] = peripheral.wrap(hardCoded["Fermenter_2"])
    print("Attached Fermenter #2")
    print(string.format("id=%s", hardCoded["Fermenter_2"]))

    firebox = peripheral.wrap(hardCoded["Firebox"])
    print("Attached Liquid Fueled Firebox")
    print(string.format("id=%s", hardCoded["Firebox"]))

    monitor = peripheral.wrap(hardCoded["Screen"])
    print("Attached external monitor")
    print(string.format("id=%s", hardCoded["Screen"]))

    print("Beginning screen update loop...")
    print("Starting monitor...")
    print("Started")

    drawScreenLoop()
end

init()
