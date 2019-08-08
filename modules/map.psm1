
function map{
    param( $temp, $t_min, $t_max, $p_min, $p_max )

    $tmp = ($temp - $t_min) * ($p_max - $p_min) / ($t_max - $t_min) - $p_min * $p_min

    if ($tmp -lt $p_min) { $tmp = $p_min }
    elseif ($tmp -gt $p_max) { $tmp = $p_max }

    # Speed multiplier; Will create very skewed values!
    $tmp *= 1

    $round = [Int]$([math]::Round($tmp))

    return $round
}

function hexi {
    Param( $value )
    process {
        if ($_) { $value = $_ }

        # Round the value incase we receive a double/float etc.
        $round = [Int]$([math]::Round($value))
        $hex = [System.String]::Format('{0:X}', $round)

        # If the hex
        if ($hex.length -lt 2) {
            return "0$hex"
        } else {
            return "$hex"
       }
    }
}

# Extention of map using hashes as input.
function hashmap{
    param( $temp, $tin, $fin )

    return (map $temp $tin.min $tin.max $fin.min $fin.max)
}
