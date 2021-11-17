function Read-Date {
	param(
	  [String] $prompt
	)
	$result = $null
	do {
	  $s = Read-Host $prompt
	  if ( $s ) {
		try {
		  $result = Get-Date $s
		  break
		}
		catch [Management.Automation.PSInvalidCastException] {
		  Write-Host "Date not valid"
		}
	  }
	  else {
		break
	  }
	}
	while ( $true )
	$result
  }


Function IsBetweenDates([Datetime]$start,[Datetime]$end)
{
	#$d = get-date

   # Write-Host "Now:" $d
	if (($d -ge $start) -and ($d -le $end))
	{
		return $true
	}
	else
	{
		return $false
	}
}
$workdir = "/home/snoble/Documents/test04"

Clear-Host
$terms = Import-Csv -Path $workdir/Data/data.csv
$d = $(Read-Date "Please Enter a valid date: dd/mm/yyyy") #dev testing input random date(s)
Write-Host "--------------------------------`n"

foreach ($term in $terms) {

	#Write-Host "Checking if todays date: $(Get-Date)"
	#Writ#e-Host "Checking if sample date: $d "

	#Write-Host "Falls in: $($term.TermName) Term $($term.TermNumber) Between : $($term.TermStart) $($term.TermEnd)"
	#Write-Host "Between : $($term.TermStart) $($term.TermEnd)"
	IsBetweenDates $term.TermStart $term.TermEnd #use function

	$DateResult = $(IsBetweenDates $term.TermStart $term.TermEnd) #true/false detection
	#<# if result is true....
	if ( $DateResult ) {
		Write-Host "timeframe hit..."
        Write-Host "Sample date: $d "
        Write-Host "Falls in: $($term.TermName) Term $($term.TermNumber) Between : $($term.TermStart) $($term.TermEnd)"

		break # leave for each loop as today/sample date has been matched with one of the timeframes
	}
	#Write-Host "--------------------------------`n"
	sleep 1

}
Write-Host "Continuation of script post date hit..."
#}

<#
http://sigkillit.com/2015/04/28/determine-if-a-date-is-between-two-dates/
#if ([bool](IsBetweenDates) -ge "1" ) {
	#	Write-Host "Hit....."
#IsBetweenDates "9/1/2021 12:00:00 AM" "11/13/2021 12:00:00 PM"
#>