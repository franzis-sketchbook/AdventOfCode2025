function Set-DialPosition {
    param (
        [char]$direction,
        [int]$steps,
        [int]$dialPosition,
        [ref]$zeroCounter
    )
    if ($direction -eq 'L') {
        [int]$pos = ($dialPosition - $steps)

        while ($pos -lt -100) {
            $pos = $pos + 100
            $zeroCounter.Value = $zeroCounter.Value + 1;
        }
        if ($pos -eq 0) {
            $zeroCounter.Value = $zeroCounter.Value + 1;
            return 0;
        }
        if ($pos -lt 0) {
            $pos = 100 + $pos
            if ($dialPosition -ne 0) {
                $zeroCounter.Value = $zeroCounter.Value + 1;
            }
        }
        return $pos;
    }
    if ($direction -eq 'R') {
        [int]$pos = ($dialPosition + $steps)

        while ($pos -gt 100) {
            $pos = $pos - 100;
            $zeroCounter.Value = $zeroCounter.Value + 1;
        }
        if ($pos -eq 100 -or $pos -eq 0) {
            $zeroCounter.Value = $zeroCounter.Value + 1;
            return 0;
        }

        return $pos;
    }
}

$dialPosition = 50;
$zeroCounter = 0;
$x = 0;

Get-Content -Path "/home/palluthe-nass/repos/AdventOfCode2025/samples/1stDecember.txt" | ForEach-Object {
    Write-Host "Zeile: $_"
    $var = $dialPosition;
    $direction = [char]$_.Substring(0,1);
    $steps = [int]$_.Substring(1);
    
    $dialPosition = Set-DialPosition -direction $direction -steps $steps -dialPosition $dialPosition -zeroCounter ([ref]$zeroCounter);

    Write-Host "New Dial Position: $dialPosition";
    Write-Host "Zero-Counter so far: $zeroCounter";

    if ($dialPosition -eq $var -and $dialPosition -eq 0) {
        Write-Host "Dial position unchanged.";
        $x = $x +1;
    }
}

Write-Host "Zero-Counter: $zeroCounter"
Write-Host "Unchanged at zero: $x"
