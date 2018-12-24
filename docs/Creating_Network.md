# Hyper-V: Working with Virtual Network Interfaces

## Copied from https://gist.github.com/doggy8088/8294d0e1029787fb61613a7b5ce49905

### References

* [Creating an external virtual switch in hyper-v](https://docs.microsoft.com/en-us/virtualization/hyper-v-on-windows/quick-start/connect-to-network) 
* [What to do if Hyper-V Manager is not found](https://www.petri.com/workaround-finding-missing-hyper-v-tools-windows-10)
* [`DockerNAT` prevents other internal interfaces from working](https://docs.microsoft.com/en-us/virtualization/hyper-v-on-windows/user-guide/setup-nat-network) 

### Introduction

These notes will help to:

* configure an *internal* virtual network interface (`vEthernet`) in Hyper-V
* set it up so it can access the internet from your laptop's WiFi connection

### 1. Create Virtual Network Interface

1. Open Hyper-V Manager. Look at the References section if you cannot find Hyper-V Manager.
2. Click your machine name on left panel. On the right-most panel you will find the option `Virtual Switch Manager`. Click that.
3. Create an **Internal** interface. Name it "InternalSwitch". 

![image](https://user-images.githubusercontent.com/13379978/29363449-b2e44aaa-82ad-11e7-8302-c92125caaf35.png)

### 2a. Setup Network Sharing between WiFi and `InternalSwitch`

1. Now you need to configure your WiFi's network adapter. 
1. In the `Run` Dialog, type `control netconnections`. [This opens the Network Adapter window.](http://www.anas.co.in/2011/08/how-to-open-network-connections-adapter.html)
1. Right-click your WiFi network adapter, open `Properties` > `Sharing` tab. 
1. Configure sharing between WiFi adapter and the `InternalSwitch` virtual interface created above.

![image](https://user-images.githubusercontent.com/13379978/29363542-07851418-82ae-11e7-858d-c26e5a252eb7.png)

### 3. Configure IPV4 Settings for `InternalSwitch`

:exclamation: *If your VM is running while you configure network, please restart the VM !


Next, configure the IPV4 Settings for the `InternalSwitch` adapter. 

1. Open properties for the `InternalSwitch` adapter.
1. Click "Internet Protocol Version 4" and click "Properties".

And then configure its properties as follows (only the DNS address may be missing usually): 

![image](https://user-images.githubusercontent.com/13379978/29363360-4fd8f348-82ad-11e7-8910-2af4b1f1bf15.png)

### 4. Make sure Docker for Windows is turned off

At this point, **if you have Docker for Windows running**, your virtual interface will show "No Internet Access".
See the references section; there is documentation that says only one such internal interface can be used at a time. 

![image](https://user-images.githubusercontent.com/13379978/29395829-6207bf2a-8331-11e7-9a1d-b98d3dae6b3d.png)

Quit Docker. 

![image](https://user-images.githubusercontent.com/13379978/29395816-4e46fb90-8331-11e7-84d6-458d348f1680.png)

The network interface will now show an internet connection. 

![image](https://user-images.githubusercontent.com/13379978/29395934-32966394-8332-11e7-9f3e-fad34bb33762.png)
