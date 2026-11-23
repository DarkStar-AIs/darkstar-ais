# ATLAS — open-source Windows assistant

ATLAS is a Windows desktop AI assistant from Darkstar AIs, with local AI conversations via Ollama and a Python-based local web interface.

**Open-source preparation in progress.** The ATLAS source files and CI build must be published and validated before the project can apply for SignPath Foundation signing. The existing public Windows installer is **not** SignPath-signed. Do not represent it as such.

## Download
Website: https://darkstar-ai.pages.dev/atlas.html
Releases: https://github.com/DarkStar-AIs/darkstar-ais/releases

## Source
The source package is being prepared for publication here. The Windows app consists of `server.py`, `ATLAS_Launcher.py`, `app.js`, `index.html`, `style.css`, `assets/`, and installer/build scripts. No credentials or personal chat databases should be committed.

## Licence
The ATLAS application source is intended to be licensed under MIT; see [LICENSE](LICENSE). Third-party packages and media retain their respective terms.

## Security and signing
The current public installer is unsigned. A locally self-signed development certificate does not establish public trust. Free SignPath Foundation signing is subject to eligibility and approval. Read [CODE_SIGNING_POLICY.md](CODE_SIGNING_POLICY.md).

## Developer setup
Python 3.12, PyInstaller and Inno Setup 6 are used to build the Windows installer. Ollama and a local model are optional runtime dependencies for AI conversations. The CI workflow is pending until the application source has been uploaded and its build tested.
