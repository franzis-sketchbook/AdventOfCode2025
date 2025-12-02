$global:dialState = 50 
$global:count = 0 
$challengeInput = Get-Content $args[0]
$part = [int]$args[1]

function Update-DialState {
    param (
        $operator,
        $value
    )
    if ($operator -eq 'R') {    
        if($part -eq 2) {
            $rotations = [Math]::Truncate(($dialState + $value) / 100)
            $global:count += $rotations 
        }
        $global:dialState = ($dialState + $value) % 100
    }
    else {
        $tmp = $dialState - ($value % 100) 
    
        if ($part -eq 2) {
            $base = (100-$dialState) % 100 
            $rotations = [Math]::Truncate(($base + $value) / 100)
            $global:count += $rotations 
        }
    
        if ($tmp -ge 0) {
            $global:dialState = $tmp
        }
        else {
            $global:dialState = 100 + $tmp
        }
    }
    
    if ($part -eq 1 -and $dialState -eq 0) { 
        $global:count = $count + 1
    }
}

ForEach($line in $challengeInput) {
    Update-DialState $line[0] ([int]($line[1..$line.Length] -join ''))
}

Write-Host $count