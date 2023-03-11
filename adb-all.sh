#!/bin/bash

# adb-all - A tool to run ADB commands for all connected devices.
#
# Usage:
#   adb-all <command>
#
# Description:
#   Runs the specified ADB command on all connected Android devices. 
#   The command is executed in parallel on each device, and the output from
#   each device is displayed separately.
#
# Options:
#   --help: Print this help message and exit.
#
# Examples:
#   adb-all shell pm list packages
#   adb-all install my_app.apk
#   adb-all logcat -c 

# Define color codes for each device
red='\033[0;31m'
green='\033[0;32m'
yellow='\033[0;33m'
blue='\033[0;34m'
purple='\033[0;35m'
cyan='\033[0;36m'
gray='\033[0;37m'
# Define a reset color code
reset_color='\033[0m'
# Initialize the color index
color_index=0

# Handle command-line options
while [[ $# -gt 0 ]]; do
  case "$1" in
    --help)
      sed -n '2,19p' "$0" # Print the usage message from the script header
      exit 0
      ;;
    *)
      break
      ;;
  esac
done

# Get a list of connected devices
devices=$(adb devices | tail -n +2 | cut -sf 1)

# Handle interrupt signal (Ctrl+C)
trap 'echo "Interrupted! Stopping execution on all devices..."; kill $(jobs -p); exit 1' INT

# Execute the specified command on each device in parallel
for device in $devices; do
  # Set the color for the device
  if [ $color_index -eq 0 ]; then
    color_code=$red
  elif [ $color_index -eq 1 ]; then
    color_code=$green
  elif [ $color_index -eq 2 ]; then
    color_code=$yellow
  elif [ $color_index -eq 3 ]; then
    color_code=$blue
  elif [ $color_index -eq 4 ]; then
    color_code=$purple
  elif [ $color_index -eq 5 ]; then
    color_code=$cyan
  elif [ $color_index -eq 6 ]; then
    color_code=$gray
  fi
  color_index=$(( (color_index + 1) % 7 )) # Increment the color index and wrap around

  # Execute the specified command on the device and prepend device name to output
  echo -e "${color_code}Output from device $device:${reset_color}"
  adb -s $device $* | sed "s/^/$(echo -e ${color_code})$device: $(echo -e ${reset_color})/" &
done

# Wait for all parallel commands to finish
wait

