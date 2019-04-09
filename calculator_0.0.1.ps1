param(
    [Parameter(Mandatory=$true)]
    [ValidateSet('+', '-', '*', '/')]
    [string] $operation = "+", 
    [Parameter(Mandatory=$true)]
    [double] $num1string, 
    [Parameter(Mandatory=$true)]
    [double] $num2string
)

#Check if variables used in this script are valid:
# double and not null are now enforced on parameter level
#$num1 = $num1String -as [Double]
#$ok1 = $num1 -ne $NULL
#$num2 = $num2String -as [Double]
#$ok2 = $num2 -ne $NULL

if (-not $ok1 -or -not $ok2) { 
    write-warning 'You must enter a numeric value' 
    Exit 
}

if ($operation -eq '+') {
    Write-Host 'Result: ' ($num1 + $num2)

} elseif ($operation -eq '-') {
    Write-Host 'Result: ' ($num1 - $num2)  
    
} elseif ($operation -eq '*') {
    Write-Host 'Result: ' ($num1 * $num2) 

} elseif ($operation -eq '/') {
    if ($num2 -eq '0') {
    Write-Host 'You cannot divide by zero!'
    } else {
        Write-Host 'Result: ' ($num1 / $num2) 
    }

} else {
	Write-Host 'You have not typed a valid operator, please run the program again.'
}


read-host 'Press ENTER to continue...'
