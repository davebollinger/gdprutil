-- gdprutil.lua

local M = {}

M.name = "gdprutil"
M.version = "0.1"
M.verbose = false

-- References:
-- https://en.wikipedia.org/wiki/Member_state_of_the_European_Union
-- https://www.iso.org/iso-3166-country-codes.html
-- https://en.wikipedia.org/wiki/ISO_3166-1

M.EUCountryCodeList = {
	["AT"] = "Austria",
	["BE"] = "Belgium",
	["BG"] = "Bulgaria",
	["HR"] = "Croatia",
	["CY"] = "Cypress",
	["CZ"] = "Czechia", -- aka "Czech Republic"
	["DK"] = "Denmark",
	["EE"] = "Estonia",
	["FI"] = "Finland",
	["FR"] = "France",
	["DE"] = "Germany",
	["GR"] = "Greece",
	["HU"] = "Hungary",
	["IE"] = "Ireland",
	["IT"] = "Italy",
	["LV"] = "Latvia",
	["LT"] = "Lithuania",
	["LU"] = "Luxembourg",
	["MT"] = "Malta",
	["NL"] = "Netherlands",
	["PL"] = "Poland",
	["PT"] = "Portugal",
	["RO"] = "Romania",
	["SK"] = "Slovakia",
	["SI"] = "Slovenia",
	["ES"] = "Spain",
	["SE"] = "Sweden",
	["GB"] = "United Kingdom",
}

---
-- Tests if the given country code represents an EU member country
-- @param country String Optional The two-character ISO 3166-1 country code
--   if not provided, and running in Corona SDK environment, will look up value from system
-- @return Boolean
--   True if country code represents an EU member country
--   False if country code does not represent an EU member country, or could not be determined
--
M.isEUCountry = function(country)
	---------------------------------------
	-- handle default value (if Corona SDK)
	---------------------------------------
	if (not country) then
		if ((type(system)=="table") and (type(system.getPreference)=="function")) then
			country = system.getPreference("locale", "country", "string")
		end
	end
	---------------------------------------
	-- handle missing/invalid values
	---------------------------------------
	if (type(country) ~= "string") then
		if (M.verbose) then
			print("gdprutil.isEUCountry():  Invalid Country Code, result = false")
		end
		return false
	end
	---------------------------------------
	-- perform lookup
	---------------------------------------
	local result = M.EUCountryCodeList[country] ~= nil
	if (M.verbose) then
		print("gdprutil.isEUCountry():  Country Code '" .. country .. "', result = " .. tostring(result))
	end
	return result
end

return M
