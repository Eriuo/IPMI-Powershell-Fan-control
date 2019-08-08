
$IP   = "192.168.1.90"
$user = "root"
$pass = "soffan12"
$ipmiToolDir = "C:\Program Files (x86)\Dell\SysMgt\bmc"

$fsmin = [Int]4
$fsmax = [Int]50

$tmin = [Int]30
$tmax = [Int]75

$tin = @{
    min = [Int]30
    max = [Int]75
}

$fin = @{
    min = [Int]4
    max = [Int]50
}

# Temperatures
$cpu = @{
  min = $settings.tmin
  max = $settings.tmax
  name = "Temp"
}

$inlet = @{
  min  = [Int]15
  max  = [Int]60
  name = "Inlet Temp"
}

$exhaust = @{
  min  = [Int]15
  max  = [Int]60
  name = "Exhaust Temp"
}

$fans = @{
  min   = $settings.fmin
  max   = $settings.fmax
  names = @("Fan1", "Fan2", "Fan3", "Fan4", "Fan5", "Fan6")
}

# Testing functions
function map_100 {

    Write-Host "TMP - DEC - HEX"
    for ($i = 0; $i -lt 100; $i+=1) {
        $t = (map $i $tmin $tmax $fsmin $fsmax)
        $h = $t | hexi

        if ($t -le 9) { $t = "0$t" }
        if ($i -le 9) {
            Write-Host " 0$i - $t  - $h"
        } else {
            Write-Host " $i - $t  - $h"
        }
    }
}

function hashmap_100 {

    Write-Host "TMP - DEC - HEX"
    Write-Host "==============="
    for ($i = 0; $i -lt 100; $i+=1) {
        $t = (hashmap $i $tin $fin)
        $h = $t | hexi

        if ($t -le 9) { $t = "0$t" }
        if ($t.length -lt 3) { $t = "0$t" }

        $x = $i
        if ($x -le 9) { $x = "0$x" }
        if ($x.length -lt 3) { $x = "0$x" }

        Write-Host "$x - $t - 0$h"
    }
}
