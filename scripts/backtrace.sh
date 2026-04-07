#!/bin/bash
# Usage: backtrace <binary> [gtest_filter]
#
# Examples:
#   backtrace replicated_fast_count_test
#   backtrace replicated_fast_count_test '*.DirtyMetadataWrittenAsSingleApplyOpsEntry'
#   backtrace replicated_fast_count_test 'ReplicatedFastCountTest.*'

set -euo pipefail

if [[ $# -lt 1 ]]; then
    echo "Usage: backtrace <binary> [gtest_filter]"
    exit 1
fi

binary_name="$1"
filter="${2:-*}"
# Replace all instances of * with \* to prevent premature glob expansion.
escaped_filter="${filter//\*/\\*}"

# Ignore .runfiles symlink to ensure the build target is correct.
binary_path=$(find bazel-bin/ -name "$binary_name" -not -path '*.runfiles*' 2>/dev/null | head -1)

if [[ -z "$binary_path" ]]; then
    echo "Error: could not find '$binary_name' under bazel-bin/"
    exit 1
fi

# Compute build target argument and compile test using --config=dbg for full backtrace.
target_dir=$(dirname "${binary_path#bazel-bin/}")
target_name=$(basename "$binary_path")
bazel build --config=dbg "//${target_dir}:${target_name}"

bazel run gdb -- -batch \
    -ex "set confirm off" \
    -ex "catch throw" \
    -ex "run --gtest_filter=${escaped_filter}" \
    -ex "bt" \
    "$binary_path"
