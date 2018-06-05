# gdprutil
GDPR utilities for Corona SDK

Simple, preliminary tools/utilties for dealing with the EU's GDPR (General Data Protection Regulation) within Corona SDK.

At present, there are two functions:

isEUCountry(), which will return true/false if the provided (or system-detected) country-code can be identified as one of the EU member countries (or an EEA affected country).

anonymizeIP(), which will replace/strip lower-order octets from a IPv4 address, rendering it anonymous.

see source for more formal documentation
