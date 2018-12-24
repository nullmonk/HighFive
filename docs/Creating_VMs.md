# Creating VMs for Hyper-V

This document will focus on creating VMs for Hyper-V. If the VM is a linux VM, it is recommended that you follow the steps outlined [here](https://docs.microsoft.com/en-us/windows-server/virtualization/hyper-v/best-practices-for-running-linux-on-hyper-v).

VMs can either be made with a GUI or with a Powershell script, the GUI does not allow for any of the best practice configurations specified above.

## Creation
[MS Docs on VM Creation](https://docs.microsoft.com/en-us/virtualization/hyper-v-on-windows/quick-start/create-virtual-machine)

## Generation
~~Linux VMs do not support Generation 2 VMs. So always choose Generation 1.~~

[Should I create a generation 1 or 2 virtual machine in Hyper-V?](https://docs.microsoft.com/en-us/windows-server/virtualization/hyper-v/plan/should-i-create-a-generation-1-or-2-virtual-machine-in-hyper-v)

## Memory
If you want to dynamic memory, specify the start ammount at VM creation. __However__, after the VM is created, __MAKE SURE__ you change the Maximum RAM value to a sane ammount as the default is pretty high.

## Network
Networking is weird in Hyper-V, check out [Creating Networks](./Creating_Network.md) to see which network I use.

You can find network names by using this command:
```powershell
Get-VMSwitch  * | Format-Table Name
```

## Hard Disk
Either create a new hard disk with the GUI, or use Powershell to create one for you.