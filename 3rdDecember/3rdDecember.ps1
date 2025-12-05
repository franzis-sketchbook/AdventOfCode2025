$content = Get-Content -Path "C:\Users\fburm\AdventOfCode2025\3rdDecember\samples\3rdDecemberPart1_Training.txt";
#$content = Get-Content -Path "/home/palluthe-nass/repos/AdventOfCode2025/3rdDecember/samples/3rdDecemberPart1_Training.txt";
$sumOfInvalidIds = 0;

$banks = $content.Split("\n") ;
Write-Host "Banks: " $banks;

$banks | ForEach-Object { 
    $charBatteries = $_.ToCharArray();
    $highestNumber = 0;
    Write-Host "Char Batteries: " $charBatteries;

    for ($k = 9; $k -ge 0; $k--) {
        $indexes = for ($i = 0; $i -lt $charBatteries.Length; $i++) {
            if ($charBatteries[$i] -eq [char]'$k') { $i }
        }
        
        if ($indexes.Count -gt 1) {
            $indexOfHighestNumber = $indexes[-1];
            break;
        }
    }
    
    Write-Host $highestNumber;
    Write-Host $indexOfHighestNumber;
}


Write-Host "Char Batteries: " $charBatteriesArray;
