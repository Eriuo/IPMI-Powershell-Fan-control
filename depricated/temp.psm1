
function Get-TempCore {
  Param( $IP, $user, $pass, $name )
  $command = './ipmitool.exe -I lanplus -H ' +$IP + ' -U ' +
              $user + ' -P ' +
              $pass + ' sensor reading "' +
              $name + '"'

  $stringtemp = Invoke-Expression -Command $command
  $stringtemp = [String]$stringtemp
  return @($name, [Int]$stringtemp.Substring($stringtemp.IndexOf("|")+2))
}


function Get-Temp {
  Param( $IP, $user, $pass, $arg )

  $items = New-Object PSObject
  Foreach ($n in $arg) {
    $item = Get-TempCore $IP $user $pass $n
    $items | Add-Member -MemberType NoteProperty -Name $item[0] -Value $item[1]
  }

  return $items
}
