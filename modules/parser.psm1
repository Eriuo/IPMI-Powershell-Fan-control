function parseValues {
  Param( $array )

  $items = @()

  $array | % {
    $firstIndex  = $_.indexOf('|')
    $secondIndex = $_.lastIndexOf('|')

    $name  = ($_.substring(0, $firstIndex)).replace(" ", "")
    $value = $_.substring($firstIndex+1, $secondIndex-$firstIndex-1)

    $value = ($value -split ' ')

    $hash = @{
      name  = $name
      value = $value[1]
      type  = "$($value[2]) $($value[3])"
    }

    $items += (New-Object PSObject -Property $hash)
  }

  return $items
}

function SelectValue {
  Param( $obj, $sel )

  return $obj | Where-Object name -eq $sel
}

function simpleParseValues {
  Param( $array )

  $items = New-Object PSObject

  $array | % {
    $firstIndex  = $_.indexOf('|')
    $secondIndex = $_.lastIndexOf('|')

    $name  = ($_.substring(0, $firstIndex)).replace(" ", "")
    $value = $_.substring($firstIndex+1, $secondIndex-$firstIndex-1)

    $value = ($value -split ' ')

    if ($items."$name") { $name = $name + "2"}

    $items | Add-Member -MemberType NoteProperty -Name $name -Value $value[1]
  }

  return $items
}
