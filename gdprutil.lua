-- gdprutil.lua

local M = {}

M.name = "gdprutil"
M.version = "0.1"
M.verbose = false

-- References:
-- https://en.wikipedia.org/wiki/Member_state_of_the_European_Union
-- https://www.iso.org/iso-3166-country-codes.html
-- https://en.wikipedia.org/wiki/ISO_3166-1
-- https://en.wikipedia.org/wiki/General_Data_Protection_Regulation

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
	-- the following non-EU-but-EEA counties should probably also be included (formal adoption still pending as of this writing)
	["IS"] = "Iceland",
	["LI"] = "Liechtenstein",
	["NO"] = "Norway",
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


--- anonymizes an ip address by replacing the lower-order octet(s) with innocuous characters
-- @param ip String the IPv4 address to be anonymized
-- @param noctets Number Optional the number of lower-order octets to strip, valid range 1 - 2, default 1
-- @param char String a single character string to be used as replacement, default "x"
-- @return String the anonymized ip address, with lower-order octet numbers replaced with the replacement char
-- @usage technically this is a **replacement** method rather than a **stripping** method.
--   however, using a blank ("") replacement char will function as a strip method.
-- @usage this function will **attempt** to provide a "useful" string reponse even if an invalid input ip is given,
--   but results cannot be guaranteed, so try to pass only valid ip address strings
--
M.anonymizeIP = function(ip,noctets,char)
	if (type(ip)~="string") then
		if (M.verbose) then
			print("gdprutil.anonymizeIP():  invalid ip address provided: " .. tostring(ip) .. " (" .. type(ip) .. ")")
		end
		ip = ""
	end
	if (type(noctets)~="number") then noctets = 1 end
	noctets = math.max(1, math.min(2, noctets))
	if (type(char)~="string") then char = "x" end
	if (#char > 1) then char = string.sub(char,1,1) end
	local i,j,a,b = string.find(ip, noctets==1 and "(%d+%.%d+%.%d+)(%.%d+)" or "(%d+%.%d+)(%.%d+%.%d+)")
	if (i and char=="") then b = string.gsub(b,"%.","") end
	return i and a..string.gsub(i and b,"%d",char) or string.gsub("0.0.0.0", "%d", char)
end


return M
