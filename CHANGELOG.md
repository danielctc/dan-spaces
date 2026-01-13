# Changelog

All notable changes to the Spaces Metaverse project.

## [Unreleased]

### Added

#### Gen 1: Video Canvas via React
- **VideoCanvasEditor.jsx** - React component for editing video canvases
  - Position/rotation/scale controls
  - Video URL input with auto-detection (YouTube, Vimeo, HLS, direct)
  - Aspect ratio selector (16:9, 4:3, 1:1, 9:16)
  - Real-time Unity updates + debounced Firebase saves
- **useVideoCanvasItems.js** - Hook to load/sync video canvas items from Firebase
- **usePlaceVideoCanvas.js** - Hook to place video canvas in Unity
- **VideoCanvasData.cs** - Unity data classes for video canvas events
- **VideoCanvasRenderer.cs** - Unity MonoBehaviour to manage video canvases

#### Gen 2: Unity Bridge Architecture
- **ActorService.js** - Player/actor state management via Firebase Realtime Database
  - Join/leave space instances
  - Real-time position/rotation/animation sync
  - Voice state tracking
- **NetworkService.js** - Networking and RPC service
  - Event broadcasting to all/specific actors
  - Connection state management
  - Ownership request/transfer
- **ContentService.js** - Networked object management
  - Spawn/despawn objects
  - Object ownership (distributed authority)
  - Transform and state sync
- **SpacesBridge.cs** - Unity thin client entry point
  - Receives state from React, renders in Unity
  - Remote actor interpolation
  - Networked object management
- **BridgeData.cs** - Data classes for bridge events
- **BridgeRaiseEvent.cs** - Sends events from Unity to React via JS interop

### Changed

#### Phase 3: Code Refactoring
- **ReactIncomingEvent.cs** - Replaced 270-line switch statement with handler registry pattern
  - `RegisterHandler<T>(eventName, handler)` for typed handlers
  - `UnregisterHandler(eventName)` for cleanup
  - Dictionary lookup instead of switch
  - Backward compatible with all legacy events
- **react-log.js** - Fixed Logger.log which was not outputting anything
- **useUnityMessaging.js** - New centralised Unity communication hook
  - Uses `UnityInstanceContext` from react-unity-webgl when available
  - Falls back to `window.unityInstance` for compatibility
  - `isReady` state for Unity availability
  - `sendMessage()`, `sendEvent()`, `sendRawEvent()` methods
  - `disableInput()`/`enableInput()` for modal input handling

### Technical Details

#### Architecture Pattern (Gen 2)
Following Spatial.io's thin client pattern:
- **Unity** handles: 3D rendering, local physics, user input, animation, audio
- **Platform (React/Firebase)** handles: Player sync, object ownership, matchmaking, RPCs, persistence

#### Event Registry Pattern
```csharp
// New pattern - MonoBehaviours register their own handlers
ReactIncomingEvent.RegisterHandler<MyData>("MyEvent", data => {
    // Handle event
});
```

#### Unity Messaging Hook
```javascript
// New centralised hook
const { isReady, sendMessage, sendEvent } = useUnityMessaging();
if (isReady) sendEvent('PlaceVideoCanvas', data);
```

### Dependencies
- react-unity-webgl: ^10.1.5 (verified against v10.1.6 patterns)
- Firebase JS SDK (Realtime Database)
- Unity 6 WebGL

### Repositories
- Monorepo: https://github.com/danielctc/dan-spaces
- Unity SDK: https://github.com/danielctc/spaces-unity-sdk
- React Bridge: https://github.com/danielctc/ReactSpacesMonoRepo
- Website: https://github.com/danielctc/spaces-website
