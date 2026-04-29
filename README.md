# MoonShot

A SwiftUI app from Hacking with Swift (Project 8) that displays NASA Apollo mission data, crew members, and astronaut profiles.

## What the App Does

- Grid view of all Apollo missions with mission badge and launch date
- Tap a mission to see its description and full crew list
- Tap a crew member to see their astronaut profile and biography
- Dark theme throughout using custom SwiftUI color extensions

## What I Learned

### JSON Decoding
- Used a generic `Bundle.decode<T: Codable>()` extension to load JSON from the app bundle into any `Codable` type
- Configured `JSONDecoder` with a custom `dateDecodingStrategy` to parse date strings (`"y-MM-dd"`) directly into `Date?`
- Worked with hierarchical JSON by using nested `Codable` structs (e.g. `Mission.CrewRole`)

### Computed Properties
- Added computed properties (`displayName`, `image`, `formattedLaunchDate`) to `Mission` to keep formatting logic out of views
- Used `Date.formatted(date:time:)` — the modern Swift API — instead of the older `DateFormatter` string approach

### Custom Initializers in Views
- Wrote a custom `init(mission:astronauts:)` on `MissionView` to join raw crew role data from JSON with full `Astronaut` objects at init time, producing a resolved `[Mission.CrewMember]` array the view can use directly

### Nested Types
- Defined `Mission.CrewRole` (Codable, mirrors JSON) and `Mission.CrewMember` (resolved, holds a full `Astronaut`) as separate nested structs inside `Mission`
- Learned to reference nested types from other files using the full qualifier (`Mission.CrewMember`)

### LazyVGrid & ScrollView
- Built a two-column adaptive grid using `LazyVGrid` with `GridItem(.adaptive(minimum: 150))`
- Used `ScrollView(.horizontal, showsIndicators: false)` for the crew scroll row in the mission detail view
- Used `containerRelativeFrame(.horizontal)` to size the mission badge image as a fraction of its parent

### Navigation
- Used `NavigationStack` + `NavigationLink` for drill-down navigation (mission list → mission detail → astronaut detail)
- Applied `.navigationBarTitleDisplayMode(.inline)` and `.preferredColorScheme(.dark)` on detail views

### Custom Styling
- Extended `ShapeStyle where Self == Color` to add `.darkBackground` and `.lightBackground` as first-class SwiftUI color values usable anywhere a `ShapeStyle` is accepted
- Used `.clipShape(.rect(cornerRadius:))` + `.overlay(RoundedRectangle.strokeBorder)` for card borders
- Used a custom `Rectangle().frame(height: 2)` as a styled divider instead of SwiftUI's default `Divider`
- Applied `.clipShape(.capsule)` + `Capsule().strokeBorder` for astronaut portrait images
