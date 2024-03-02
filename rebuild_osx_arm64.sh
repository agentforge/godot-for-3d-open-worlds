#!/bin/bash

# Ensure the logs directory exists
mkdir -p ./logs

# For incremental
export SCONS_CACHE="./scons_cache/godot_4_scons_cache_macos";
mkdir -p $SCONS_CACHE

# Check if SCons is installed
WHICHSCONS=$(which scons)

if [ -z "$WHICHSCONS" ]; then
	echo "SCONS NOT FOUND"
	exit 1
else
	echo "SCONS FOUND"
fi

# Adjusted platform and target values, and included Vulkan SDK path as needed
scons -j$(sysctl -n hw.ncpu) platform=macos arch=arm64 precision=double use_llvm=yes vulkan_sdk_path=YOUR_VULKAN_SDK_PATH 2>&1 | tee ./logs/godot_4_scons_macos_arm64_tools_build.txt

# Template(s)
scons -j$(sysctl -n hw.ncpu) platform=macos arch=arm64 precision=double use_llvm=yes target=template_debug vulkan_sdk_path=YOUR_VULKAN_SDK_PATH 2>&1 | tee 
./logs/godot_4_scons_macos_arm64_template_debug_build.txt

scons -j$(sysctl -n hw.ncpu) platform=macos arch=arm64 precision=double use_llvm=yes target=template_release vulkan_sdk_path=YOUR_VULKAN_SDK_PATH 2>&1 | tee 
./logs/godot_4_scons_macos_arm64_template_release_build.txt

echo "DONE BUILDING macOS arm64"
