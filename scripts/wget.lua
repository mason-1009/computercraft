local args = {...}

if table.getn(args) < 2 then
    print("Please specify url and output filename")
else
    local url = args[1]
    local outputFileName = args[2]
    local httpHandle = http.get(url)
    if httpHandle.getResponseCode() ~= 200 then
        print("Resource not available")
    else
        local fileHandle = fs.open(outputFileName, "w")
        print("Writing data to file")
        fileHandle.write(httpHandle.readAll())
        print("Done")
        fileHandle.close()
        httpHandle.close()
    end
end
