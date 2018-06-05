-- main.lua, testbed for gdprutil.lua

local gdprutil = require("gdprutil")
gdprutil.verbose = true -- optionally

----------------------
-- isEUCountry() tests
----------------------
print("No argument form:", gdprutil.isEUCountry())
print("Hardcoded pos DE:", gdprutil.isEUCountry("DE"))
print("Hardcoded neg US:", gdprutil.isEUCountry("US"))
print("Hardcoded blank:", gdprutil.isEUCountry(""))
print("Hardcoded invalid:", gdprutil.isEUCountry({}))
print("Manual getpref():", gdprutil.isEUCountry(system.getPreference("locale","country","string")))

----------------------
-- anonymizeIP() tests
----------------------

local function aip(ip)
	print("IP:", ip)
	print("", "AIP1:", gdprutil.anonymizeIP(ip))
	print("", "AIP2:", gdprutil.anonymizeIP(ip,2,"X"))
end
-- good cases:
aip("1.2.3.4")
aip("12.34.45.56")
aip("123.234.135.246")
aip("1.23.234.5")
aip("123.23.123.12")
-- bad cases:
aip("")
aip("bad.no.good.bad")
--[[
aip(nil)
aip(0)
aip(123456)
aip(123.456)
aip(true)
aip(false)
aip({})
aip(function() end)
--]]
