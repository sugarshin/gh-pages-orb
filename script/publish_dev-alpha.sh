#!/bin/bash
#
# Publish orb with dev:alpha version
# `CIRCLECI_CLI_TOKEN` envvar is required
#
# this script is not intended for normally use
# it will be used only if dev:alpha version has expired and no longer exists unintentionally

set -eu

circleci orb pack --skip-update-check src > orb.yml
circleci orb publish --skip-update-check orb.yml sugarshin/gh-pages@dev:alpha
