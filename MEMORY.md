# Project Memory: Android Watch Faces

## Goal
Create several Android watch faces using the Watch Face Format (WFF).

## Tech Stack
- Android Gradle Plugin 8.2.2
- Gradle 9.4
- Watch Face Format 2 (Wear OS 5+)

## Project Structure
- `digital-basic/`: Digital watch face with battery, heart rate, and 4 customizable color themes (Green, Blue, Red, Gold).
- `analog-basic/`: Simple analog watch face with hour markers.
- `analog-modern/`: Sophisticated analog face with radial gradients and integrated complications.

## Learnings
- WFF projects are "resource-only" (set `android:hasCode="false"` in manifest).
- `watch_face_info.xml` needs `<WatchFaceInfo>` root without `android:` namespace for custom attributes if not using standard ones.
- The link to the watch face XML is via `<property android:name="com.google.wear.watchface.format.definition" android:resource="@raw/watchface" />` in `AndroidManifest.xml`.
- `local.properties` is needed for `sdk.dir`.
- Hands in `AnalogClock` can use `PartDraw` for custom shapes instead of images.
- `Sweep` element in hands controls the movement frequency (e.g., for smooth second hands).
- `ComplicationSlot` allows adding customizable data (Battery, HR, etc.) to the face.
- `UserConfigurations` (like `ColorConfiguration`) enables user personalization in the watch's editor.
- Gradients (`RadialGradient`, `LinearGradient`) can be used in `<Fill>` for advanced visual effects.

## Next Steps
1. Add complications to one of the watch faces.
2. Create a "luxury" or "modern" watch face.
3. Add user configurations (e.g., color selection).
