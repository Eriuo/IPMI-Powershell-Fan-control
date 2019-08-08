
Write-Host "Importing modules."
Get-Childitem -Path "$PSScriptRoot\modules" -Recurse -include "*.psm1" | % { Import-Module $_.FullName }

# Specify the values that corresponds to your system setup.
$self = @{
  ip          = "192.168.0.120"
  user        = "root"
  pass        = "calvin"
  ipmiToolDir = "C:\Program Files (x86)\Dell\SysMgt\bmc"
}

# Commands used inside to set manual/auto/speed.
$commands = @{
  manual = ("raw 0x30 0x30 0x01 0x00")
  auto   = ("raw 0x30 0x30 0x01 0x01")
  speed  = ("raw 0x30 0x30 0x02 0xff 0x")
}

$settings = @{
  # Temperature min/max in degrees, C.
  tmin = [Int]40
  tmax = [Int]70
  # Fan speed min/max in percentage, %.
  fmin = [Int]4
  fmax = [Int]50
}

# Specify your temperature input, algorithm and output.
# Don't forget to edit below in the main loop as well.
function genTemp {
  Param( $t1, $t2 )

  $result = [Math]::Round(([Int]$t1 + [Int]$t2) / 2)

  return $result
}

# ---------------- #
# End of settings. #
# ---------------- #

# Init
init $self $commands

# Main loop
while ( $true ) {
  try {
    $answer = runCommand $self 'sdr list full'
    $parsed = simpleParseValues $answer

    # Edit based on your genTemp function.
    $temp = genTemp $parsed.temp $parsed.temp2

    hashstr $self $temp $settings
  }
  catch {
    # Script is unable to remote to the IPMI host or failed to run IPMI tools.
    callError $_
  }
}
