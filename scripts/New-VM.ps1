# Set VM Name, Switch Name, and Installation Media Path.
Param(
   [string]$VMName = "",
   [string]$ISO = "",
   [string]$NetworkName = "InternalSwitch"
)
$ErrorActionPreference = "Stop"
$gen = 1

if (($ISO -eq "") -or !(Test-Path $ISO) -or ($VMName -eq "")) {
    Write-Host "Invalid Parameters"
    exit
}

$VMPath = "C:\Users\Public\Documents\Hyper-V\$VMName\"
$VHDPath = $VMPath + "$VMName.vhdx"

# Create New Hard drive
New-VHD -Path $VHDPath -SizeBytes 40GB -Dynamic -BlockSizeBytes 1MB

# Create New Virtual Machine
New-VM -Name $VMName -MemoryStartupBytes 1GB -Generation $gen -VHDPath $VHDPath -Path $VMPath -SwitchName $NetworkName

# Configure Memory
Set-VM -Name $VMName -DynamicMemory -MemoryMaximumBytes 3GB

# Add DVD Drive to Virtual Machine
Add-VMScsiController -VMName $VMName
Add-VMDvdDrive -VMName $VMName -Path $ISO -ControllerNumber 0 -ControllerLocation 1

# Mount Installation Media
$DVDDrive = Get-VMDvdDrive -VMName $VMName

# Configure Virtual Machine to Boot from DVD
if ($gen -gt 1) {
    Set-VMFirmware -VMName $VMName -FirstBootDevice $DVDDrive
}