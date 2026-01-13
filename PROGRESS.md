# Spaces Metaverse Development Progress

## Project Overview
Two parallel tracks to evolve the platform:
- **Gen 1**: Video canvas placement via React (extends catalogue system) - **COMPLETE**
- **Gen 2**: Unity Bridge architecture (thin client, platform-handled services) - PENDING

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

## Gen 2: Unity Bridge Architecture - PENDING

### Pending
- [ ] Create ActorService.js
- [ ] Create NetworkService.js
- [ ] Create ContentService.js
- [ ] Create SpacesBridge.cs (Unity)

---

## Files Created

### React (`ReactSpacesMonoRepo`)
1. `packages/webgl/src/components/VideoCanvasEditor.jsx`
2. `packages/webgl/src/hooks/unityEvents/useVideoCanvasItems.js`
3. `packages/webgl/src/hooks/unityEvents/usePlaceVideoCanvas.js`

### Unity (`spaces-unity-sdk`)
1. `Runtime/React/EventsManagement/DataClasses/VideoCanvasData.cs`
2. `Runtime/React/MonoBehaviours/IncomingEvents/VideoCanvasRenderer.cs`
3. `Runtime/React/EventsManagement/ReactIncomingEvent.cs` (modified)

---

## Firebase Schema

Video canvas items stored in `spaces/{spaceId}/catalogue/{canvasId}`:

```javascript
{
  type: "video_canvas",           // Required: identifies as video canvas
  canvasId: string,               // Unique identifier
  videoUrl: string,               // YouTube/Vimeo/direct/HLS URL
  videoType: "youtube" | "vimeo" | "direct" | "hls",
  aspectRatio: "16:9" | "4:3" | "1:1" | "9:16",
  autoplay: boolean,
  loop: boolean,
  muted: boolean,
  position: { x: number, y: number, z: number },
  rotation: { x: number, y: number, z: number },
  scale: { x: number, y: number, z: number },
  createdAt: number,
  updatedAt: number
}
```

---

## Unity Events

### React → Unity
- `PlaceVideoCanvas` - Create new video canvas in scene
- `UpdateVideoCanvas` - Update transform and video settings
- `DeleteVideoCanvas` - Remove video canvas from scene

### Unity → React
- `VideoCanvasClicked` - User clicked on video canvas

---

## Architecture Notes

### Gen 1 Pattern
React owns the data, Unity renders:
```
React (VideoCanvasEditor) → Firebase (catalogue) → Unity (VideoCanvasRenderer)
                         ← onSnapshot() ←
```

### Gen 2 Target (Spatial.io-like)
Platform handles services, Unity is thin client:
```
React Services (Actor, Network, Content) → Firebase → Unity Bridge
                                        ← Real-time sync ←
```

---

## Last Updated
2026-01-13
