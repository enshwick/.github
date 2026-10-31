# Security

enshwick loads code into the game and the dedicated server, so a flaw in it
can reach players' machines and servers. Report one privately in the
repository's **Security** tab with **Report a vulnerability**. Mail to
[security@enshwick.com](mailto:security@enshwick.com) works too. Please do
not open a public issue for it.

A report helps most when it says what is affected (loader, a mod, the
server image), which versions, and how to reproduce it.

## Check a download

Every archive, PDB and SBOM our builds publish carries a build provenance
attestation. With the [GitHub CLI](https://cli.github.com), this checks
that a file was built by a workflow of the organization from one of its
repositories. Put the name of the downloaded file in place of
`enshwick.zip`:

```bash
gh attestation verify enshwick.zip --owner enshwick
```
