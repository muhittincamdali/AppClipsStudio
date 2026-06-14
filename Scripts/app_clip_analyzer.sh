#!/bin/bash

# A Strict Binary Size Profiler for App Clips
# App Clips have a hard 15MB limit. This tool ensures we never cross the threshold.

echo "🔍 Analyzing App Clip Binary Size..."

# Find the built App Clip
APP_CLIP_PATH=$(find .build -name "*.app" -type d | grep "AppClip" | head -n 1)

if [ -z "$APP_CLIP_PATH" ]; then
    echo "❌ No compiled App Clip found. Please build the project first."
    exit 1
fi

# Calculate uncompressed size
SIZE_KB=$(du -sk "$APP_CLIP_PATH" | awk '{print $1}')
SIZE_MB=$(echo "scale=2; $SIZE_KB / 1024" | bc)

echo "📊 Raw Size: ${SIZE_MB} MB"

if (( $(echo "$SIZE_MB > 14.5" | bc -l) )); then
    echo "⚠️ WARNING: App Clip size is critically close to the 15MB limit!"
    echo "Recommendation: Strip SwiftNetwork or SwiftCache down to core essentials."
    exit 1
else
    echo "✅ PASS: App Clip is safely under the limit. (Limit: 15MB)"
fi
