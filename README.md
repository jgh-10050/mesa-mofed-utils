# Mesa Infiniband Admin Container Image
Create an admin container image that includes either Mellanox or open source user space infiniband OFED libraries and utilities.

Requires a talos system running with infiniband OFED enabled kernel.
See [README-OFED.md](./README-OFED.md) on how to build an infiniband OFED enabled kernel and talos installer image.
## Build with MOFED user space
```
docker login ghcr.io --username <YOUR_GITHUB_USERID>
make REGISTRY=ghcr.io USERNAME=<YOUR_GIHUB_USERID> [PUSH=true]
```
## Build with OFED user space
```
docker login ghcr.io --username <YOUR_GITHUB_USERID>
make ofed REGISTRY=ghcr.io USERNAME=<YOUR_GIHUB_USERID> [PUSH=true]
```
## Deploy in a Talos cluster
Create a privileged namespace.
```
kubectl apply -f k8s/admin-namespace.yaml
```
Update the image path in *k8s/infiniband-admin.yaml* to point to the desired image (mofed or ofed) to use.
```
kubectl apply -f k8s/infiniband-admin.yaml
kubectl exec -it -n admin-privileged infiniband-admin -- sh
```

## Configure Mellanox Link Type
The Mellanox adapters can be configured to run with link type ethernet or infiniband.  For our systems, we want it configured for infiniband.

To check current link type configuration, run the following from the infiniband admin container:
```
bash-5.1# mlxconfig q | awk '/LINK_TYPE/ || /Device/ {print}'
Device #1:
Device type:    ConnectX4       
Device:         0000:04:00.0    
         LINK_TYPE_P1             ETH(2)           
```      
If an ETH link type is found, you can reconfigure by running the following commands from the infinaband admin container:
```
bash-5.1# mlxconfig -y -d 0000:04:00.0 set LINK_TYPE_P1=1

Device #1:
----------

Device type:    ConnectX4       
Name:           N/A             
Description:    N/A             
Device:         0000:04:00.0    

Configurations:        Next Boot       New
        LINK_TYPE_P1   ETH(2)          IB(1)           

 Apply new Configuration? (y/n) [n] : y
Applying... Done!
-I- Please reboot machine to load new configurations.
```
```
bash-5.1# mlxfwreset -y -d 0000:04:00.0 reset

Minimal reset level for device, 04:00.0:

3: Driver restart and PCI reset
Continue with reset?[y/N] y
-I- Sending Reset Command To Fw             -Done
-I- Stopping Driver                         -Done
-I- Resetting PCI                           -Done
-I- Starting Driver                         -Done
-I- Restarting MST                          -Skipped
-I- FW was loaded successfully.
```
Then reboot the node using talosctl and the nodes IP address.
```
talosctl -n 172.30.223.188 reboot
```
## Verify the configuration
Open a new admin shell and verify the configuration.
```
bash-5.1# mlxconfig q | awk '/LINK_TYPE/ || /Device/ {print}'
Device #1:
Device type:    ConnectX4       
Device:         0000:04:00.0    
       LINK_TYPE_P1            IB(1)           

bash-5.1# lsmod
Module                  Size  Used by
rdma_ucm               32768  0
rdma_cm               106496  1 rdma_ucm
iw_cm                  45056  1 rdma_cm
mlx5_ib               335872  0
mlx5_core            1331200  1 mlx5_ib
mlxfw                  24576  1 mlx5_core
ib_uverbs             151552  2 rdma_ucm,mlx5_ib
ib_umad                36864  0
ib_ipoib              139264  0
ib_cm                 114688  2 rdma_cm,ib_ipoib
ib_core               356352  8 rdma_cm,ib_ipoib,iw_cm,ib_umad,rdma_ucm,ib_uverbs,mlx5_ib,ib_cm
```
```
bash-5.1# ls -l /sys/class/infiniband
total 0
lrwxrwxrwx 1 root root 0 Mar 17 06:00 mlx5_0 -> ../../devices/pci0000:00/0000:00:02.0/0000:04:00.0/infiniband/mlx5_0
```
```
bash-5.1# ibstat
CA 'mlx5_0'
	Number of ports: 1
	Firmware version: 12.20.1010
	Hardware version: 0
	Node GUID: 0x248a07030049aee0
	System image GUID: 0x248a07030049aee0
	Port 1:
		State: Initializing
		Physical state: LinkUp
		Rate: 100
		Base lid: 65535
		LMC: 0
		SM lid: 0
		Capability mask: 0x2651e848
		Port GUID: 0x248a07030049aee0
		Link layer: InfiniBand
```
