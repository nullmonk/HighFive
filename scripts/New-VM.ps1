# Set VM Name, Switch Name, and Installation Media Path.
Param(
   [string]$VMName,
   [file]$ISO,
   [string]$NetworkName = "InternalSwitch"
)

$gen = 2

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
Add-VMDvdDrive -VMName $VMName -ControllerNumber 1 -ControllerLocation 0 -Path $ISO

# Mount Installation Media
$DVDDrive = Get-VMDvdDrive -VMName $VMName

# Configure Virtual Machine to Boot from DVD
Set-VMFirmware -VMName $VMName -FirstBootDevice $DVDDrive