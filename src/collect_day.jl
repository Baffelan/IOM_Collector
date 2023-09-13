
# Conda.pip_interop(true)
# Conda.pip("install", "eventregistry")
function collect_day(userID,newsapikey,backhost,backdb,backuser,backpassword)
    collector(userID,Dates.today()-Day(1),newsapikey,backhost,backdb,backuser,backpassword)
end
