# Use this file to run your own startup commands

## Prompt Customization
<#
.SYNTAX
    <PrePrompt><CMDER DEFAULT>
    Î» <PostPrompt> <repl input>
.EXAMPLE
    <PrePrompt>N:\Documents\src\cmder [master]
    Î» <PostPrompt> |
#>

# CimSession Access
$session = New-CimSession

#os
$osQry = @"
    SELECT Caption, Version, OSArchitecture, InstallDate, MUILanguages, CSName, LocalDateTime
    FROM Win32_OperatingSystem
"@
$osObject = Get-CimInstance -Query $osQry -CimSession $session
#pc
$pcQry = @"
    SELECT UserName, Workgroup, Manufacturer, Model
    FROM Win32_ComputerSystem
"@
$pcObject = Get-CimInstance -Query $pcQry -CimSession $session
#cpu
$cpuQry = @"
    SELECT Name
    FROM Win32_Processor
"@
$cpuObject = Get-CimInstance -Query $cpuQry -CimSession $session
#motherboard
$mboardQry = @"
    SELECT Manufacturer, Product, Name, Version
    FROM Win32_BaseBoard
"@
$mboardObject = Get-CimInstance -Query $mboardQry -CimSession $session
#bios
$biosQry = @"
    SELECT Manufacturer
    FROM Win32_Bios
"@
$biosObject = Get-CimInstance -Query $biosQry -CimSession $session
#bios
$memQry = @"
    SELECT Capacity, Manufacturer, Speed
    FROM Win32_PhysicalMemory
"@
$memObject = Get-CimInstance -Query $memQry -CimSession $session
#disk
$dskQry = @"
    SELECT Size, Caption
    FROM Win32_DiskDrive
"@
$drvObject = Get-CimInstance -Query $dskQry -CimSession $session
#gpu
$gpuQry = @"
    SELECT Caption
    FROM Win32_VideoController
"@
$gpuObject = Get-CimInstance -Query $gpuQry -CimSession $session

