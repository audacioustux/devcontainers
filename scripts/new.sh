#!/usr/bin/env bash

set -ea

# ensure 3 arguments were passed
if [ $# -ne 3 ]; then
    echo "Usage: $0 <feature_id> <feature_name> <feature_description>"
    exit 1
fi

FEATURE_ID=$1
FEATURE_NAME=$2
FEATURE_DESCRIPTION=$3

# ensure feature does not already exist
if [ -d src/$FEATURE_ID ]; then
    echo "Feature $FEATURE_ID already exists"
    exit 1
fi
# ensure feature id is lowercase
if [ "$FEATURE_ID" != "${FEATURE_ID,,}" ]; then
    echo "Feature id must be lowercase"
    exit 1
fi

# copy feature template
cp -rv templates/feature/src src/$FEATURE_ID
cp -rv templates/feature/test test/$FEATURE_ID

# update feature metadata
jq \
    --arg FEATURE_ID "$FEATURE_ID" \
    --arg FEATURE_NAME "$FEATURE_NAME" \
    --arg FEATURE_DESCRIPTION "$FEATURE_DESCRIPTION" \
    '.id = $FEATURE_ID | .name = $FEATURE_NAME | .description = $FEATURE_DESCRIPTION' \
    src/$FEATURE_ID/devcontainer-feature.json | sponge src/$FEATURE_ID/devcontainer-feature.json

# update feature test metadata
jq \
    --arg FEATURE_ID "$FEATURE_ID" \
    '.available_for_nonroot_user.features += {($FEATURE_ID): {}}' \
    test/$FEATURE_ID/scenarios.json | sponge test/$FEATURE_ID/scenarios.json

# update github workflow to include feature in matrix
TEST_WORKFLOW_FILE=".github/workflows/test.yaml"
echo "update: add feature($FEATURE_ID) to matrix in $TEST_WORKFLOW_FILE"
yq e '.jobs.test-scenarios.strategy.matrix.features += strenv(FEATURE_ID)' -i $TEST_WORKFLOW_FILE