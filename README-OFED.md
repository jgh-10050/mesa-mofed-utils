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
### Update kernel build configuration
The following is a list of kernel config parameters that should be set to enable the required Infiniband support.  Edit the *kernel/build/config-amd64* file and update any of the values that differ:
```
CONFIG_NET_VENDOR_MELLANOX=y
CONFIG_MLX4_EN=y
CONFIG_MLX4_EN_DCB=y
CONFIG_MLX4_CORE=m
CONFIG_MLX4_DEBUG=y
CONFIG_MLX4_CORE_GEN2=y
CONFIG_MLX5_CORE=m
CONFIG_MLX5_ACCEL=y
CONFIG_MLX5_FPGA=y
CONFIG_MLX5_CORE_EN=y
CONFIG_MLX5_EN_ARFS=y
CONFIG_MLX5_EN_RXNFC=y
CONFIG_MLX5_MPFS=y
CONFIG_MLX5_ESWITCH=y
CONFIG_MLX5_BRIDGE=y
CONFIG_MLX5_CLS_ACT=y
CONFIG_MLX5_TC_SAMPLE=y
CONFIG_MLX5_CORE_EN_DCB=y
CONFIG_MLX5_CORE_IPOIB=y
# CONFIG_MLX5_FPGA_IPSEC is not set
# CONFIG_MLX5_IPSEC is not set
CONFIG_MLX5_SW_STEERING=y
CONFIG_MLX5_SF=y
CONFIG_MLXSW_CORE=m
CONFIG_MLXSW_CORE_HWMON=y
CONFIG_MLXSW_CORE_THERMAL=y
CONFIG_MLXSW_PCI=m
CONFIG_MLXSW_I2C=m
CONFIG_MLXSW_SPECTRUM=m
CONFIG_MLXSW_SPECTRUM_DCB=m
CONFIG_MLXSW_MINIMAL=m
CONFIG_MLXFW=m
# CONFIG_I2C_MLXCPLD is not set
# CONFIG_LEDS_MLXCPLD is not set
# CONFIG_LEDS_MLXREG is not set
CONFIG_INFINIBAND=m
CONFIG_INFINIBAND_USER_MAD=m
CONFIG_INFINIBAND_USER_ACCESS=m
CONFIG_INFINIBAND_ADDR_TRANS=y
CONFIG_INFINIBAND_VIRT_DMA=y
# CONFIG_INFINIBAND_MTHCA is not set
CONFIG_INFINIBAND_IRDMA=m
CONFIG_MLX4_INFINIBAND=m
CONFIG_MLX5_INFINIBAND=m
CONFIG_INFINIBAND_OCRDMA=y
# CONFIG_INFINIBAND_VMWARE_PVRDMA is not set
# CONFIG_INFINIBAND_BNXT_RE is not set
# CONFIG_INFINIBAND_QEDR is not set
CONFIG_INFINIBAND_RDMAVT=m
CONFIG_INFINIBAND_IPOIB=m
CONFIG_INFINIBAND_IPOIB_CM=y
CONFIG_INFINIBAND_IPOIB_DEBUG=y
# CONFIG_INFINIBAND_SRP is not set
# CONFIG_INFINIBAND_ISER is not set
CONFIG_INFINIBAND_RTRS_CLIENT=y
CONFIG_INFINIBAND_RTRS_SERVER=m
# CONFIG_INFINIBAND_OPA_VNIC is not set
CONFIG_MLX_PLATFORM=m
# CONFIG_MELLANOX_PLATFORM is not set
CONFIG_SECURITY_INFINIBAND=y
```

