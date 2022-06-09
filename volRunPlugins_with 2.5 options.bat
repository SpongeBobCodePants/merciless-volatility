##########################################################################################################
#PURPOSE
##Run commonly used volatility 2.5 plugins against a memory image
#INSTRUCTIONS
##1) Enter your own strings for file, profile and path
######$memDumpFile - path and file for the  memory image
######$memProfile - the volatility memory profile for the memory image (based on OS)
######$outputPath - Directory where output should go. Do NOT end in a backslash.
##2) Comment out any plugins you don't want to execute and/or reorder based on priority.
##3) Run the script.##4) 
##4) View results as plugins complete. Find evil and save the world or at least earn your paycheck.
##Note: The volatility executable was renamed to v.exe out of total laziness.
##########################################################################################################

SET "memDumpFile=C:\samplePath\memoryImage.mem"
SET "memProfile=Win10x64_18362" #If not certain, run vol.py --info
SET "outputPath=C:\samplePath\sampleOutputFolder"

echo off

REM IMAGE INFORMATION
echo "IMAGE INFORMATION"
echo "----------------"

if not exist "%outputPath%\imageInformation" mkdir "%outputPath%\imageInformation"

v.exe -f "%memDumpFile%"  imageinfo > "%outputPath%\imageInformation\imageInfo.txt"

REM PROCESS LISTINGS
echo "PROCESS LISTINGS"
echo "----------------"

if not exist "%outputPath%\processListings" mkdir "%outputPath%\processListings"

v.exe -f "%memDumpFile%" --profile=%memProfile% pslist > "%outputPath%\processListings\pslist.txt"

v.exe -f "%memDumpFile%" --profile=%memProfile% psscan > "%outputPath%\processListings\psscan.txt"

v.exe -f "%memDumpFile%" --profile=%memProfile% pstree > "%outputPath%\processListings\pstree.txt"

v.exe -f "%memDumpFile%" --profile=%memProfile% psxview -R > "%outputPath%\processListings\psxview.txt"

REM PROCESS INFORMATION
echo "PROCESS INFORMATION"
echo "-------------------"

if not exist "%outputPath%\processInformation" mkdir "%outputPath%\processInformation"

if not exist "%outputPath%\processInformation\memdump" mkdir "%outputPath%\processInformation\memdump"

v.exe -f "%memDumpFile%" --profile=%memProfile% dlllist > "%outputPath%\processInformation\dlllist.txt"

v.exe -f "%memDumpFile%" --profile=%memProfile% cmdline > "%outputPath%\processInformation\cmdline.txt"

REM memdump takes a lot of time and space (moved to end of script)

REM handles takes a lot of time to run (moved to end of script)

v.exe -f "%memDumpFile%" --profile=%memProfile% privs > "%outputPath%\processInformation\privs.txt"

v.exe -f "%memDumpFile%" --profile=%memProfile% getsids > "%outputPath%\processInformation\getsids.txt"

v.exe -f "%memDumpFile%" --profile=%memProfile% envars > "%outputPath%\processInformation\envars.txt"

REM PE FILE EXTRACTION
echo "PE FILE EXTRACTION"
echo "------------------"

if not exist "%outputPath%\peFileExtraction" mkdir "%outputPath%\peFileExtraction"

if not exist "%outputPath%\peFileExtraction\moddump" mkdir "%outputPath%\peFileExtraction\moddump"

if not exist "%outputPath%\peFileExtraction\procdump" mkdir "%outputPath%\peFileExtraction\procdump"

if not exist "%outputPath%\peFileExtraction\dlldump" mkdir "%outputPath%\peFileExtraction\dlldump"

v.exe -f "%memDumpFile%" --profile=%memProfile% moddump --dump-dir="%outputPath%\PeFileExtraction\moddump" > "%outputPath%\PeFileExtraction\moddump.txt"

v.exe -f "%memDumpFile%" --profile=%memProfile% procdump --dump-dir="%outputPath%\PeFileExtraction\procdump" > "%outputPath%\PeFileExtraction\procdump.txt"

