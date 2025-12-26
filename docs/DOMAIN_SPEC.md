# Domain Specification

## Purpose

This document defines the **conceptual domain model** of the Audio Application.

It describes:
- what domain entities exist
- what they represent
- key invariants and relationships

This document **does NOT** define:
- entity fields or constructors
- JSON / API shapes
- persistence or infrastructure
- UI or presentation concerns

All structural and technical rules are defined in `ARCHITECTURE_SPEC.md`.

---

## Domain Principles

- Domain entities are **pure business concepts**
- They are **immutable value objects**
- They are **independent of API, JSON, HTTP, and storage**
- Domain logic must not depend on the data or presentation layers

---

## Core Domain Entities

### Track
A unified playable audio unit.

Used for:
- music tracks
- podcast episodes
- program episodes

Invariants:
- always represents a single playable audio item
- has a defined duration
- may belong to an album, artist, or program
- is the smallest playback unit in the system

---

### Artist
A musical artist or band.

Invariants:
- represents a creator of albums and tracks
- does not own playback state
- may have multiple albums

---

### Album
A canonical music release.

Invariants:
- belongs to a single artist
- groups multiple tracks
- has a fixed ordering of tracks

---

### Program
A container for episodic audio content.

Used for:
- podcasts
- radio shows

Invariants:
- groups episode tracks
- episodes themselves are represented as Tracks
- does not directly contain audio data

---

### Playlist
A collection of tracks.

Invariants:
- may be user-generated or system-generated
- contains an ordered list of tracks
- does not own track data

---

### Radio
A live audio stream.

Invariants:
- represents a continuous live stream
- playback is time-based, not track-based
- schedule information is modeled separately

---

### RadioScheduleSlot
A scheduled radio broadcast slot.

Invariants:
- represents a time-bounded radio program
- always belongs to a Radio
- may support reminder/subscription behavior

---

### Story
Editorial content used for discovery and promotion.

Invariants:
- contains editorial text and imagery
- may reference another domain entity as a call-to-action
- does not own the target entity

---

### NewsArticle
Text-based informational content.

Invariants:
- represents a published news item
- is read-only from the user perspective
- does not affect playback state

---

## Domain Relationships (High-Level)

- Tracks may belong to Albums, Artists, Programs, or Playlists
- Albums belong to Artists
- Programs group episodic Tracks
- Playlists aggregate Tracks
- RadioScheduleSlots belong to Radio
- Stories and NewsArticles may reference other entities, but do not own them

---

## Non-Goals

The domain layer does **not**:
- handle API communication
- parse JSON or DTOs
- manage playback state
- manage UI state
- store persistence or cache data

---

## Relation to Architecture Specification

- Structural rules and constraints are defined in `ARCHITECTURE_SPEC.md`
- Entity implementation details (Freezed, immutability) are defined there
- Concrete fields and constructors are defined in code, not in this document

---

End of DOMAIN_SPEC.md