If you are building a v1.3.4 kernel image, you can instead simply run the following to apply a patch to *kernel/build/config-amd64*:
```
diff --git a/kernel/build/config-amd64 b/kernel/build/config-amd64
index 341a7f5..ee12197 100644
--- a/kernel/build/config-amd64
+++ b/kernel/build/config-amd64
@@ -803,7 +803,7 @@ CONFIG_BASE_SMALL=0
 CONFIG_MODULE_SIG_FORMAT=y
 CONFIG_MODULES=y
 # CONFIG_MODULE_FORCE_LOAD is not set
-# CONFIG_MODULE_UNLOAD is not set
+CONFIG_MODULE_UNLOAD=y
 CONFIG_MODVERSIONS=y
 CONFIG_ASM_MODVERSIONS=y
 CONFIG_MODULE_SRCVERSION_ALL=y
@@ -2452,10 +2452,10 @@ CONFIG_SKY2=y
 CONFIG_NET_VENDOR_MELLANOX=y
 CONFIG_MLX4_EN=y
 CONFIG_MLX4_EN_DCB=y
-CONFIG_MLX4_CORE=y
+CONFIG_MLX4_CORE=m
 CONFIG_MLX4_DEBUG=y
 CONFIG_MLX4_CORE_GEN2=y
-CONFIG_MLX5_CORE=y
+CONFIG_MLX5_CORE=m
 CONFIG_MLX5_ACCEL=y
 CONFIG_MLX5_FPGA=y
 CONFIG_MLX5_CORE_EN=y
@@ -2471,16 +2471,16 @@ CONFIG_MLX5_CORE_IPOIB=y
 # CONFIG_MLX5_FPGA_IPSEC is not set
 # CONFIG_MLX5_IPSEC is not set
 CONFIG_MLX5_SW_STEERING=y
-# CONFIG_MLX5_SF is not set
-CONFIG_MLXSW_CORE=y
+CONFIG_MLX5_SF=y
+CONFIG_MLXSW_CORE=m
 CONFIG_MLXSW_CORE_HWMON=y
 CONFIG_MLXSW_CORE_THERMAL=y
-CONFIG_MLXSW_PCI=y
-CONFIG_MLXSW_I2C=y
-CONFIG_MLXSW_SPECTRUM=y
-CONFIG_MLXSW_SPECTRUM_DCB=y
-CONFIG_MLXSW_MINIMAL=y
-CONFIG_MLXFW=y
+CONFIG_MLXSW_PCI=m
+CONFIG_MLXSW_I2C=m
+CONFIG_MLXSW_SPECTRUM=m
+CONFIG_MLXSW_SPECTRUM_DCB=m
+CONFIG_MLXSW_MINIMAL=m
+CONFIG_MLXFW=m
 CONFIG_NET_VENDOR_MICREL=y
 # CONFIG_KS8842 is not set
 # CONFIG_KS8851_MLL is not set
@@ -4292,30 +4292,29 @@ CONFIG_LEDS_TRIGGERS=y
 # CONFIG_LEDS_TRIGGER_AUDIO is not set
 # CONFIG_LEDS_TRIGGER_TTY is not set
 # CONFIG_ACCESSIBILITY is not set
-CONFIG_INFINIBAND=y
-# CONFIG_INFINIBAND_USER_MAD is not set
-# CONFIG_INFINIBAND_USER_ACCESS is not set
+CONFIG_INFINIBAND=m
+CONFIG_INFINIBAND_USER_MAD=m
+CONFIG_INFINIBAND_USER_ACCESS=m
 CONFIG_INFINIBAND_ADDR_TRANS=y
 CONFIG_INFINIBAND_VIRT_DMA=y
 # CONFIG_INFINIBAND_MTHCA is not set
-# CONFIG_INFINIBAND_IRDMA is not set
-# CONFIG_MLX4_INFINIBAND is not set
-# CONFIG_MLX5_INFINIBAND is not set
-# CONFIG_INFINIBAND_OCRDMA is not set
+CONFIG_INFINIBAND_IRDMA=m
+CONFIG_MLX4_INFINIBAND=m
+CONFIG_MLX5_INFINIBAND=m
+CONFIG_INFINIBAND_OCRDMA=y
 # CONFIG_INFINIBAND_VMWARE_PVRDMA is not set
 # CONFIG_INFINIBAND_BNXT_RE is not set
 # CONFIG_INFINIBAND_QEDR is not set
-# CONFIG_INFINIBAND_RDMAVT is not set
-CONFIG_RDMA_RXE=y
+CONFIG_INFINIBAND_RDMAVT=m
+CONFIG_RDMA_RXE=m
 # CONFIG_RDMA_SIW is not set
-CONFIG_INFINIBAND_IPOIB=y
-# CONFIG_INFINIBAND_IPOIB_CM is not set
+CONFIG_INFINIBAND_IPOIB=m
+CONFIG_INFINIBAND_IPOIB_CM=y
 CONFIG_INFINIBAND_IPOIB_DEBUG=y
-# CONFIG_INFINIBAND_IPOIB_DEBUG_DATA is not set
 # CONFIG_INFINIBAND_SRP is not set
 # CONFIG_INFINIBAND_ISER is not set
-# CONFIG_INFINIBAND_RTRS_CLIENT is not set
-# CONFIG_INFINIBAND_RTRS_SERVER is not set
+CONFIG_INFINIBAND_RTRS_CLIENT=y
+CONFIG_INFINIBAND_RTRS_SERVER=m
 # CONFIG_INFINIBAND_OPA_VNIC is not set
 CONFIG_EDAC_ATOMIC_SCRUB=y
 CONFIG_EDAC_SUPPORT=y
@@ -4589,7 +4588,7 @@ CONFIG_EEEPC_LAPTOP=y
 # CONFIG_SYSTEM76_ACPI is not set
 # CONFIG_TOPSTAR_LAPTOP is not set
 # CONFIG_I2C_MULTI_INSTANTIATE is not set
-# CONFIG_MLX_PLATFORM is not set
+CONFIG_MLX_PLATFORM=m
 # CONFIG_INTEL_IPS is not set
 # CONFIG_INTEL_SCU_PCI is not set
 # CONFIG_INTEL_SCU_PLATFORM is not set
@@ -5071,7 +5070,7 @@ CONFIG_SECURITY_DMESG_RESTRICT=y
 CONFIG_SECURITY=y
 CONFIG_SECURITYFS=y
 CONFIG_SECURITY_NETWORK=y
-# CONFIG_SECURITY_INFINIBAND is not set
+CONFIG_SECURITY_INFINIBAND=y
 CONFIG_SECURITY_NETWORK_XFRM=y
 # CONFIG_SECURITY_PATH is not set
 # CONFIG_INTEL_TXT is not set
```
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

### Update Talos Machine Configuration
After upgrading the workers in your cluster, you will need to add a list of the kernel modules for talos to load.  This is done by updating the machine config for the worker nodes.

Updating talos node machine configuration directly:
```
machine:
  kernel:
    modules:
      - name: mlx5_core
      - name: mlx5_ib
      - name: ib_core
      - name: ib_uverbs
      - name: ib_ipoib
      - name: ib_umad
      - name: ib_cm
      - name: rdma_cm
      - name: rdma_ucm
      - name: mlxfw
```
Updating worker node configuration in the CAPI configPatches:
```
       - op: add
         path: /machine/kernel
         value: {}
       - op: add
         path: /machine/kernel/modules
         value:
         - name: mlx5_core
         - name: mlx5_ib
         - name: ib_core
         - name: ib_uverbs
         - name: ib_ipoib
         - name: ib_umad
         - name: ib_cm
         - name: rdma_cm
         - name: rdma_ucm
         - name: mlxfw
```