# system info variables
$oscaption = $osObject.Caption
$osversion = $osObject.Version
$osarch = $osObject.OSArchitecture
$osinstall = $osObject.InstallDate
$oslang = $osObject.MUILanguages
$pcname = $osObject.CSName
$currenttime = $osObject.LocalDateTime
$username = $pcObject.UserName.Split('\')[1]
$workgroup = $pcObject.Workgroup
$mainboardmodel = $pcObject.Manufacturer + " - " + $pcObject.Model
$cpuname = $cpuObject.Name
$mainboardname = $mboardObject.Manufacturer + " " + $mboardObject.Product
$biosname = $biosObject.Manufacturer + " " + $mboardObject.Name + " " + $mboardObject.Version
$ramcapacity = $memObject | Measure-Object -Property capacity -sum | % {[math]::round(($_.sum / 1GB),2)}
$raminfo = $memObject[0].Manufacturer + " " + $ramcapacity + "GB @" + $memObject[0].Speed + "MHz"
$diskcapacity = $drvObject | Measure-Object -Property size -sum | % {[math]::round(($_.sum / 1GB),2)}
$diskinfo = $drvObject[0].Caption + "/System Capacity " + $diskcapacity + "GB"
#$gpucapacity = $gpuObject | Measure-Object -Property adapterram -sum | % {[math]::round(($_.sum / 1GB),2)}
$gpuinfo = $gpuObject[0].Caption <#+ " " + $gpucapacity + "GB " + $gpuObject.VideoModeDescription#>

# colors
$titlecolor = "Blue"
$textcolor = "Gray"
$logocolor = "Blue"

# system info header layout
Write-Host -ForegroundColor $logocolor -NoNewline "
                                                            
                                           *_:~rxTyeM        
                            *-:<rxTyKMR8B#@@@@@@@@@@@`       
            *_:~rxuwmMD8Bv  Z@@@@@@@@@@@@@@@@@@@@@@@@`       
      !D8B#@@@@@@@@@@@@@@x  Z@@@@@@@@@@@@@@@@@@@@@@@@`       "
Write-Host -ForegroundColor $logocolor $username -NoNewline
Write-Host -ForegroundColor White "@" -NoNewline
Write-Host -ForegroundColor $logocolor $pcname
Write-Host -ForegroundColor $logocolor -NoNewline "      *@@@@@@@@@@@@@@@@@@x  Z@@@@@@@@@@@@@@@@@@@@@@@@`       " 
Write-Host -ForegroundColor $titlecolor -NoNewline "System: " 
Write-Host -ForegroundColor $textcolor $oscaption
Write-Host -ForegroundColor $logocolor -NoNewline "      *@@@@@@@@@@@@@@@@@@x  Z@@@@@@@@@@@@@@@@@@@@@@@@`       "
Write-Host -ForegroundColor $titlecolor -NoNewline "Version: " 
Write-Host -ForegroundColor $textcolor $osversion
Write-Host -ForegroundColor $logocolor -NoNewline "      *@@@@@@@@@@@@@@@@@@x  Z@@@@@@@@@@@@@@@@@@@@@@@@`       "
Write-Host -ForegroundColor $titlecolor -NoNewline "Architecture: " 
Write-Host -ForegroundColor $textcolor $osarch
Write-Host -ForegroundColor $logocolor -NoNewline "      *@@@@@@@@@@@@@@@@@@x  Z@@@@@@@@@@@@@@@@@@@@@@@@`       "
Write-Host -ForegroundColor $titlecolor -NoNewline "Install Date: " 
Write-Host -ForegroundColor $textcolor $osinstall
Write-Host -ForegroundColor $logocolor -NoNewline "      *@@@@@@@@@@@@@@@@@@x  Z@@@@@@@@@@@@@@@@@@@@@@@@`       "
Write-Host -ForegroundColor $titlecolor -NoNewline "Current Date: " 
Write-Host -ForegroundColor $textcolor $currenttime
Write-Host -ForegroundColor $logocolor -NoNewline "      *@@@@@@@@@@@@@@@@@@x  Z@@@@@@@@@@@@@@@@@@@@@@@@`       "
Write-Host -ForegroundColor $titlecolor -NoNewline "Host Name: " 
Write-Host -ForegroundColor $textcolor $pcname
Write-Host -ForegroundColor $logocolor -NoNewline "      =@DEDDERRRR66666OdO^  }dZZZMMMMMMMMMMWWWWGP3P3P       "
Write-Host -ForegroundColor $titlecolor -NoNewline "Workgroup: " 
Write-Host -ForegroundColor $textcolor $workgroup
Write-Host -ForegroundColor $logocolor -NoNewline "                                                            "
Write-Host -ForegroundColor $titlecolor -NoNewline "UserName: " 
Write-Host -ForegroundColor $textcolor $username
Write-Host -ForegroundColor $logocolor -NoNewline "      *@@@@@@@@@@@@@@@@@@]  Z@@@@@@@@@@@@@@@@@@@@@@@@`       "
Write-Host -ForegroundColor $titlecolor -NoNewline "Language: " 
Write-Host -ForegroundColor $textcolor $oslang
Write-Host -ForegroundColor $logocolor -NoNewline "      *@@@@@@@@@@@@@@@@@@x  Z@@@@@@@@@@@@@@@@@@@@@@@@`       "
Write-Host -ForegroundColor $titlecolor -NoNewline "CPU: " 
Write-Host -ForegroundColor $textcolor $cpuname
Write-Host -ForegroundColor $logocolor -NoNewline "      *@@@@@@@@@@@@@@@@@@x  Z@@@@@@@@@@@@@@@@@@@@@@@@`       "
Write-Host -ForegroundColor $titlecolor -NoNewline "Motherboard: " 
Write-Host -ForegroundColor $textcolor $mainboardname
Write-Host -ForegroundColor $logocolor -NoNewline "      *@@@@@@@@@@@@@@@@@@x  Z@@@@@@@@@@@@@@@@@@@@@@@@`       "
Write-Host -ForegroundColor $titlecolor -NoNewline "Model: " 
Write-Host -ForegroundColor $textcolor $mainboardmodel
Write-Host -ForegroundColor $logocolor -NoNewline "      *@@@@@@@@@@@@@@@@@@x  Z@@@@@@@@@@@@@@@@@@@@@@@@`       "
Write-Host -ForegroundColor $titlecolor -NoNewline "RAM: " 
Write-Host -ForegroundColor $textcolor $raminfo
Write-Host -ForegroundColor $logocolor -NoNewline "      *@@@@@@@@@@@@@@@@@@x  Z@@@@@@@@@@@@@@@@@@@@@@@@`       "
Write-Host -ForegroundColor $titlecolor -NoNewline "HDD: " 
Write-Host -ForegroundColor $textcolor $diskinfo
Write-Host -ForegroundColor $logocolor -NoNewline "      *@@@@@@@@@@@@@@@@@@x  Z@@@@@@@@@@@@@@@@@@@@@@@@`       "
Write-Host -ForegroundColor $titlecolor -NoNewline "GPU: " 
Write-Host -ForegroundColor $textcolor $gpuinfo
Write-Host -ForegroundColor $logocolor -NoNewline "      *:~rx}yKMR8Q#@@@@@@x  Z@@@@@@@@@@@@@@@@@@@@@@@@`       "
Write-Host -ForegroundColor $titlecolor -NoNewline "BIOS: " 
Write-Host -ForegroundColor $textcolor $biosname
Write-Host -ForegroundColor $logocolor -NoNewline "                    *-:~*,  (e5E8B#@@@@@@@@@@@@@@@@@@`       
                                    *-:~*v}VeMRgQ#@@@`       
                                                   *-        

"

[ScriptBlock]$PrePrompt = {

}

# Replace the cmder prompt entirely with this.
 [ScriptBlock]$CmderPrompt = {
    Write-Host $username"@"$pcname":" -NoNewline -ForegroundColor $textcolor
    Write-Host "~" -NoNewline -ForegroundColor $logocolor
    Write-Host "#" -NoNewline -ForegroundColor $textcolor
 }

[ScriptBlock]$PostPrompt = {

}

## <Continue to add your own>

