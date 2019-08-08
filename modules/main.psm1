
function str {
    Param( $self, $temp, $tin, $fin )

    $value = hashmap $temp $tin $fin
    $hex   = hexi $value

    $speed = "raw 0x30 0x30 0x02 0xff 0x" + $hex

    $date = Get-Date

    # Threshold, if reached, start auto mode.
    # Else set fan speed to the given hex value.
    if ($temp -gt $tin.max) {
        Write-Host "Past maximum <$temp C>, turning on auto @ $date"
        # ./IPMItool -I lanplust -H ... -U ... -P ... raw ...
        # Check other values to get an overview of the situation.
        # DO: Act on the given values.

        $com = runCommand $self ("raw 0x30 0x30 0x01 0x01")

        # Logging functions
        # ...

    } elseif ($temp -lt $tin.min) {
        Write-Host "Below minimum <$temp C>, <$value%>, logging <sdr list full> @ $date"
        # ./IPMItool -I lanplust -H ... -U ... -P ... raw ... $hex
        # Check other values to get an overview of the situation.
        # DO: Act on the given values.

        $com = runCommand $self $speed

        # Logging functions
        # ...

    } else {
        Write-Host "Good temperatures <$temp C>, <$value%>, @ $date"
        # ./IPMItool -I lanplust -H ... -U ... -P ... raw ... $hex
        # Healthcheck.io request (We cool)

        $com = runCommand $self $speed

    }
}

function hashstr {
  Param( $self, $temp, $settings )

  $tin = @{
    min = $settings.tmin
    max = $settings.tmax
  }

  $fin = @{
    min = $settings.fmin
    max = $settings.fmax
  }

  str $self $temp $tin $fin
}

function runCommand {
    Param( $self, $command )

    $IP   = $self.IP
    $user = $self.user
    $pass = $self.pass


    $command = './ipmitool.exe -I lanplus -H ' +$IP + ' -U ' +
                $user + ' -P ' +
                $pass + ' ' +
                $command

    $stringtemp = Invoke-Expression -Command $command
    #$stringtemp = [String]$stringtemp -split
    return $stringtemp
    # ./IPMItool -I lanplust -H $IP -U $user -P $pass $command
}
