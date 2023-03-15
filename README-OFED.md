# Talos Infiniband OFED

## Build talos pkgs repo with inbox infiniband OFED kernel support enabled.
### Clone the talos pkgs repository. 
```
git clone https://github.com/siderolabs/pkgs.git
```

### Checkout the appropriate pkgs release tag
Checkout the release you want based on the *Dependency Changes* information found on [talos releases](https://github.com/siderolabs/talos/releases).<br>
For v1.3.4, the pkgs repo tag is v1.3.0-11-gffdc9f1.
```
git checkout -b v1.3.4 v1.3.0-11-gffdc9f1
cd v1.3.4
```

### Apply the kernel configuration patch
To enable infiniband OFED in the kernel image build, apply the following patch to kernel/build/config-amd64:
```
diff --git a/kernel/build/config-amd64 b/kernel/build/config-amd64
index 9dd9a1e..8f2a0d9 100644
--- a/kernel/build/config-amd64
+++ b/kernel/build/config-amd64
@@ -868,6 +868,7 @@ CONFIG_EFI_PARTITION=y
 CONFIG_BLOCK_COMPAT=y
 CONFIG_BLK_MQ_PCI=y
 CONFIG_BLK_MQ_VIRTIO=y
+CONFIG_BLK_MQ_RDMA=y
 CONFIG_BLK_PM=y
 CONFIG_BLOCK_HOLDER_DEPRECATED=y
 
@@ -996,6 +997,7 @@ CONFIG_XFRM_AH=y
 CONFIG_XFRM_ESP=y
 CONFIG_XFRM_IPCOMP=y
 # CONFIG_NET_KEY is not set
+# CONFIG_SMC is not set
 # CONFIG_XDP_SOCKETS is not set
 CONFIG_INET=y
 CONFIG_IP_MULTICAST=y
@@ -1463,6 +1465,7 @@ CONFIG_SCTP_COOKIE_HMAC_MD5=y
 # CONFIG_SCTP_COOKIE_HMAC_SHA1 is not set
 CONFIG_INET_SCTP_DIAG=y
 CONFIG_RDS=y
+# CONFIG_RDS_RDMA is not set
 # CONFIG_RDS_TCP is not set
 # CONFIG_RDS_DEBUG is not set
 # CONFIG_TIPC is not set
@@ -1941,6 +1944,7 @@ CONFIG_BLK_DEV_NVME=y
 # CONFIG_NVME_MULTIPATH is not set
 CONFIG_NVME_HWMON=y
 CONFIG_NVME_FABRICS=y
+# CONFIG_NVME_RDMA is not set
 CONFIG_NVME_FC=y
 CONFIG_NVME_TCP=y
 # end of NVME Support
@@ -2445,7 +2449,38 @@ CONFIG_NET_VENDOR_MARVELL=y
 CONFIG_SKY2=y
 # CONFIG_SKY2_DEBUG is not set
 # CONFIG_PRESTERA is not set
-# CONFIG_NET_VENDOR_MELLANOX is not set
+CONFIG_NET_VENDOR_MELLANOX=y
+CONFIG_MLX4_EN=m
+CONFIG_MLX4_EN_DCB=y
+CONFIG_MLX4_CORE=m
+CONFIG_MLX4_DEBUG=y
+CONFIG_MLX4_CORE_GEN2=y
+CONFIG_MLX5_CORE=m
+CONFIG_MLX5_ACCEL=y
+CONFIG_MLX5_FPGA=y
+CONFIG_MLX5_CORE_EN=y
+CONFIG_MLX5_EN_ARFS=y
+CONFIG_MLX5_EN_RXNFC=y
+CONFIG_MLX5_MPFS=y
+CONFIG_MLX5_ESWITCH=y
+CONFIG_MLX5_BRIDGE=y
+CONFIG_MLX5_CLS_ACT=y
+CONFIG_MLX5_TC_SAMPLE=y
+CONFIG_MLX5_CORE_EN_DCB=y
+CONFIG_MLX5_CORE_IPOIB=y
+# CONFIG_MLX5_FPGA_IPSEC is not set
+# CONFIG_MLX5_IPSEC is not set
+CONFIG_MLX5_SW_STEERING=y
+CONFIG_MLX5_SF=y
+CONFIG_MLXSW_CORE=m
+CONFIG_MLXSW_CORE_HWMON=y
+CONFIG_MLXSW_CORE_THERMAL=y
+CONFIG_MLXSW_PCI=m
+CONFIG_MLXSW_I2C=m
+CONFIG_MLXSW_SPECTRUM=m
+CONFIG_MLXSW_SPECTRUM_DCB=m
+CONFIG_MLXSW_MINIMAL=m
+CONFIG_MLXFW=m
 CONFIG_NET_VENDOR_MICREL=y
 # CONFIG_KS8842 is not set
 # CONFIG_KS8851_MLL is not set
@@ -4257,7 +4292,31 @@ CONFIG_LEDS_TRIGGERS=y
 # CONFIG_LEDS_TRIGGER_AUDIO is not set
 # CONFIG_LEDS_TRIGGER_TTY is not set
 # CONFIG_ACCESSIBILITY is not set
-# CONFIG_INFINIBAND is not set
+CONFIG_INFINIBAND=m
+CONFIG_INFINIBAND_USER_MAD=m
+CONFIG_INFINIBAND_USER_ACCESS=m
+CONFIG_INFINIBAND_ADDR_TRANS=m
+CONFIG_INFINIBAND_VIRT_DMA=y
+# CONFIG_INFINIBAND_MTHCA is not set
+CONFIG_INFINIBAND_IRDMA=m
+CONFIG_MLX4_INFINIBAND=m
+CONFIG_MLX5_INFINIBAND=m
+CONFIG_INFINIBAND_OCRDMA=m
+# CONFIG_INFINIBAND_VMWARE_PVRDMA is not set
+CONFIG_INFINIBAND_BNXT_RE=m
+CONFIG_INFINIBAND_QEDR=m
+CONFIG_INFINIBAND_RDMAVT=m
+CONFIG_RDMA_RXE=m
+CONFIG_RDMA_SIW=m
+CONFIG_INFINIBAND_IPOIB=m
+CONFIG_INFINIBAND_IPOIB_CM=y
+CONFIG_INFINIBAND_IPOIB_DEBUG=y
+# CONFIG_INFINIBAND_IPOIB_DEBUG_DATA is not set
+CONFIG_INFINIBAND_SRP=m
+CONFIG_INFINIBAND_ISER=m
+CONFIG_INFINIBAND_RTRS_CLIENT=m
+CONFIG_INFINIBAND_RTRS_SERVER=m
+CONFIG_INFINIBAND_OPA_VNIC=m
 CONFIG_EDAC_ATOMIC_SCRUB=y
 CONFIG_EDAC_SUPPORT=y
 CONFIG_EDAC=y
@@ -4530,7 +4589,7 @@ CONFIG_EEEPC_LAPTOP=y
 # CONFIG_SYSTEM76_ACPI is not set
 # CONFIG_TOPSTAR_LAPTOP is not set
 # CONFIG_I2C_MULTI_INSTANTIATE is not set
-# CONFIG_MLX_PLATFORM is not set
+CONFIG_MLX_PLATFORM=m
 # CONFIG_INTEL_IPS is not set
 # CONFIG_INTEL_SCU_PCI is not set
 # CONFIG_INTEL_SCU_PLATFORM is not set
@@ -4936,6 +4995,7 @@ CONFIG_CIFS_DEBUG=y
 # CONFIG_CIFS_DEBUG_DUMP_KEYS is not set
 CONFIG_CIFS_DFS_UPCALL=y
 # CONFIG_CIFS_SWN_UPCALL is not set
+# CONFIG_CIFS_SMB_DIRECT is not set
 # CONFIG_CIFS_ROOT is not set
 # CONFIG_SMB_SERVER is not set
 CONFIG_SMBFS_COMMON=y
@@ -5009,6 +5069,7 @@ CONFIG_KEYS=y
 CONFIG_SECURITY_DMESG_RESTRICT=y
 CONFIG_SECURITY=y
 CONFIG_SECURITYFS=y
+# CONFIG_SECURITY_INFINIBAND is not set
 CONFIG_SECURITY_NETWORK=y
 CONFIG_SECURITY_NETWORK_XFRM=y
 # CONFIG_SECURITY_PATH is not set
@@ -5735,6 +5796,7 @@ CONFIG_RUNTIME_TESTING_MENU=y
 # CONFIG_TEST_RHASHTABLE is not set
 # CONFIG_TEST_HASH is not set
 # CONFIG_TEST_IDA is not set
+# CONFIG_TEST_PARMAN is not set
 # CONFIG_TEST_LKM is not set
 # CONFIG_TEST_BITOPS is not set
 # CONFIG_TEST_VMALLOC is not set
@@ -5748,6 +5810,7 @@ CONFIG_RUNTIME_TESTING_MENU=y
 # CONFIG_TEST_STATIC_KEYS is not set
 # CONFIG_TEST_KMOD is not set
 # CONFIG_TEST_MEMCAT_P is not set
+# CONFIG_TEST_OBJAGG is not set
 # CONFIG_TEST_STACKINIT is not set
 # CONFIG_TEST_MEMINIT is not set
 # CONFIG_TEST_FREE_PAGES is not set
```
### Make additional kernel configuration changes
Enable or disable any additional build options by editing the *kernel/build/config-amd64* file.

### Log in to github ghcr.io registry
```
docker login ghcr.io --username <YOUR_GITHUB_USERID>
```

### Build the kernel image
```
make REGISTRY=ghcr.io USERNAME=<YOUR_GITHUB_USERID> PLATFORM=linux/amd64 TAG=5.15.92-talos PUSH=true kernel
```
When successful, this will push the kernel image to *ghcr.io/<YOUR_GITHUB_USERID>/kernel:5.15.92-talos*.


## Build a talos installer image using your version of the kernel image
### Clone the talos installer repository and checkout the version you want to build.
```
git clone https://github.com/siderolabs/talos.git
git checkout -b v1.3.4 v1.3.4
cd talos
```

### Update the Docker file to pull in your kernel image
```
diff --git a/Dockerfile b/Dockerfile
index 93070a2eb..6c94d2249 100644
--- a/Dockerfile
+++ b/Dockerfile
@@ -74,9 +74,9 @@ FROM --platform=arm64 ghcr.io/siderolabs/util-linux:${PKGS} AS pkg-util-linux-ar
 FROM --platform=amd64 ghcr.io/siderolabs/kmod:${PKGS} AS pkg-kmod-amd64
 FROM --platform=arm64 ghcr.io/siderolabs/kmod:${PKGS} AS pkg-kmod-arm64
 
-FROM ghcr.io/siderolabs/kernel:${PKGS} AS pkg-kernel
-FROM --platform=amd64 ghcr.io/siderolabs/kernel:${PKGS} AS pkg-kernel-amd64
-FROM --platform=arm64 ghcr.io/siderolabs/kernel:${PKGS} AS pkg-kernel-arm64
+FROM ghcr.io/<YOUR_GITHUB_USER_ID>/kernel:5.15.92-talos AS pkg-kernel
+FROM --platform=amd64 ghcr.io/<YOUR_GITHUB_USERID>/kernel:5.15.92-talos AS pkg-kernel-amd64
+FROM --platform=arm64 ghcr.io/<YOUR_GITHUB_USERID>/kernel:5.15.92-talos AS pkg-kernel-arm64
 
 FROM --platform=arm64 ghcr.io/siderolabs/u-boot:${PKGS} AS pkg-u-boot-arm64
 FROM --platform=arm64 ghcr.io/siderolabs/raspberrypi-firmware:${PKGS} AS pkg-raspberrypi-firmware-arm64
```

### Log in to github ghcr.io registry
```
docker login ghcr.io --username <YOUR_GITHUB_USERID>
```

### Build the talos installer image
```
docker buildx create --driver docker-container  --driver-opt network=host  --buildkitd-flags '--allow-insecure-entitlement security.insecure' --use
make REGISTRY=ghcr.io USERNAME=<YOUR_GITHUB_USERID> PLATFORM=linux/amd64 PUSH=true TAG=1.3.4 TAG_SUFFIX=-ofed-5.15.92 installer
```
When successful, this will push the kernel image to *ghcr.io/<YOUR_GITHUB_USERID>/installer:1.3.4-ofed-5.15.92*
