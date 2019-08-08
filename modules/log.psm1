
function callError {
  Param( $err )

  Write-Host "Failed to read/write to IPMI, host might be offline."
  Write-Host "--------------------------------------------------------------------"
  Write-Host $err
  Write-Host "--------------------------------------------------------------------"
}
