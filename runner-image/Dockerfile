# The organization runners' image: GitHub's actions-runner with what every
# Rust job would otherwise install with apt at its start. Rust itself, the
# cargo tools and sccache stay in the runners' shared tool cache, where
# setup-rust keeps them current.
FROM ghcr.io/actions/actions-runner:2.338.0@sha256:4ffadc0002b2581327e06101fc8c06cd189232baf79fe561fac9caeb76f5e807

LABEL org.opencontainers.image.source=https://github.com/enshwick/.github \
      org.opencontainers.image.description="Organization runner image of enshwick"

USER root

# clang and lld for cargo-xwin, Wine for the Windows tests, the 32-bit C
# runtime for SteamCMD, jq for the workflows' scripts.
RUN dpkg --add-architecture i386 \
    && apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        clang lld wine wine64 lib32gcc-s1 jq \
    && rm -rf /var/lib/apt/lists/*

USER runner
