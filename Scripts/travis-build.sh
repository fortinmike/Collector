#!/bin/sh
set -e

pod install
xctool -workspace Collector/Collector.xcworkspace -scheme Collector.iOS test
xctool -workspace Collector/Collector.xcworkspace -scheme Collector.Mac test