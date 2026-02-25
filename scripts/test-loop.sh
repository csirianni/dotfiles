#!/bin/bash
# https://missing.csail.mit.edu/2026/course-shell/
set -euo pipefail

if [ $# -eq 0 ]; then
    echo "Usage: test-loop <command> [args...]"
    exit 1
fi

source "${HOME}/mongo/python3-venv/bin/activate"

# Setup log file
logfile="test_runs_$(date +%s).log"
echo "Logging to $logfile"

run=1
while "$@" > "$logfile" 2>&1; do
    echo "Run $run passed"
    ((run++))
done

echo "Test failed on run $run"
echo "Last 20 lines of output:"
tail -n 20 "$logfile"
echo "Full log: $logfile"