v.exe -f "%memDumpFile%" --profile=%memProfile% dlldump --dump-dir="%outputPath%\PeFileExtraction\dlldump" > "%outputPath%\PeFileExtraction\dlldump.txt"

REM INJECTED CODE
echo "INJECTED CODE"
echo "-------------"

if not exist "%outputPath%\injectedCode" mkdir "%outputPath%\injectedCode"

REM malfind takes a lot of time to run (moved to end of script)

v.exe -f "%memDumpFile%" --profile=%memProfile% ldrmodules > "%outputPath%\injectedCode\ldrmodules.txt"

REM NETWORKING INFORMATION
echo "NETWORKING INFORMATION"
echo "----------------------"

if not exist "%outputPath%\networkingInformation" mkdir "%outputPath%\networkingInformation

v.exe -f "%memDumpFile%" --profile=%memProfile% connections > "%outputPath%\networkingInformation\connections.txt"

v.exe -f "%memDumpFile%" --profile=%memProfile% sockets > "%outputPath%\networkingInformation\sockets.txt"

v.exe -f "%memDumpFile%" --profile=%memProfile% connscan > "%outputPath%\networkingInformation\connscan.txt"

v.exe -f "%memDumpFile%" --profile=%memProfile% sockscan > "%outputPath%\networkingInformation\sockscan.txt"

v.exe -f "%memDumpFile%" --profile=%memProfile% netscan > "%outputPath%\networkingInformation\netscan.txt"



REM KERNEL OBJECTS
echo "KERNEL OBJECTS"
echo "----------------------"

if not exist "%outputPath%\kernelObjects" mkdir "%outputPath%\kernelObjects"

v.exe -f "%memDumpFile%" --profile=%memProfile% driverscan> "%outputPath%\kernelObjects\driverscan.txt"

v.exe -f "%memDumpFile%" --profile=%memProfile% mutantscan > "%outputPath%\kernelObjects\mutantscan.txt"

v.exe -f "%memDumpFile%" --profile=%memProfile% filescan > "%outputPath%\kernelObjects\filescan.txt"

v.exe -f "%memDumpFile%" --profile=%memProfile% symlinkscan > "%outputPath%\kernelObjects\symlinkscan.txt"



REM REGISTRY
echo "REGISTRY"
echo "--------"

if not exist "%outputPath%\registry" mkdir "%outputPath%\registry"

if not exist "%outputPath%\registry\dumpRegistry" mkdir "%outputPath%\registry\dumpRegistry"

v.exe -f "%memDumpFile%" --profile=%memProfile% hivelist > "%outputPath%\registry\hivelist.txt"

v.exe -f "%memDumpFile%" --profile=%memProfile% userassist > "%outputPath%\registry\userassist.txt"

v.exe -f "%memDumpFile%" --profile=%memProfile% shellbags > "%outputPath%\registry\shellbags.txt"

v.exe -f "%memDumpFile%" --profile=%memProfile% shimcache > "%outputPath%\registry\shimcache.txt"

v.exe -f "%memDumpFile%" --profile=%memProfile% amcache > "%outputPath%\registry\amcache.txt"

v.exe -f "%memDumpFile%" --profile=%memProfile% dumpregistry --dump-dir="%outputPath%\registry\dumpRegistry" > "%outputPath%\registry\dumpRegistry.txt"

REM GUI MEMORY
echo "GUI MEMORY"
echo "----------"

if not exist "%outputPath%\guiMemory" mkdir "%outputPath%\guiMemory"

if not exist "%outputPath%\guiMemory\screenshot" mkdir "%outputPath%\guiMemory\screenshot"

v.exe -f "%memDumpFile%" --profile=%memProfile% sessions > "%outputPath%\guiMemory\sessions.txt"

v.exe -f "%memDumpFile%" --profile=%memProfile% wndscan > "%outputPath%\guiMemory\wndscan.txt"

v.exe -f "%memDumpFile%" --profile=%memProfile% deskscan > "%outputPath%\guiMemory\deskscan.txt"

