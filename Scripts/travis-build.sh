#!/bin/sh
set -e

xctool -workspace ../Collector/MyApp.xcworkspace -scheme Collector.iOS test
xctool -workspace ../Collector/MyApp.xcworkspace -scheme Collector.Mac test