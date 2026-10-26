# The organization runners' image: GitHub's actions-runner with what every
# Rust job would otherwise install with apt at its start. Rust itself, the
# cargo tools and sccache stay in the runners' shared tool cache, where
# setup-rust keeps them current.
FROM ghcr.io/actions/actions-runner:2.338.2@sha256:759a1d94a15b05941aba5196974ff43fe15b4cbba29b694b35cbc32a1166b232

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
