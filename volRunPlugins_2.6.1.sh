##########################################################################################################
#PURPOSE
##Run commonly used volatility 2.6.1 plugins against a memory image
#INSTRUCTIONS
##1) Enter your own strings for file, profile and path
######$memDumpFile - path and file for the  memory image
######$memProfile - the volatility memory profile for the memory image (based on OS)
######$outputPath - Directory where output should go. Do NOT end in a backslash.
##2) Comment out any plugins you don't want to execute and/or reorder based on priority.
##3) Run the script.
##4) View results as plugins complete. Find evil and save the world or at least earn your paycheck, brah.
##########################################################################################################


memDumpFile="/samplePath/sampleEndPointName.mem"
memProfile="Win10x64_18362" #If not certain, run vol.py --info
outputPath="/samplePath/sampleOutputFolder"

#echo off

# IMAGE INFORMATION
echo "IMAGE INFORMATION"
echo "----------------"

mkdir -p $outputPath"/imageInformation"

python vol.py -f $memDumpFile  imageinfo > $outputPath"/imageInformation/imageInfo.txt"

# PROCESS LISTINGS
echo "PROCESS LISTINGS"
echo "----------------"

mkdir -p $outputPath"/processListings"

python vol.py -f $memDumpFile --profile=$memProfile pslist > $outputPath"/processListings/pslist.txt"

python vol.py -f $memDumpFile --profile=$memProfile psscan > $outputPath"/processListings/psscan.txt"

python vol.py -f $memDumpFile --profile=$memProfile pstree > $outputPath"/processListings/pstree.txt"

python vol.py -f $memDumpFile --profile=$memProfile psxview > $outputPath"/processListings/psxview.txt" #This command is used whether a function is visible in all fields like pslist,psscan,thrdproc,else will show false

python vol.py -f $memDumpFile --profile=$memProfile psxview -R > $outputPath"/processListings/psxview-R.txt" #Most of the processes will be the child of another hence this will not be visible in one field but this does not mean that the process is malicious hence the above command will give an output of “okay” for such instances.

# PROCESS INFORMATION
echo "PROCESS INFORMATION"
echo "-------------------"

mkdir -p $outputPath"/processInformation" 

mkdir -p $outputPath"/processInformation/memdump"

python vol.py -f $memDumpFile --profile=$memProfile dlllist > $outputPath"/processInformation/dlllist.txt"

python vol.py -f $memDumpFile --profile=$memProfile cmdline > $outputPath"/processInformation/cmdline.txt"

# memdump takes a lot of time and space (moved to end of script)

# handles takes a lot of time to run (moved to end of script)

python vol.py -f $memDumpFile --profile=$memProfile privs > $outputPath"/processInformation/privs.txt"

python vol.py -f $memDumpFile --profile=$memProfile getsids > $outputPath"/processInformation/getsids.txt"

python vol.py -f $memDumpFile --profile=$memProfile envars > $outputPath"/processInformation/envars.txt"

# PE FILE EXTRACTION
echo "PE FILE EXTRACTION"
echo "------------------"

mkdir -p $outputPath"/peFileExtraction"

mkdir -p $outputPath"/peFileExtraction/moddump" 

mkdir -p $outputPath"/peFileExtraction/procdump" 

mkdir -p $outputPath"/peFileExtraction/dlldump" 

python vol.py -f $memDumpFile --profile=$memProfile moddump --dump-dir=$outputPath"/PeFileExtraction/moddump" > $outputPath"/PeFileExtraction/moddump.txt"

python vol.py -f $memDumpFile --profile=$memProfile procdump --dump-dir=$outputPath"/PeFileExtraction/procdump" > $outputPath"/PeFileExtraction/procdump.txt"

python vol.py -f $memDumpFile --profile=$memProfile dlldump --dump-dir=$outputPath"/PeFileExtraction/dlldump" > $outputPath"/PeFileExtraction/dlldump.txt"

# INJECTED CODE
echo "INJECTED CODE"
echo "-------------"

mkdir -p $outputPath"/injectedCode" 

# malfind takes a lot of time to run (moved to end of script)

python vol.py -f $memDumpFile --profile=$memProfile ldrmodules > $outputPath"/injectedCode/ldrmodules.txt"

# NETWORKING INFORMATION
echo "NETWORKING INFORMATION"
echo "----------------------"

mkdir -p $outputPath"/networkingInformation" 

python vol.py -f $memDumpFile --profile=$memProfile connections > $outputPath"/networkingInformation/connections.txt"

python vol.py -f $memDumpFile --profile=$memProfile sockets > $outputPath"/networkingInformation/sockets.txt"

python vol.py -f $memDumpFile --profile=$memProfile connscan > $outputPath"/networkingInformation/connscan.txt"

python vol.py -f $memDumpFile --profile=$memProfile sockscan > $outputPath"/networkingInformation/sockscan.txt"

