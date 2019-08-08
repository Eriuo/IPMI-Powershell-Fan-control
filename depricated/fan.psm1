
function Get-FanCore {
  Param( $IP, $user, $pass, $name )
  $command = './ipmitool.exe -I lanplus -H ' +$IP + ' -U ' +
              $user + ' -P ' +
              $pass + ' sensor reading "' +
              $name + '"'

  $stringtemp = Invoke-Expression -Command $command
  $stringtemp = [String]$stringtemp
  return @($name, [int]$stringtemp.Substring($stringtemp.IndexOf("|")+1))
}

function Get-Fan {
  Param( $IP, $user, $pass, $arg )

  $items = New-Object PSObject
  Foreach ($n in $arg) {
    $item = Get-FanCore $IP $user $pass $n
    $items | Add-Member -MemberType NoteProperty -Name $item[0] -Value $item[1]
  }

  return $items
}
