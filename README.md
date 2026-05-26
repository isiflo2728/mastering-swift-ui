# Mastering SwiftUI

This is where the grind lives.

Every project, every bug fixed, every line of Swift written here is proof that the work is being put in. Building real apps from scratch takes patience and consistency — and that's exactly what's happening here.

## What This Repo Is

A collection of SwiftUI projects built while mastering iOS development. From the ground up. No shortcuts.

## Projects

- **WordScramble** — A word game built with SwiftUI, covering List, NavigationStack, TextField, and more.
- **AnimationTechnique** — Exploring SwiftUI animations: implicit/explicit animations, transitions, and motion effects. Lives on the `animation-technique` branch.
- **iExpense** — Expense tracker with personal/business filtering, UserDefaults persistence, and swipe-to-delete. Lives on the `iexpense` branch.
- **Moonshot** — An interactive history of the Apollo missions. Browse every Apollo mission in a dark-themed LazyVGrid, tap into mission details with crew highlights and descriptions, and drill further into individual astronaut bios. Built with JSON decoding via a generic `Bundle` extension, `Codable` models (`Mission` and `Astronaut`), `NavigationStack` with multi-level drill-down, `LazyVGrid` with adaptive columns, and a custom dark color theme.
- **Cupcake Corner** — A multi-screen cupcake ordering app that submits orders via a POST request using `URLSession`. Covers `Codable` for JSON encoding/decoding, `@Observable` for shared state across views, form validation with `disabled`, and `AsyncImage` for loading remote images. Lives on the `cupcake-corner` branch.
- **BookWorm** — A book tracking app built with SwiftData. Add books by title, author, and genre, rate them with a custom star rating component, and write reviews. Covers `@Model`, `@Query`, `ModelContainer`, SwiftData persistence, custom `@Binding` views, and `NavigationStack` with detail drill-down. Lives on the `bookworm` branch.
- **SwiftDataProject** — A user management app exploring SwiftData deeper. Covers relationships between models (`User` and `Job`), dynamic filtering with `#Predicate`, dynamic sorting with `SortDescriptor`, programmatic navigation, iCloud sync via CloudKit, and separating query logic into dedicated views with custom initializers. Lives on the `swiftdata-project` branch.
- **InstaFilter** — A photo filter app using Core Image. Import photos from your library, apply filters (Sepia, Crystallize, Pixellate, Gaussian Blur, and more), adjust intensity with a slider, and share the result. Covers `CIFilter`, `CIContext`, `PhotosPicker`, `@AppStorage`, `ShareLink`, and App Store review prompts via `StoreKit`. Lives on the `instafilter` branch.
- **BucketList** — A map-based location bookmarking app. Drop pins anywhere on the map, long-press annotations to view and edit location details, and browse nearby Wikipedia articles fetched live from the API. Covers `MapKit` with custom `Annotation` views, `MapReader` for tap coordinate detection, `@Observable` MVVM architecture, `URLSession` async networking with `Codable` JSON decoding, and Face ID / Touch ID authentication via `LocalAuthentication`. Lives on the `bucketlist` branch.
- **AccessibilitySandbox** — A SwiftUI sandbox for learning iOS accessibility APIs. Covers VoiceOver labels and hints (`.accessibilityLabel`, `.accessibilityHint`), hiding decorative views (`.accessibilityHidden`), grouping related views with `.accessibilityElement(children: .combine/.ignore)`, custom traits (`.accessibilityAddTraits`, `.accessibilityRemoveTraits`), reading and adjusting values with `.accessibilityValue` and `.accessibilityAdjustableAction`, and Voice Control input labels with `.accessibilityInputLabels`. Lives on the `mastering-swiftui` branch.

## The Mindset

Skills are not given. They're built — one commit at a time.

Nobody starts out knowing how to build apps. Every developer you look up to was once stuck on the same errors, confused by the same concepts, and wondering if it was worth continuing. The difference is they kept going.

This repo is the proof of that process. Not every commit is clean. Not every project is perfect. But every single one moved the needle forward — a new concept clicked, a bug finally made sense, a feature that seemed impossible got shipped.

That's how it works. You don't wait until you feel ready. You build until you are.

Keep going.