v.exe -f "%memDumpFile%" --profile=%memProfile% atoms > "%outputPath%\guiMemory\atoms.txt"

v.exe -f "%memDumpFile%" --profile=%memProfile% atomscan > "%outputPath%\guiMemory\atomscan.txt"

v.exe -f "%memDumpFile%" --profile=%memProfile% clipboard > "%outputPath%\guiMemory\clipboard.txt"

REM messagehooks took many hours to run. Commenting out for now.
REM v.exe -f "%memDumpFile%" --profile=%memProfile% messagehooks > "%outputPath%\guiMemory\messagehooks.txt"

v.exe -f "%memDumpFile%" --profile=%memProfile% screenshot --dump-dir="%outputPath%\guiMemory\screenshot" > "%outputPath%\guiMemory\screenshot.txt"

v.exe -f "%memDumpFile%" --profile=%memProfile% windows > "%outputPath%\guiMemory\windows.txt"

v.exe -f "%memDumpFile%" --profile=%memProfile% wintree > "%outputPath%\guiMemory\wintree.txt"

REM PASSWORD RECOVERY
echo "PASSWORD RECOVERY"
echo "-----------------"

if not exist "%outputPath%\passwordRecovery" mkdir "%outputPath%\passwordRecovery"

v.exe -f "%memDumpFile%" --profile=%memProfile% lsadump > "%outputPath%\passwordRecovery\lsadump.txt"

v.exe -f "%memDumpFile%" --profile=%memProfile% cachedump > "%outputPath%\passwordRecovery\cacheddump.txt"

v.exe -f "%memDumpFile%" --profile=%memProfile% hashdump > "%outputPath%\passwordRecovery\hashdump.txt"

v.exe -f "%memDumpFile%" --profile=%memProfile% openvpn > "%outputPath%\passwordRecovery\openvpn.txt"

REM DISK ENCRYPTION
echo "DISK ENCRYPTION"
echo "-----------------"

if not exist "%outputPath%\diskEncryption" mkdir "%outputPath%\diskEncryption"

v.exe -f "%memDumpFile%" --profile=%memProfile% truecryptsummary > "%outputPath%\diskEncryption\truecryptsummary.txt"

v.exe -f "%memDumpFile%" --profile=%memProfile% truecryptpassphrase > "%outputPath%\diskEncryption\truecryptpassphrase.txt"

v.exe -f "%memDumpFile%" --profile=%memProfile% truecryptmaster > "%outputPath%\diskEncryption\truecryptmaster.txt"

REM MALWARE SPECIFIC
echo "MALWARE SPECIFIC"
echo "-----------------"

if not exist "%outputPath%\malwareSpecific" mkdir "%outputPath%\malwareSpecific"

v.exe -f "%memDumpFile%" --profile=%memProfile% zeusscan > "%outputPath%\malwareSpecific\zeusscan.txt"

v.exe -f "%memDumpFile%" --profile=%memProfile% citadelscan > "%outputPath%\malwareSpecific\citadelscan.txt"

v.exe -f "%memDumpFile%" --profile=%memProfile% poisonivyconfig > "%outputPath%\malwareSpecific\poisonivyconfig.txt"

v.exe -f "%memDumpFile%" --profile=%memProfile% javaratscan > "%outputPath%\malwareSpecific\javaratscan.txt"



REM LOGS / HISTORIES (put towards end of script, may take a long time to run)
echo "LOGS / HISTORIES"
echo "----------------"

if not exist "%outputPath%\logsHistories" mkdir "%outputPath%\logsHistories"

if not exist "%outputPath%\logsHistories\evtlogs" mkdir "%outputPath%\logsHistories\evtlogs"

v.exe -f "%memDumpFile%" --profile=%memProfile% evtlogs -S --dump-dir="%outputPath%\logsHistories\evtlogs" > "%outputPath%\logsHistories\evtlogs.txt"

v.exe -f "%memDumpFile%" --profile=%memProfile% cmdscan > "%outputPath%\logsHistories\cmdscan.txt"

