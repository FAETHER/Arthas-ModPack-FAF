local OLDSetupSession = SetupSession

function SetupSession()

    local ModDirectory = 'TotalMayhem'
    local Files = 2377
    local Bytes = 749030784

    LOG('Total Mayhem: ['..string.gsub(debug.getinfo(1).source, ".*\\(.*.lua)", "%1")..', line:'..debug.getinfo(1).currentline..'] - Running from: '..debug.getinfo(1).source..'.')
    LOG('Total Mayhem: ['..string.gsub(debug.getinfo(1).source, ".*\\(.*.lua)", "%1")..', line:'..debug.getinfo(1).currentline..'] - Checking directory /mods/ for '..ModDirectory..'...')
    local FilesInFolder = DiskFindFiles('/mods/', '*.*')
    local modfoundcount = 0
    local modDirectory = ""
    for _, FilepathAndName in FilesInFolder do
        if string.find(FilepathAndName, 'mod_info.lua') then
            if string.find(FilepathAndName, string.lower(ModDirectory)) then
                modfoundcount = modfoundcount + 1
                LOG('Total Mayhem: ['..string.gsub(debug.getinfo(1).source, ".*\\(.*.lua)", "%1")..', line:'..debug.getinfo(1).currentline..'] - Found directory: '..FilepathAndName..'.')
            end
        end
    end
    if modfoundcount == 1 then
        LOG('Total Mayhem: ['..string.gsub(debug.getinfo(1).source, ".*\\(.*.lua)", "%1")..', line:'..debug.getinfo(1).currentline..'] - Check OK. Found '..modfoundcount..' '..ModDirectory..' directory.')
    else
        LOG('Total Mayhem: ['..string.gsub(debug.getinfo(1).source, ".*\\(.*.lua)", "%1")..', line:'..debug.getinfo(1).currentline..'] - Check FAILED! Found '..modfoundcount..' '..ModDirectory..' directories.')
    end
    LOG('Total Mayhem: ['..string.gsub(debug.getinfo(1).source, ".*\\(.*.lua)", "%1")..', line:'..debug.getinfo(1).currentline..'] - Checking files and filesize for '..ModDirectory..'...')
    local FilesInFolder = DiskFindFiles('/mods/'..ModDirectory..'/', '*.*')
    local filecount = 0
    local bytecount = 0
    for _, FilepathAndName in FilesInFolder do
        filecount = filecount + 1
        local fileinfo = DiskGetFileInfo(FilepathAndName)
        bytecount = bytecount + fileinfo.SizeBytes
    end
    local FAIL = false
    if filecount < Files then
        LOG('Total Mayhem: ['..string.gsub(debug.getinfo(1).source, ".*\\(.*.lua)", "%1")..', line:'..debug.getinfo(1).currentline..'] - Check FAILED! Directory: '..ModDirectory..' - Missing '..(Files - filecount)..' files! ('..filecount..'/'..Files..')')
        FAIL = true
    elseif filecount > Files then
        LOG('Total Mayhem: ['..string.gsub(debug.getinfo(1).source, ".*\\(.*.lua)", "%1")..', line:'..debug.getinfo(1).currentline..'] - Check FAILED! Directory: '..ModDirectory..' - Found '..(filecount - Files)..' odd files! ('..filecount..'/'..Files..')')
        FAIL = true
    end
    if bytecount < Bytes then
        LOG('Total Mayhem: ['..string.gsub(debug.getinfo(1).source, ".*\\(.*.lua)", "%1")..', line:'..debug.getinfo(1).currentline..'] - Check FAILED! Directory: '..ModDirectory..' - Missing '..(Bytes - bytecount)..' bytes! ('..bytecount..'/'..Bytes..')')
        FAIL = true
    elseif bytecount > Bytes then
        LOG('Total Mayhem: ['..string.gsub(debug.getinfo(1).source, ".*\\(.*.lua)", "%1")..', line:'..debug.getinfo(1).currentline..'] - Check FAILED! Directory: '..ModDirectory..' - Found '..(bytecount - Bytes)..' odd bytes! ('..bytecount..'/'..Bytes..')')
        FAIL = true
    end
    if not FAIL then
        LOG('Total Mayhem: ['..string.gsub(debug.getinfo(1).source, ".*\\(.*.lua)", "%1")..', line:'..debug.getinfo(1).currentline..'] - Check OK! files: '..filecount..', bytecount: '..bytecount..'.')
    end
    OLDSetupSession()
end
