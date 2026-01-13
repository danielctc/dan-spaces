# Spaces Metaverse Development Progress

## Project Overview
Two parallel tracks to evolve the platform:
- **Gen 1**: Video canvas placement via React (extends catalogue system) - **COMPLETE**
- **Gen 2**: Unity Bridge architecture (thin client, platform-handled services) - **COMPLETE**

---

## Gen 1: Video Canvas via React - COMPLETE

### React Side (`ReactSpacesMonoRepo`)
- [x] **VideoCanvasEditor.jsx** - React component for editing video canvas
  - Position/rotation/scale controls
  - Video URL input with auto-detection (YouTube, Vimeo, HLS, direct)
  - Aspect ratio selector (16:9, 4:3, 1:1, 9:16)
  - Playback options (autoplay, loop, muted)
  - Real-time Unity updates + debounced Firebase saves
- [x] **useVideoCanvasItems.js** - Hook to load/sync video canvas items
  - Filters catalogue items where `type === "video_canvas"`
  - Real-time Firestore listener
  - Handles add/modify/remove events
- [x] **usePlaceVideoCanvas.js** - Hook to place video canvas in Unity

### Unity Side (`spaces-unity-sdk`)
- [x] **VideoCanvasData.cs** - Data classes for video canvas events
- [x] **VideoCanvasRenderer.cs** - MonoBehaviour to manage video canvases
  - Places/updates/deletes video canvases
  - Auto-loads YouTube thumbnails
  - Click detection sends events to React
- [x] **ReactIncomingEvent.cs** - Added video canvas event handlers

---

## Gen 2: Unity Bridge Architecture - COMPLETE

### React Platform Services (`ReactSpacesMonoRepo`)
- [x] **ActorService.js** - Player/actor state management
  - Join/leave space instances
  - Real-time position/rotation/animation sync
  - Voice state tracking
  - Firebase Realtime Database for low-latency updates
- [x] **NetworkService.js** - Networking and RPC service
  - Event broadcasting to all/specific actors
  - Connection state management
  - Ownership request/transfer
  - Custom event handlers
- [x] **ContentService.js** - Networked object management
  - Spawn/despawn objects
  - Object ownership (distributed authority)
  - Transform and state sync
  - Object type filtering

### Unity Bridge (`spaces-unity-sdk`)
- [x] **SpacesBridge.cs** - Main entry point for thin client
  - Receives state from React, renders in Unity
  - Remote actor interpolation
  - Networked object management
  - Input capture and forwarding to React
- [x] **BridgeData.cs** - Data classes for bridge events
- [x] **BridgeRaiseEvent.cs** - Sends events from Unity to React
- [x] **ReactIncomingEvent.cs** - Added bridge event handlers

---

## Files Created

### React (`ReactSpacesMonoRepo`)
1. `packages/webgl/src/components/VideoCanvasEditor.jsx`
2. `packages/webgl/src/hooks/unityEvents/useVideoCanvasItems.js`
3. `packages/webgl/src/hooks/unityEvents/usePlaceVideoCanvas.js`
4. `packages/shared/src/services/ActorService.js`
5. `packages/shared/src/services/NetworkService.js`
6. `packages/shared/src/services/ContentService.js`

### Unity (`spaces-unity-sdk`)
1. `Runtime/React/EventsManagement/DataClasses/VideoCanvasData.cs`
2. `Runtime/React/MonoBehaviours/IncomingEvents/VideoCanvasRenderer.cs`
3. `Runtime/Bridge/SpacesBridge.cs`
4. `Runtime/Bridge/BridgeData.cs`
5. `Runtime/Bridge/BridgeRaiseEvent.cs`
6. `Runtime/React/EventsManagement/ReactIncomingEvent.cs` (modified)

---

## Architecture

### Gen 1 Pattern (Video Canvas)
React owns the data, Unity renders:
```
React (VideoCanvasEditor) → Firebase (catalogue) → Unity (VideoCanvasRenderer)
                         ← onSnapshot() ←
```

### Gen 2 Pattern (Unity Bridge - like Spatial.io)
Platform handles services, Unity is thin client:
```
┌─────────────────────────────────────────────────────────────────┐
│                         React Layer                              │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐             │
│  │ ActorService│  │NetworkService│  │ContentService│             │
│  │ (players)   │  │ (sync/RPCs) │  │ (objects)   │             │
│  └──────┬──────┘  └──────┬──────┘  └──────┬──────┘             │
│         └────────────────┼────────────────┘                      │
│                          ▼                                       │
│                   Firebase Realtime DB                           │
│                          │                                       │
└──────────────────────────┼──────────────────────────────────────┘
                           ▼
┌──────────────────────────────────────────────────────────────────┐
│                      Unity Bridge                                │
│  - Receives state updates from React                             │
│  - Sends user input/actions to React                             │
│  - Renders scene based on state                                  │
│  - NO networking code (Photon/etc)                               │
│  - NO game logic (handled by React services)                     │
└──────────────────────────────────────────────────────────────────┘
```

**Unity Responsibilities (thin client):**
- 3D rendering
- Local physics (collision detection)
- User input capture
- Animation playback
- Audio playback

**Platform Responsibilities (React/Firebase):**
- Player state sync
- Object ownership
- Matchmaking
- RPCs/events
- Voice/text chat
- Persistence

---

## GitHub Repositories

- **Monorepo**: https://github.com/danielctc/dan-spaces
- **Unity SDK**: https://github.com/danielctc/spaces-unity-sdk
- **React Bridge**: https://github.com/danielctc/ReactSpacesMonoRepo
- **Website**: https://github.com/danielctc/spaces-website

---

## Last Updated
2026-01-13
