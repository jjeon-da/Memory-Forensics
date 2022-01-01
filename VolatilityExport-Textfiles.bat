::user-friendly Volatility dump batch script
::dependencies- Python 2.7 or 3 and Volatility
::Author- t0rt3rra
::
::
:: turns off display
@ECHO OFF

TITLE "Export RAM dumps to Textfiles using Volatility"


::creates folder and launches Volatility from absolute filepath on user-drive, change letters as needed.
cd..
c:
::u:
::d:
::f:
::g:
::z:
mkdir Volatility
cd Volatility

ECHO ---Need to establish working parameters---
SET /P mem_Path=Enter path to memory file:
volatility -f "%mem_Path%" imageinfo >> imageinfo.txt
ECHO ---USER DO---  Check "imageinfo.txt" for profile name....
PAUSE
::Enter profile name from imageinfo
SET /P profile_Name=Enter profile name from imageinfo:
ECHO continuing...
ECHO Initiating process scan.  Please be patient.
volatility -f "%mem_Path%" --profile="%profile_Name%" pstree >> pstree.txt
volatility -f "%mem_Path%" --profile="%profile_Name%" psscan >> psscan.txt
volatility -f "%mem_Path%" --profile="%profile_Name%" psxview >> psxview.txt
volatility -f "%mem_Path%" --profile="%profile_Name%" envars >> envars.txt
volatility -f "%mem_Path%" --profile="%profile_Name%" getsids >> getsids.txt
volatility -f "%mem_Path%" --profile="%profile_Name%" svcscan >> active-services.txt
ECHO Process scan dumping completed...
ECHO Initiating network connections scan.
volatility -f "%mem_Path%" --profile="%profile_Name%" netscan >> netscan.txt
volatility -f "%mem_Path%" --profile="%profile_Name%" iphistory >> iphistory.txt
volatility -f "%mem_Path%" --profile="%profile_Name%" connections >> active-connections.txt
ECHO Network connections dump completed...
ECHO Searching for suspicious filetypes.
volatility -f "%mem_Path%" --profile="%profile_Name%" filescan >> filescan.txt
volatility -f "%mem_Path%" --profile="%profile_Name%" malfind >> malfind.txt
volatility -f "%mem_Path%" --profile="%profile_Name%" dlllist >> dlllist.txt
ECHO Potential Malware files dump completed...
ECHO Scanning Registry Hive.
volatility -f "%mem_Path%" --profile="%profile_Name%" hivelist >> hivelist.txt
volatility -f "%mem_Path%" --profile="%profile_Name%" hivescan >> hivescan.txt
volatility -f "%mem_Path%" --profile="%profile_Name%" hashdump >> hashdump.txt
ECHO Registry Hive scanning completed...
ECHO searching for active user accounts.
volatility -f "%mem_Path%" --profile="%profile_Name%" printkey >> printkey.txt
volatility -f "%mem_Path%" --profile="%profile_Name%" printkey -K "SAM\Domains\Account" >> printkey-sam-domains-account.txt
volatility -f "%mem_Path%" --profile="%profile_Name%" printkey -K "SAM\Domains\Account\Users" >> printkey-sam-domains-account.txt
volatility -f "%mem_Path%" --profile="%profile_Name%" printkey -K "SAM\Domains\Account\Users\Names" >> printkey-sam-domains-account.txt
volatility -f "%mem_Path%" --profile="%profile_Name%" userhandles >> user-handles.txt
ECHO User accounts collected from Registry Hive
ECHO Dumping clipboard, Notepad, screenshots.
volatility -f "%mem_Path%" --profile="%profile_Name%" clipboard >> clipboard.txt
volatility -f "%mem_Path%" --profile="%profile_Name%" notepad >> notepad.txt
volatility -f "%mem_Path%" --profile="%profile_Name%" deskscan >> desktop.txt
mkdir Screenshots
volatility -f "%mem_Path%" --profile="%profile_Name%" screenshots Screenshots
ECHO Action complete...
ECHO Dumping System information.
volatility -f "%mem_Path%" --profile="%profile_Name%" windows >> desktop-windows.txt
::box.txt
volatility -f "%mem_Path%" --profile="%profile_Name%"verinfo >> version-info.txt
::vmware-info.txt
volatility -f "%mem_Path%" --profile="%profile_Name%"crashinfo >> crashdumpinfo.txt
volatility -f "%mem_Path%" --profile="%profile_Name%"sessions >> sessions.txt
ECHO System info dump complete.
ECHO Script finished.
PAUSE