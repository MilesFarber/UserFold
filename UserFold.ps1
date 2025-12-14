try {
  Write-Output "Test"
}
catch {
  Write-Output "An error occurred: $_"
  Write-Host "Message:" $_.Exception.Message
  Write-Host "Details:" $_.ErrorDetails
  Write-Host "Stack:" $_.ScriptStackTrace
}
finally {
  Write-Output "Execution completed."
}
