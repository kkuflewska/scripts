param(
    [Parameter(Mandatory=$true)]
    [ValidateSet('+', '-', '*', '/')]
    [String] $operation = "+", 
    [Parameter(Mandatory=$true)]
    [Double] $num1, 
    [Parameter(Mandatory=$true)]
    [Double] $num2
)
# double and not null are enforced on parameter level

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
