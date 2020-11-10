
$UpperLimit = 2*[math]::PI
Write-Output "Upper Limit: $UpperLimit"

for ($i = 0;$i -le $UpperLimit;$i=$i+0.00001)
{
    $Equation1 = 2*[math]::pow([math]::cos($i),2)
    $Equation2 = (3/[math]::exp($i)) + (3*$i)-3

    Write-Output "i: $i"
    Write-Output "Equation1: $Equation1"
    Write-Output "Equation2: $Equation2"

    $Differnce = $Equation1 - $Equation2
    Write-Output "Difference: $Difference"

    Write-Output "***************************"
}