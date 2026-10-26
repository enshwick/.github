# The organization runners' image: GitHub's actions-runner with what every
# Rust job would otherwise install at its start: the apt packages, the cargo
# tools at the versions the shared workflows ask for (cargo-xwin, sccache,
# cargo-nextest, cargo-deny, cargo-cyclonedx, cargo-auditable), and a Wine prefix.
# Rust and the Windows SDK stay in the runners' persistent tool cache, where
# setup-rust finds them without a download and keeps them current.
FROM ghcr.io/actions/actions-runner:2.338.2@sha256:759a1d94a15b05941aba5196974ff43fe15b4cbba29b694b35cbc32a1166b232

LABEL org.opencontainers.image.source=https://github.com/enshwick/.github \
      org.opencontainers.image.description="Organization runner image of enshwick"

USER root

# clang and lld for cargo-xwin, Wine for the Windows tests, the 32-bit C
# runtime for SteamCMD, jq for the workflows' scripts, xz for tools packed
# as .tar.xz.
RUN dpkg --add-architecture i386 \
    && apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        clang lld wine wine64 lib32gcc-s1 jq xz-utils \
    && rm -rf /var/lib/apt/lists/*

# The cargo tools, prebuilt, checked against their published SHA-256 sums.
# setup-rust skips a tool whose name@version is listed in
# /opt/enshwick-tools; any other version it installs as before.
SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN set -eu; \
    mkdir -p /opt/enshwick-tools; \
    tool() { \
      name="$1"; version="$2"; sha="$3"; url="$4"; \
      curl --proto '=https' --tlsv1.2 -sSfL -o /tmp/archive "$url"; \
      echo "$sha  /tmp/archive" | sha256sum -c -; \
      mkdir /tmp/unpack; tar -xf /tmp/archive -C /tmp/unpack; \
      find /tmp/unpack -type f -name "$5" -exec install -m 0755 {} /usr/local/bin/ \; ; \
      rm -rf /tmp/archive /tmp/unpack; \
      echo "$name@$version" >> /opt/enshwick-tools/list; \
    }; \
    tool cargo-xwin 0.23.1 c492c6dfb7e5ac0eee586b796e0fc950ba13077e7f0bbb046f445d71790d5360 \
      https://github.com/rust-cross/cargo-xwin/releases/download/v0.23.1/cargo-xwin-v0.23.1.x86_64-unknown-linux-musl.tar.gz cargo-xwin; \
    tool sccache 0.18.0 45f1447fbe231e3037bde351ef70677dd212216c8d62ae7ca409fecc4d6acc89 \
      https://github.com/mozilla/sccache/releases/download/v0.18.0/sccache-v0.18.0-x86_64-unknown-linux-musl.tar.gz sccache; \
    tool cargo-nextest 0.9.149 d65c7f14bcb5c1566d1ecd534c5da8dedb81ba58586e478b0ab81c877d2bd8ad \
      https://github.com/nextest-rs/nextest/releases/download/cargo-nextest-0.9.149/cargo-nextest-0.9.149-x86_64-unknown-linux-musl.tar.gz cargo-nextest; \
    tool cargo-deny 0.20.2 9f12ed4c49936e09b48bf862b595cde2fe64fcbd9d74dfacac6131ca824c8d5f \
      https://github.com/EmbarkStudios/cargo-deny/releases/download/0.20.2/cargo-deny-0.20.2-x86_64-unknown-linux-musl.tar.gz cargo-deny; \
    tool cargo-cyclonedx 0.5.9 9bd3e599314f50810c9d98b8b68a617ff9d3cc20873968d90b29d121f6b226ff \
      https://github.com/CycloneDX/cyclonedx-rust-cargo/releases/download/cargo-cyclonedx-0.5.9/cargo-cyclonedx-x86_64-unknown-linux-musl.tar.xz cargo-cyclonedx; \
    tool cargo-auditable 0.7.7 7676443367c5e33d9fb22acef63cccb5e9202de12dae1b0579995eb3e2bc7a18 \
      https://github.com/rust-secure-code/cargo-auditable/releases/download/v0.7.7/cargo-auditable-x86_64-unknown-linux-musl.tar.xz cargo-auditable; \
    # cargo-auditable only wraps cargo, which lives in the tool cache.
    test -x /usr/local/bin/cargo-auditable; \
    for t in cargo-xwin sccache cargo-nextest cargo-deny cargo-cyclonedx; do "/usr/local/bin/$t" --version > /dev/null 2>&1 || "/usr/local/bin/$t" "${t#cargo-}" --version; done

USER runner

# The Wine prefix, made once here instead of by every Wine job (8 s).
# wineboot returns before wineserver has written the registry.
RUN WINEDEBUG=-all wineboot -i > /dev/null 2>&1; wineserver -w; ls "$HOME/.wine"; test -f "$HOME/.wine/system.reg"