python vol.py -f $memDumpFile --profile=$memProfile netscan > $outputPath"/networkingInformation/netscan.txt"


# KERNEL OBJECTS
echo "KERNEL OBJECTS"
echo "----------------------"

mkdir -p $outputPath"/kernelObjects" 

python vol.py -f $memDumpFile --profile=$memProfile driverscan> $outputPath"/kernelObjects/driverscan.txt"

python vol.py -f $memDumpFile --profile=$memProfile mutantscan > $outputPath"/kernelObjects/mutantscan.txt"

python vol.py -f $memDumpFile --profile=$memProfile filescan > $outputPath"/kernelObjects/filescan.txt"

python vol.py -f $memDumpFile --profile=$memProfile symlinkscan > $outputPath"/kernelObjects/symlinkscan.txt"

# REGISTRY
echo "REGISTRY"
echo "--------"

mkdir -p $outputPath"/registry"

mkdir -p $outputPath"/registry/dumpRegistry"

python vol.py -f $memDumpFile --profile=$memProfile hivelist > $outputPath"/registry/hivelist.txt"

python vol.py -f $memDumpFile --profile=$memProfile userassist > $outputPath"/registry/userassist.txt"

python vol.py -f $memDumpFile --profile=$memProfile shellbags > $outputPath"/registry/shellbags.txt"

python vol.py -f $memDumpFile --profile=$memProfile shimcache > $outputPath"/registry/shimcache.txt"

python vol.py -f $memDumpFile --profile=$memProfile amcache > $outputPath"/registry/amcache.txt"

python vol.py -f $memDumpFile --profile=$memProfile dumpregistry --dump-dir=$outputPath"/registry/dumpRegistry" > $outputPath"/registry/dumpRegistry.txt"

# GUI MEMORY
echo "GUI MEMORY"
echo "----------"

mkdir -p $outputPath"/guiMemory" 

mkdir -p $outputPath"/guiMemory/screenshot" 

python vol.py -f $memDumpFile --profile=$memProfile sessions > $outputPath"/guiMemory/sessions.txt"

python vol.py -f $memDumpFile --profile=$memProfile wndscan > $outputPath"/guiMemory/wndscan.txt"

python vol.py -f $memDumpFile --profile=$memProfile deskscan > $outputPath"/guiMemory/deskscan.txt"

python vol.py -f $memDumpFile --profile=$memProfile atoms > $outputPath"/guiMemory/atoms.txt"

python vol.py -f $memDumpFile --profile=$memProfile atomscan > $outputPath"/guiMemory/atomscan.txt"

python vol.py -f $memDumpFile --profile=$memProfile clipboard > $outputPath"/guiMemory/clipboard.txt"

# messagehooks took many hours to run. Commenting out for now.
# python vol.py -f $memDumpFile --profile=$memProfile messagehooks > "$outputPath/guiMemory/messagehooks.txt"

python vol.py -f $memDumpFile --profile=$memProfile screenshot --dump-dir=$outputPath"/guiMemory/screenshot" > $outputPath"/guiMemory/screenshot.txt"

python vol.py -f $memDumpFile --profile=$memProfile windows > $outputPath"/guiMemory/windows.txt"

python vol.py -f $memDumpFile --profile=$memProfile wintree > $outputPath"/guiMemory/wintree.txt"

# PASSWORD RECOVERY
echo "PASSWORD RECOVERY"
echo "-----------------"

mkdir -p $outputPath"/passwordRecovery"

python vol.py -f $memDumpFile --profile=$memProfile lsadump > $outputPath"/passwordRecovery/lsadump.txt"

python vol.py -f $memDumpFile --profile=$memProfile cachedump > $outputPath"/passwordRecovery/cacheddump.txt"

python vol.py -f $memDumpFile --profile=$memProfile hashdump > $outputPath"/passwordRecovery/hashdump.txt"

python vol.py -f $memDumpFile --profile=$memProfile openvpn > $outputPath"/passwordRecovery/openvpn.txt"

# DISK ENCRYPTION
echo "DISK ENCRYPTION"
echo "-----------------"

mkdir -p $outputPath"/diskEncryption"

python vol.py -f $memDumpFile --profile=$memProfile truecryptsummary > $outputPath"/diskEncryption/truecryptsummary.txt"

python vol.py -f $memDumpFile --profile=$memProfile truecryptpassphrase > $outputPath"/diskEncryption/truecryptpassphrase.txt"

python vol.py -f $memDumpFile --profile=$memProfile truecryptmaster > $outputPath"/diskEncryption/truecryptmaster.txt"

# MALWARE SPECIFIC
echo "MALWARE SPECIFIC"
echo "-----------------"

mkdir -p $outputPath"/malwareSpecific" 

