# Bake definition for netresearch/docker-ftp-server.
#
# Consumed by the shared reusable workflow
# netresearch/.github/.github/workflows/build-container-bake.yml.
#
# Tags are deliberately NOT declared on `ftp-server`. The publishing tag scheme
# (branch / semver / sha / latest) is owned by docker/metadata-action inside the
# reusable workflow: it generates bake files that define the `docker-metadata-action`
# target below, which `ftp-server` inherits. Hardcoding `tags` here would fight
# that generated definition.
#
# The empty stub keeps the file valid on its own, so a plain
# `docker buildx bake` (or `--print`) works locally without metadata-action.
#
# The generated tag bake file also sets the build args DOCKER_META_IMAGES and
# DOCKER_META_VERSION on this target (docker/metadata-action src/meta.ts). The
# Dockerfile declares no ARG, so both are inert here — they show up in
# `bake --print` but never reach the build. That is expected; do not add ARGs
# just to consume them.
#
# Consumers that need their own tag (e.g. a validation build in ci.yml) supply it
# through the reusable workflow's `bake-set` input:
#     bake-set: ftp-server.tags=ghcr.io/netresearch/docker-ftp-server:test
# and, for a loadable single-arch image, `platforms: linux/amd64`.

target "docker-metadata-action" {}

target "ftp-server" {
  inherits   = ["docker-metadata-action"]
  context    = "."
  dockerfile = "Dockerfile"
  platforms  = ["linux/amd64", "linux/arm64"]
}

group "default" {
  targets = ["ftp-server"]
}
