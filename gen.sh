#!/bin/bash

# Copyright Istio Authors

#   Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
#   You may obtain a copy of the License at
#
#       http://www.apache.org/licenses/LICENSE-2.0
#
#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#   limitations under the License.

set -eu

# Sync API versions
scripts/sync.sh

# Generate all protos
buf generate \
  --path metaprotocol \
  --path dubbo \
  --path redis \

# Generate CRDs and open-api schema
cue-gen -paths=common-protos -f=./cue.yaml
cue-gen -paths=common-protos -f=./cue.yaml --crd=true -snake=jwksUri,apiKeys,apiSpecs,includedPaths,jwtHeaders,triggerRules,excludedPaths,mirrorPercent
