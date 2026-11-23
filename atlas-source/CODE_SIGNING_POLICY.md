# ATLAS code-signing policy (draft)

**Status:** SignPath Foundation application not yet submitted or approved. No trusted certificate has been issued to ATLAS.

- Official project: https://github.com/DarkStar-AIs/darkstar-ais
- Distribution: https://darkstar-ai.pages.dev/atlas.html
- Proposed signing scope: ATLAS Windows installer built by CI from reviewed, publicly available source.
- Signing requests must be manually approved by an authorized maintainer.
- Maintainers must use MFA and protect release permissions.
- Build outputs must be traceable to a commit and reproducible to the extent practical.
- No privately built, modified, or development-self-signed binaries should be presented as SignPath-approved releases.
- Dependencies, licence compatibility, and the privacy/security implications of local control endpoints must be reviewed before submitting.
- Public releases should include SHA-256 checksums and accurate version numbers.

This policy is a draft and does not represent acceptance by SignPath Foundation.
