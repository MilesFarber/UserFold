try {
Write-Output "Fixing Permissions..."
Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope CurrentUser
Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope LocalMachine
Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope Process
Write-Output "This script will now delete your HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders, and recreate it, before the final mapping. This is to prevent any issues with pre-existing values. You can also use this to reset the user folders if something goes wrong."
Write-Output "This will not delete any of your files, but MAKE SURE YOU HAVE AN EXTERNAL BACKUP OF ALL YOUR DATA BEFOREHAND, AND THAT SAID BACKUP IS UNPLUGGED FROM YOUR COMPUTER, IN CASE SOMETHING GOES WRONG."
Read-Host -Prompt "Press Enter thrice to continue..."
Read-Host -Prompt "Press Enter twice to continue...."
Read-Host -Prompt "Press Enter once to continue....."

Write-Output "Resetting HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders..."
$path = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders"
Remove-Item -Path $path -Recurse -Force -ErrorAction SilentlyContinue
New-Item -Path $path | Out-Null
Set-ItemProperty -Path $path -Name "AppData" -Value "%USERPROFILE%\AppData\Roaming" -Type ExpandString
Set-ItemProperty -Path $path -Name "Desktop" -Value "%USERPROFILE%\Desktop" -Type ExpandString
Set-ItemProperty -Path $path -Name "Local AppData" -Value "%USERPROFILE%\AppData\Local" -Type ExpandString
Set-ItemProperty -Path $path -Name "My Music" -Value "%USERPROFILE%\Music" -Type ExpandString
Set-ItemProperty -Path $path -Name "My Pictures" -Value "%USERPROFILE%\Pictures" -Type ExpandString
Set-ItemProperty -Path $path -Name "My Video" -Value "%USERPROFILE%\Videos" -Type ExpandString
Set-ItemProperty -Path $path -Name "Personal" -Value "%USERPROFILE%\Documents" -Type ExpandString

Write-Output "This Script will now map your user folder to a drive that is different from C:\. Remember to transfer all of your files to the new location to prevent C:\ failure induced data loss."
Write-Output "This will not delete any of your files, but MAKE SURE YOU HAVE AN EXTERNAL BACKUP OF ALL YOUR DATA BEFOREHAND, AND THAT SAID BACKUP IS UNPLUGGED FROM YOUR COMPUTER, IN CASE SOMETHING GOES WRONG."
Write-Host "Scanning for available drives..."

$drives = Get-PSDrive -PSProvider FileSystem | Select-Object -ExpandProperty Name
Write-Host "Available drives: $($drives -join ', ')"
do {
  $drive = Read-Host "Enter the drive letter you want to use. It is heavily recommended that you do NOT use C. You also cannot use a subfolder, because some programs made by room temperature IQ developers will try to RENAME the subfolder for some fucked up reason, so you have no choice but to use the root of the drive."
  $drive = $drive.TrimEnd(":")
} until ($drives -contains $drive.ToUpper())

Write-Host "You selected drive $drive`:\"
$basePath = "$drive`:"
Write-Output "LAST CHANCE TO CHECK THAT YOU BACKED UP EVERYTHING."
Read-Host -Prompt "Press Enter thrice to continue..."
Write-Output "YOU WILL NEED TO TRANSFER ALL OF YOUR FILES TO THE NEW LOCATION TO PREVENT C:\ FAILURE INDUCED DATA LOSS."
Read-Host -Prompt "Press Enter twice to continue...."
Write-Output "YOU HAVE BEEN WARNED."
Read-Host -Prompt "Press Enter once to continue....."
Write-Host "Mapping user folders to $drive`:\"

$mappings = @{
  "{0DDD015D-B06C-45D5-8C4C-F59713854639}"="$basePath\"
  "{31C0DD25-9439-4F12-BF41-7FF4EDA38722}"="$basePath\"
  "{35286A68-3C57-41A1-BBB1-0EAE73D76C95}"="$basePath\"
  "{374DE290-123F-4565-9164-39C4925E467B}"="$basePath\Downloads"
  "{4C5C32FF-BB9D-43B0-B5B4-2D72E54EAAA4}"="$basePath\"
  "{56784854-C6CB-462B-8169-88E350ACB882}"="$basePath\"
  "{754AC886-DF64-4CBA-86B5-F7FBF4FBCEF5}"="$basePath\"
  "{7D1D3A04-DEBB-4115-95CF-2F29DA2920DA}"="$basePath\Temp"
  "{7D83EE9B-2244-4E70-B1F5-5393042AF1E4}"="$basePath\Downloads"
  "{A0C69A99-21C8-4671-8703-7934162FCF1D}"="$basePath\"
  "{BFB9D5E0-C6A9-404C-B2B2-AE6DB6AF4968}"="$basePath\Start"
  "{F42EE2D3-909F-4907-8871-4C22FC0BF756}"="$basePath\"
  Cache="$basePath\Temp"
  Cookies="$basePath\Temp"
  Desktop="$basePath\"
  Favorites="$basePath\Start"
  History="$basePath\Temp"
  NetHood="$basePath\Start"
  Personal="$basePath\"
  PrintHood="$basePath\Start"
  Programs="$basePath\Start"
  Recent="$basePath\Temp"
  SendTo="$basePath\Start"
  Startup="$basePath\Start\Startup"
  Templates="$basePath\"
  "My Music"="$basePath\"
  "My Pictures"="$basePath\"
  "My Video"="$basePath\"
  "Start Menu"="$basePath\Start"
}
$mappings.GetEnumerator() | % { Set-ItemProperty -Path $path -Name $_.Key -Value $_.Value -Type ExpandString }
Write-Output "Process complete. Check Computer\HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders in regedit to ensure everything went correctly. You will also see that your Appdata folder has not been moved. This is by design. It is an extremely risky operation that will cause system instability if you don't know what you're doing. If you want to move your Appdata folder, please research how to do so safely. Remember to transfer all of your files to the new location to prevent C:\ failure induced data loss. You may need to restart your computer for all changes to take effect."
Read-Host -Prompt "Press Enter thrice to exit..."
Read-Host -Prompt "Press Enter twice to exit...."
Read-Host -Prompt "Press Enter once to exit....."
}
catch {
  Write-Output "An error occurred: $_"
  Write-Host "Message:" $_.Exception.Message
  Write-Host "Details:" $_.ErrorDetails
  Write-Host "Stack:" $_.ScriptStackTrace
  Write-Host "Type:" $_.GetType().FullName
}
finally {
  Write-Output "Exiting script."
}
