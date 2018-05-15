-- main.lua, testbed for gdprutil.lua

local gdprutil = require("gdprutil")
gdprutil.verbose = true -- optionally

print("No argument form:", gdprutil.isEUCountry())
print("Hardcoded pos DE:", gdprutil.isEUCountry("DE"))
print("Hardcoded neg US:", gdprutil.isEUCountry("US"))
print("Hardcoded blank:", gdprutil.isEUCountry(""))
print("Hardcoded invalid:", gdprutil.isEUCountry({}))
print("Manual getpref():", gdprutil.isEUCountry(system.getPreference("locale","country","string")))
