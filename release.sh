#!/usr/bin/env sh

TAG_NAME="$1"

yq -i e ".images = [{\"name\": \"quay.io/sdase/opa\", \"newName\": \"quay.io/sdase/opa\", \"newTag\": \"${TAG_NAME}\"}]" bases/release-no-ns/kustomization.yaml

mkdir bundle || echo ""

kustomize build bases/release > bundle/k8s.yaml

git add bundle/k8s.yaml
git add bases/release-no-ns/kustomization.yaml
git commit -m "chore: prepare release ${TAG_NAME}"
git push
