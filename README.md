# IPMITool
 Powershell IPMI tool for R720.

# Requirements
 - [Dell EMC OpenManage BMC Utility](https://www.dell.com/support/home/nz/en/nzbsd1/Drivers/DriversDetails?driverId=9NGFJ]), IPMI tool used inside the script.
 - [Healthcheck.io](https://healthchecks.io/), if you want emails if the script happens to fail.

# Usage
Change the necessary values for your system, know that using this script for a different system than the R720 might require changes to some functions. Read all information inside Control.ps1.

```
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
```

Quote from NoLooseEnd:
> TLDR; I take NO responsibility if you mess up anything.

# Credit
 - Code based on Maddog1929's [IPMI PS tool](https://github.com/Maddog1929/Powershell-IPMI-script) for R710.
 - Ideas found from NoLooseEnd's [IPMI bash tool](https://github.com/NoLooseEnds/Scripts/tree/master/R710-IPMI-TEMP) for R710.
