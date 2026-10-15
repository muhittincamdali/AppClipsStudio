#!/usr/bin/env bash
# Captures the README screenshots of the example App Clip on an iOS simulator.
#
# Builds Examples/CoffeeShop, installs the App Clip, opens it with each invocation URL through
# the example's DEBUG-only `-demoURL` launch argument, and saves light and dark screenshots to
# docs/images.
#
# Usage: scripts/capture-screenshots.sh [simulator name or UDID]
set -euo pipefail

repo_root="$(cd "$(dirname "$0")/.." && pwd)"
device="${1:-}"
if [[ -z "$device" ]]; then
  device="$(xcrun simctl list devices available | grep -m1 -oE 'iPhone [^(]+' | sed 's/ *$//')"
fi
if [[ -z "$device" ]]; then
  echo "No available iPhone simulator found." >&2
  exit 1
fi

derived_data="$repo_root/.build/example-derived-data"
output_dir="$repo_root/docs/images"
clip_id="io.github.muhittincamdali.CoffeeShop.Clip"
mkdir -p "$output_dir"

if [[ "$device" =~ ^[0-9A-F-]{36}$ ]]; then
  destination="platform=iOS Simulator,id=$device"
else
  destination="platform=iOS Simulator,name=$device"
fi

echo "Building the example for '$device'"
xcodebuild build \
  -project "$repo_root/Examples/CoffeeShop/CoffeeShop.xcodeproj" \
  -scheme CoffeeShop \
  -destination "$destination" \
  -derivedDataPath "$derived_data" \
  -skipPackagePluginValidation -quiet

clip_app="$derived_data/Build/Products/Debug-iphonesimulator/CoffeeShopClip.app"
xcrun simctl boot "$device" 2>/dev/null || true
xcrun simctl bootstatus "$device" -b >/dev/null
xcrun simctl install "$device" "$clip_app"
xcrun simctl status_bar "$device" override --time 9:41 --batteryState charged --batteryLevel 100 \
  --cellularBars 4 --wifiBars 3

capture() {
  local name="$1" url="$2" appearance
  for appearance in light dark; do
    xcrun simctl ui "$device" appearance "$appearance"
    xcrun simctl terminate "$device" "$clip_id" 2>/dev/null || true
    xcrun simctl launch "$device" "$clip_id" -demoURL "$url" >/dev/null
    sleep 4
    xcrun simctl io "$device" screenshot --type=png "$output_dir/$name-$appearance.png" >/dev/null
    # Half the device resolution keeps each image well under 1 MB.
    sips --resampleWidth 603 "$output_dir/$name-$appearance.png" >/dev/null
    echo "  $output_dir/$name-$appearance.png"
  done
}

capture table "https://appclip.example.com/table/12?p=1"
capture poster "https://appclip.example.com/order?p=3"

xcrun simctl terminate "$device" "$clip_id" 2>/dev/null || true
xcrun simctl status_bar "$device" clear
xcrun simctl ui "$device" appearance light
