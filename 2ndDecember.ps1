$content = Get-Content -Path "C:\Users\fburm\AdventOfCode2025\samples\2ndDecemberPart2.txt";
$sumOfInvalidIds = 0;


function IsInvalidPart1 {
    param (
        [string]$number
    )
    $part1 = $number.Substring(0, $number.Length / 2);
    $part2 = $number.Substring($number.Length / 2);
    return ($part1 -eq $part2);
}

function IsInvalidPart2 {
    param (
        [string]$number
    )

    if ($number.Length -lt 2) {
        return $false;
    }
    
    if ($number.Length % 2 -eq 0) {
        $part1 = $number.Substring(0, $number.Length / 2);
        $part2 = $number.Substring($number.Length / 2);
        if ($part1 -eq $part2) {
            return $true;
        }
    }

    if ($number.Length % 3 -eq 0) {
        $part3 = $number.Substring(0, $number.Length / 3);
        $part4 = $number.Substring($number.Length / 3, $number.Length / 3);
        $part5 = $number.Substring(2 * ($number.Length / 3));
        if (($part3 -eq $part4) -and ($part4 -eq $part5)) {
            return $true;
        }
    }

    $isValid = $true;
    if ($number.Length % 5 -ne 0 -or $number.Length % 7 -eq 0 -or $number.Length % 9 -eq 0) {
        $char = $number.Substring(0, 1);
        $number | ForEach-Object {
            if ($_ -ne $char) {
                $isValid = $false;
            }
        }
        if ($isValid) {
            return $true;
        }
    }

    if ($number.Length % 8 -eq 0) {
        $part1 = $number.Substring(0, $number.Length / 4);
        $part2 = $number.Substring($number.Length / 4, $number.Length / 4);
        $part3 = $number.Substring(2 * ($number.Length / 4), $number.Length / 4);
        $part4 = $number.Substring(3 * ($number.Length / 4));
        if (($part1 -eq $part2) -and ($part2 -eq $part3) -and ($part3 -eq $part4)) {
            return $true;
        }
    }

    if ($number.Length % 10 -eq 0) {
        $part1 = $number.Substring(0, $number.Length / 5);
        $part2 = $number.Substring($number.Length / 5);
        if (($part1 -eq $part2)) {
            return $true;
        }
    }
    return $false;
}

$ranges = $content.Split(",") ;
Write-Host "Ranges: " $ranges;

$ranges | ForEach-Object {
    $bounds = $_.Split("-")
    [PSCustomObject]@{
        Start = [long]$bounds[0]
        End   = [long]$bounds[1]
    }
} | ForEach-Object {
    Write-Host "Start: $($_.Start), End: $($_.End)"
    for ($i = $_.Start; $i -le $_.End; $i++) {
        if (IsInvalidPart2 $i) {
            Write-Host "Invalid ID: $i"
            $sumOfInvalidIds += $i;
        }
    }
}

Write-Host "Sum of invalid IDs: $sumOfInvalidIds";