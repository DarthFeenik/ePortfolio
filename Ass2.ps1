#  List any processes that are hogging the CPU. Provide an explanation of your test in your
#  code’s documentation. Submit an example run of your script detecting a CPU hogging
#  process.
#
#  Need Variables, if statements and greather than to find processes.
#  Assume multiple variables for the CPU and the list of process greater than selected number...
#  storing data of the top 5 lines from the CPU in variable $CPUHOG
#
#
#  $CPUHOG - var for storing that CPU description
#  $over - int 1000, the chosen number to compare to processes. Anything over 1000 should get listed. 
#  need an if statement to find if $CPUHOG is greater than or equal to $over

function CPUHog
{
	# Need to calc the total number of cores for the CPU
	$CPUNum = (Get-CIMInstance -class Win32_processor | Measure-Object -Sum NumberOfLogicalProcessors).Sum
	
	#Need to see what processes are using the CPU and calculate if their use is too high
	$CPUCount =  (Get-Counter "\Process(*)\% Processor Time").CounterSamples | Where-Object {$_.InstanceName -NotLike "_total" -and $_.InstanceName -NotLike "idle"} | Where-Object {$_.CookedValue / $CPUNum  -gt 5} | Select InstanceName, CookedValue 
		
		#Divides the processes use by the number of cores and lists the top processes that are hogging the cpu
		foreach($_ in $CPUCount)
		{
			Write-Host $_.InstanceName, ($_.CookedValue / $CPUNum) | Out-File -FilePath \CPUHog.txt
		}
	
	}





#  Check that Windows Defender antimalware toolkit is enabled.
# 
#  Will need to check MpComputerStatus to see if windows defender tools are enabled
#  AMRunning mode is the status of the windows defender, enabled, passive or disabled etc.
#  AMServiceEnabled is for telling if the Antimalware service is enabled or disabled
#  AntiSpywareEnable is telling if the spyware component is enabled or not
#  AntivirusEnabled lists if the antivirus compnent is enabled or not
#
#
#  To check all the status' I will store their data in variables and call on them to compare if they are true or false


#$service = Get-MpComputerStatus | Select-Object -Property AMServiceEnabled
#$spyware = Get-MpComputerStatus | Select-Object -Property AntispywareEnabled
#$virus = Get-MpComputerStatus | Select-Object -Property AntivirusEnabled

function DefenderEnabled
{
	#Check if the AM Service is enabled or enable = true, if not it will display an error
	if ((Get-MPComputerStatus).AMServiceEnabled -eq 1)
	{
		Write-Host "AMService is Disabled!"
	}
	
}




Create a software inventory that is a list of approved programs. Check that only
approved programs are installed. Submit your list of approved programs. Remove one of
the approved programs from your list. Submit an example run of your script detecting an
unapproved program. 






Create a list of services approved for running. Check that only approved services are
running. Remove one of the approved services from your list. Submit an example run of
your script detecting an unapproved service.



5. Please implement one of the following three tasks: either part a, part b or part c. You do
not need to implement all of part a, b and c.
a. Check the Windows machine has been hardened against DNS poisoning
attempts that use failed DNS requests. That is, check the registry property
HKLM\SOFTWARE\Policies\Microsoft\Windows NT\DNSClient\EnableMulticast
is set to 0. On some computers, the key might instead be
HKLM\SOFTWARE\Policies\Microsoft\WindowsNT\DNSClient\EnableMulticast.
b. Check Cortana has been disabled on the Windows PC. That is, ensure that
HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search\AllowCortana
is set to 0.
c. Check that the Network Time Protocol (NTP) is enabled. That is, check that NTP
Enabled of HKLM\SYSTEM\State\DateTime is set to 1.