v.exe -f "%memDumpFile%" --profile=%memProfile% iehistory > "%outputPath%\logsHistories\iehistory.txt"

v.exe -f "%memDumpFile%" --profile=%memProfile% svcscan -v > "%outputPath%\logsHistories\svcscan.txt" REM may take hours to run. Consider moving to end of script. Actually, may have been iehistory causing delay...verify

REM TIMELINES (put towards end of script, may take a long time to run)
echo "TIMELINES"
echo "--------"

if not exist "%outputPath%\timelines" mkdir "%outputPath%\timelines"

v.exe -f "%memDumpFile%" --profile=%memProfile% timeliner --output=body > "%outputPath%\timelines\timeliner.txt"

v.exe -f "%memDumpFile%" --profile=%memProfile% shellbags --output=body > "%outputPath%\timelines\shellbags.txt"

v.exe -f "%memDumpFile%" --profile=%memProfile% mftparser --output=body > "%outputPath%\timelines\mftparser.txt"

REM FILE SYSTEM RESOURCES  (put towards end of script, may take a long time to run)
echo "FILE SYSTEM RESOURCES"
echo "---------------------"

if not exist "%outputPath%\fileSystemResources" mkdir "%outputPath%\fileSystemResources"

if not exist "%outputPath%\fileSystemResources\mftparser" mkdir "%outputPath%\fileSystemResources\mftparser"

if not exist "%outputPath%\fileSystemResources\dumpfiles" mkdir "%outputPath%\fileSystemResources\dumpfiles"

v.exe -f "%memDumpFile%" --profile=%memProfile% mftparser --output=body --dump-dir="%outputPath%\fileSystemResources\mftparser" > "%outputPath%\fileSystemResources\mftparser.txt"

REM dumpfiles may take a lot of time and space
v.exe -f "%memDumpFile%" --profile=%memProfile% dumpfiles --dump-dir="%outputPath%\fileSystemResources\dumpfiles"  > "%outputPath%\fileSystemResources\dumpfiles.txt"

REM This plugin is not included by default. Need to add manually and research options.
v.exe --plugins=plugins -f "%memDumpFile%" --profile=%memProfile% usnparser > "%outputPath%\fileSystemResources\usnparser.txt"

REM AUTORUNS (put towards end of script, may take a long time to run...well, saw an instance where it didn't take too long either so...more research)
echo "AUTORUNS"
echo "---------------------"

REM This plugin does not appear to be included by default. Need to add manually.
v.exe --plugins=plugins -f "%memDumpFile%" --profile=%memProfile% autoruns -v > "%outputPath%\autoruns.txt"

REM SERVICEDIFF
v.exe --plugins=plugins -f "%memDumpFile%" --profile=%memProfile% servicediff > "%outputPath%\servicediff.txt"

REM PLUGINS THAT TAKE LONGER TO RUN / MOVED TO END OF THIS SCRIPT
=================================================================
echo "LONG RUNNING PLUGINS -- MALFIND"
echo "---------------------"
REM INJECTED CODE - MALFIND
if not exist "%outputPath%\injectedCode\malfind" mkdir "%outputPath%\injectedCode\malfind"

v.exe -f "%memDumpFile%" --profile=%memProfile% malfind --dump-dir="%outputPath%\injectedCode\malfind" > "%outputPath%\injectedCode\malfind.txt"

echo "LONG RUNNING PLUGINS -- HANDLES"
echo "---------------------"
REM PROCESS INFORMATION - HANDLES
v.exe -f "%memDumpFile%" --profile=%memProfile% handles > "%outputPath%\processInformation\handles.txt"

echo "LONG RUNNING PLUGINS -- MEMDUMP"
echo "---------------------"
REM PROCESS INFORMATION - MEMDUMP ***this may result in 100s of GB of data
v.exe -f "%memDumpFile%" --profile=%memProfile% memdump --dump-dir="%outputPath%\processInformation\memdump" > "%outputPath%\processInformation\memdump.txt"
=================================================================

timeout /t -1 REM PAUSE INDEFINITELY
