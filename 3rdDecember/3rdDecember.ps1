#$content = Get-Content -Path "C:\Users\fburm\AdventOfCode2025\3rdDecember\samples\3rdDecemberPart1_Training.txt";
$content = Get-Content -Path "/home/palluthe-nass/repos/AdventOfCode2025/3rdDecember/samples/3rdDecemberPart1_Training.txt";
$sumOfInvalidIds = 0;

$banks = $content.Split("\n") ;
Write-Host "Banks: " $banks;

$banks | ForEach-Object { 
    $charBatteries = $_.ToCharArray();
    $highestNumber = 0;
    Write-Host "Char Batteries: " $charBatteries;

    foreach ($number in $charBatteries) {
    if ($number -gt $highestNumber) {
        $highestNumber = $number
    }

    $indexOfHighestNumber = [Array]::IndexOf($charBatteries, $highestNumber);
    Write-Host $highestNumber;
    Write-Host $indexOfHighestNumber;

    
    foreach ($number in $charBatteries[0..3] + $charBatteries[5..14]) {
    if ($number -gt $highestNumber) {
        $highestNumber = $number
    }
}
};
Write-Host "Char Batteries: " $charBatteriesArray;