python vol.py -f $memDumpFile --profile=$memProfile zeusscan > $outputPath"/malwareSpecific/zeusscan.txt"

python vol.py -f $memDumpFile --profile=$memProfile citadelscan > $outputPath"/malwareSpecific/citadelscan.txt"

python vol.py -f $memDumpFile --profile=$memProfile poisonivyconfig > $outputPath"/malwareSpecific/poisonivyconfig.txt"

python vol.py -f $memDumpFile --profile=$memProfile javaratscan > $outputPath"/malwareSpecific/javaratscan.txt"



# LOGS / HISTORIES (put towards end of script, may take a long time to run)
echo "LOGS / HISTORIES"
echo "----------------"

mkdir -p $outputPath"/logsHistories" 

mkdir -p $outputPath"/logsHistories/evtlogs" 

python vol.py -f $memDumpFile --profile=$memProfile evtlogs -S --dump-dir=$outputPath"/logsHistories/evtlogs" > $outputPath"/logsHistories/evtlogs.txt"

python vol.py -f $memDumpFile --profile=$memProfile cmdscan > $outputPath"/logsHistories/cmdscan.txt"

python vol.py -f $memDumpFile --profile=$memProfile iehistory > $outputPath"/logsHistories/iehistory.txt"

python vol.py -f $memDumpFile --profile=$memProfile svcscan -v > $outputPath"/logsHistories/svcscan.txt" # may take hours to run. Consider moving to end of script. Actually, may have been iehistory causing delay...verify

# TIMELINES (put towards end of script, may take a long time to run)
echo "TIMELINES"
echo "--------"

mkdir -p $outputPath"/timelines" 

python vol.py -f $memDumpFile --profile=$memProfile timeliner --output=body > $outputPath"/timelines/timeliner.txt"

python vol.py -f $memDumpFile --profile=$memProfile shellbags --output=body > $outputPath"/timelines/shellbags.txt"

python vol.py -f $memDumpFile --profile=$memProfile mftparser --output=body > $outputPath"/timelines/mftparser.txt"

# FILE SYSTEM RESOURCES  (put towards end of script, may take a long time to run)
echo "FILE SYSTEM RESOURCES"
echo "---------------------"

mkdir -p $outputPath"/fileSystemResources" mkdir $outputPath"/fileSystemResources"

mkdir -p  $outputPath"/fileSystemResources/mftparser" mkdir $outputPath"/fileSystemResources/mftparser"

mkdir -p  $outputPath"/fileSystemResources/dumpfiles" mkdir $outputPath"/fileSystemResources/dumpfiles"

python vol.py -f $memDumpFile --profile=$memProfile mftparser --output=body --dump-dir=$outputPath"/fileSystemResources/mftparser" > $outputPath"/fileSystemResources/mftparser.txt"

# dumpfiles may take a lot of time and space
python vol.py -f $memDumpFile --profile=$memProfile dumpfiles --dump-dir=$outputPath"/fileSystemResources/dumpfiles"  > $outputPath"/fileSystemResources/dumpfiles.txt"

# This plugin is not included by default. Need to add manually and research options.
python vol.py --plugins=plugins -f $memDumpFile --profile=$memProfile usnparser > $outputPath"/fileSystemResources/usnparser.txt"

# AUTORUNS (put towards end of script, may take a long time to run...well, saw an instance where it didn't take too long either so...more research)
echo "AUTORUNS"
echo "---------------------"

# This plugin does not appear to be included by default. Need to add manually.
python vol.py --plugins=plugins -f $memDumpFile --profile=$memProfile autoruns -v > $outputPath"/autoruns.txt"

# SERVICEDIFF
python vol.py --plugins=plugins -f $memDumpFile --profile=$memProfile servicediff > $outputPath"/servicediff.txt"

# PLUGINS THAT TAKE LONGER TO RUN / MOVED TO END OF THIS SCRIPT
##########################################

echo "LONG RUNNING PLUGINS -- MALFIND"
echo "---------------------"
# INJECTED CODE - MALFIND
mkdir -p $outputPath"/injectedCode/malfind"

python vol.py -f $memDumpFile --profile=$memProfile malfind --dump-dir=$outputPath"/injectedCode/malfind" > $outputPath"/injectedCode/malfind.txt"

echo "LONG RUNNING PLUGINS -- HANDLES"
echo "---------------------"
# PROCESS INFORMATION - HANDLES
python vol.py -f $memDumpFile --profile=$memProfile handles > $outputPath"/processInformation/handles.txt"

echo "LONG RUNNING PLUGINS -- MEMDUMP"
echo "---------------------"
# PROCESS INFORMATION - MEMDUMP ***this may result in 100s of GB of data
python vol.py -f $memDumpFile --profile=$memProfile memdump --dump-dir=$outputPath"/processInformation/memdump" > $outputPath"/processInformation/memdump.txt"
##############################################

