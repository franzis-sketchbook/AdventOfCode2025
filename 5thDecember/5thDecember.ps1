$content = Get-Content -Path "C:\Users\fburm\AdventOfCode2025\5thDecember\samples\5thDecemberPart1_Training.txt" -Raw

$parts = $content -split '(?:\r?\n){2,}'

$freshIngredients = @()

$parts[1].Split("`n") | ForEach-Object { 
    $line = $_
    Write-Host "Line: $line"
    $parts[0].Split("`n") | ForEach-Object {
        $range = $_.Split("-");
        if ($line -ge $range[0] -and $line -le $range[1]) {
            Write-Host "`tChecking range: $range"
            $freshIngredients += $_
            continue
        }
    }
    Write-Host "`tFresh ingredients so far: $($freshIngredients.Count)"
}

Write-Host "Total fresh ingredients: $($freshIngredients.Count)"