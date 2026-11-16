#!/usr/bin/env bash

#
# Prints the IDs of the Features that changed between two git revisions, one
# per line.
#
# A Feature lives in `src/<id>/` and is "changed" when any file inside that
# directory differs between the two revisions. Changes outside `src/` (for
# example to the CI configuration itself) do not select any Feature.
#
# Usage:
#   scripts/changed-features.sh <base-ref> [<head-ref>]
#
# <base-ref>  the revision to compare against (e.g. "origin/main").
# <head-ref>  the revision to inspect, defaults to the working tree.
#
# If the two revisions cannot be compared (for example on the very first
# commit, or when the base ref is unavailable), every Feature is printed so
# that nothing is silently skipped.
#
# The output can be consumed as a JSON array with:
#   scripts/changed-features.sh origin/main | jq -R -s -c 'split("\n") | map(select(length > 0))'

set -euo pipefail

BASE_REF="${1:-}"
HEAD_REF="${2:-}"

if [ -z "${BASE_REF}" ]; then
    echo "usage: $0 <base-ref> [<head-ref>]" >&2
    exit 2
fi

cd "$(git rev-parse --show-toplevel)"

FEATURE_DIR="src"

all_features() {
    find "${FEATURE_DIR}" -mindepth 1 -maxdepth 1 -type d -exec basename {} \; | sort
}

# A feature changed when any of its files differs between the two revisions.
# With an empty <head-ref> the working tree is compared instead.
changed_features() {
    local base="${1}" head="${2}"
    local -a diff_args

    # `--` separates the pathspec from the revisions so that a ref named like
    # a path cannot be mistaken for one.
    if [ -n "${head}" ]; then
        diff_args=("${base}" "${head}")
    else
        diff_args=("${base}")
    fi

    git diff --name-only "${diff_args[@]}" -- "${FEATURE_DIR}" \
        | awk -F/ 'NF > 2 { print $2 }' \
        | sort -u \
        | while read -r feature; do
            # Only keep entries that are still real Feature directories.
            if [ -d "${FEATURE_DIR}/${feature}" ]; then
                echo "${feature}"
            fi
        done
}

if ! git rev-parse --verify --quiet "${BASE_REF}" >/dev/null; then
    echo "Base ref '${BASE_REF}' not found, testing all features." >&2
    all_features
    exit 0
fi

result=$(changed_features "${BASE_REF}" "${HEAD_REF}")

if [ -z "${result}" ]; then
    exit 0
fi

echo "${result}"
