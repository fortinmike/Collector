#!/bin/sh
set -e

cd Collector

pod install

xctool -workspace Collector.xcworkspace -scheme Collector.iOS test
xctool -workspace Collector.xcworkspace -scheme Collector.Mac test