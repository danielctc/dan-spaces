# Dan Spaces Monorepo

Unified development environment for Spaces Metaverse platform.

## Structure

```
dan-spaces/
├── unity-sdk/          # Unity SDK (spaces-unity-sdk)
├── react-bridge/       # React WebGL bridge (ReactSpacesMonoRepo)
├── website/            # Marketing website (spaces-website)
├── shared/             # Shared utilities and configs
└── scripts/            # Development scripts
```

## Quick Start

```bash
# Clone with submodules
git clone --recurse-submodules https://github.com/daniel/dan-spaces.git

# Or if already cloned
git submodule update --init --recursive
```

## Working with Submodules

Each project is an independent git repository. Changes stay isolated.

### Update a specific project

```bash
# Pull latest from upstream
cd unity-sdk
git pull origin main

# Or update all submodules
git submodule update --remote
```

### Make changes to a project

```bash
cd react-bridge
git checkout -b feature/my-feature
# ... make changes ...
git add .
git commit -m "feat: my feature"
git push origin feature/my-feature
```

### Commit submodule pointer updates

After pulling updates in a submodule:

```bash
cd ..
git add unity-sdk
git commit -m "chore: update unity-sdk to latest"
```

## Projects

| Directory | Upstream Repo | Description |
|-----------|---------------|-------------|
| unity-sdk | spacesmetaverse/spaces-unity-sdk | Unity WebGL SDK |
| react-bridge | spacesmetaverse/ReactSpacesMonoRepo | React bridge + WebGL |
| website | spacesmetaverse/spaces-website | Marketing site |

## Development Workflow

### Gen 1: Video Canvas (Current)
- React owns video canvas data (Firebase)
- Unity renders based on React events
- See [react-bridge/packages/webgl/src/components/VideoCanvasEditor.jsx](react-bridge/packages/webgl/src/components/VideoCanvasEditor.jsx)

### Gen 2: Unity Bridge (Planned)
- Platform-handled services (Actor, Network, Content)
- Unity as thin client renderer
- Firebase real-time sync

## Useful Commands

```bash
# Status of all submodules
git submodule status

# Foreach - run command in all submodules
git submodule foreach 'git status'

# Pull latest in all submodules
git submodule foreach 'git pull origin main'
```
