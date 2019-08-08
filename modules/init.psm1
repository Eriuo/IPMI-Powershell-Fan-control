
function init {
  Param( $self, $commands )

  Set-ExecutionPolicy -ExecutionPolicy Unrestricted

  Write-Host "Mapping to IPMITool directory."
  cd $self.ipmiToolDir

  # Turn on manual control over fans.
  Write-Host "Setting fan control to manual."
  try {
    $com = runCommand $self $commands.manual
  }
  catch {
    callError $_
  }

  Write-Host "Starting..."
  Write-Host "===================================================================="
}
