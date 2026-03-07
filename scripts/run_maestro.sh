#!/bin/bash
set -uo pipefail
REPORT_DIR=".maestro/reports"
mkdir -p "$REPORT_DIR"

# Build & install
flutter build apk --debug
adb install -r build/app/outputs/flutter-apk/app-debug.apk

# Run Maestro
maestro test \
  --format junit \
  --output "$REPORT_DIR/report.xml" \
  --debug-output "$REPORT_DIR/debug" \
  --no-ansi \
  .maestro/flows/

EXIT_CODE=$?
echo "--- Result: $([ $EXIT_CODE -eq 0 ] && echo PASS || echo FAIL) ---"
exit $EXIT_CODE
