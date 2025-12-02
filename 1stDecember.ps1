function Set-DialPosition {
    param (
        [char]$direction,
        [int]$steps,
        [int]$dialPosition,
        [ref]$zeroCounter
    )
    if ($direction -eq 'L') {
        [int]$pos = ($dialPosition - $steps)

        if ($pos -eq 0) {
            $zeroCounter.Value = $zeroCounter.Value + 1;
            return 0;
        }
        if ($pos -lt 0) {
            $pos = 100 + $pos
        }
        return $pos;
    }
    if ($direction -eq 'R') {
        [int]$pos = ($dialPosition + $steps)

        if ($pos -eq 100) {
            $zeroCounter.Value = $zeroCounter.Value + 1;
            return 0;
        }
        if ($pos -gt 100) {
            $pos = ($pos - 100);
        }
        return $pos;
    }
    #$script:dialPosition = $position
   #Write-Host "Dial position set to $script:dialPosition"
}

$dialPosition = 50;
$zeroCounter = 0;
$x = 0;

Get-Content -Path "C:\Users\fburm\Desktop\1stDecember.txt" | ForEach-Object {
    Write-Host "Zeile: $_"
    $var = $dialPosition;
    $direction = [char]$_.Substring(0,1);
    if ($_.Length -eq 2) {
        $steps = [int]$_.Substring(1);
    } else {
        $steps = [int]$_.Substring(1,2);
    }    

    $dialPosition = Set-DialPosition -direction $direction -steps $steps -dialPosition $dialPosition -zeroCounter ([ref]$zeroCounter);

    Write-Host "New Dial Position: $dialPosition";

    if ($dialPosition -eq $var -and $dialPosition -eq 0) {
        Write-Host "Dial position unchanged.";
        $x = $x +1;
    }
}

Write-Host "Zero-Counter: $zeroCounter"
Write-Host "Unchanged at zero: $x"
