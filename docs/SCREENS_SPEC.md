# SCREENS.md
Canonical, agent-friendly screen specification for the Music/Podcast/Radio app.

**Source of truth:** derived from the latest approved product-spec PDF.
**Presentation docs (PDFs):** remain the visual reference; this file is for tooling/agents.

## Scope and Rules

This document defines:
- existing application screens
- their purpose and user-facing behavior

This document does NOT define:
- UI layout or visual design
- Flutter/Riverpod implementation
- navigation code or routing
- data fetching or API details

Use ARCHITECTURE_SPEC.md for structural and technical rules.

---

## Home
The Home screen is the main content hub of the application.

Purpose:
- entry point to music, podcasts, and radio
- promotion of editorial and featured content
- access to the current playback state

---

## Story
Editorial story display screen.

Purpose:
- present contextual editorial content
- guide the user toward related audio or internal sections

---

## News Listing
Screen displaying the full list of news articles.

Notes:
- list supports pagination
- content matches the News block on Home

---

## News
Detailed news article screen.

Purpose:
- display full text content of a NewsArticle

---

## Music
Music tab providing access to on-demand audio content.

Purpose:
- access to the user’s music and podcast library
- navigation to liked and grouped content (favorites, albums, artists, programs)
- discovery of editorial and featured content
- access to new podcast and program episodes
- access to the current playback state

---

## Artist
Artist profile screen showing albums.

Purpose:
- present artist profile and visual identity
- provide access to the artist’s albums
- allow navigation to album detail screens
- support artist like and follow actions

---

## Album
Album detail screen with ordered track list.

Purpose:
- present album metadata and artwork
- provide access to the ordered list of tracks
- allow playback of individual tracks or the full album
- support album like actions

---

## Program
Program / podcast screen with episode list.

Purpose:
- present program identity and description
- provide access to the list of available episodes
- allow playback of individual episodes
- support program like and follow actions

---

## My Favorites
System-generated user playlist screen displaying all tracks liked by the user.

Purpose:
- provide quick access to liked tracks
- allow playback of all favorite tracks as a playlist

Notes:
- Play loads all tracks into the playback queue starting from the first track
- tracks cannot be removed manually
- removing a track is only possible via unlike action

---

## My Albums
Screen displaying albums liked by the user.

Purpose:
- provide access to liked Album entities

Notes:
- tapping an album opens the Album screen

---

## My Artists
Screen displaying artists liked by the user.

Purpose:
- provide access to liked Artist entities

Notes:
- tapping an artist opens the Artist screen

---

## My Playlists
Screen displaying playlists created by the user.

Purpose:
- manage playlists created by the user
- create new playlists

Notes:
- create action opens the Create Playlist modal

---

## Playlist
User playlist detail screen with playback and management actions.

Purpose:
- play playlist tracks
- manage playlist content

Notes:
- track order is fixed
- available actions depend on playlist type

---

## New Episodes
Screen displaying a feed of newly released episodes from various programs.

Purpose:
- provide quick access to the latest program episodes
- support immediate playback of newly released content

Notes:
- episodes are represented as Track entities
- playback follows standard on-demand queue behavior

---

## My Programs
Screen displaying program-related content liked by the user, organized into Episodes and Programs tabs.

Purpose:
- provide access to liked program episodes and programs
- allow switching between Episodes and Programs tabs

Notes:
- Episodes tab displays liked episode Tracks
- Programs tab displays liked Program entities
- Tab switching does not affect playback state

---

## Radio
Radio content hub providing access to live radio playback, featured programs, and featured episodes.

Purpose:
- launch live radio playback
- promote featured programs
- provide quick access to featured episodes

Notes:
- Listen Live Now opens the Radio Player
- featured programs navigate to Program screens
- featured episodes are represented as Track entities

---

## Radio Schedule
Screen displaying radio broadcast schedule organized by date.

Purpose:
- provide access to the daily radio program schedule
- allow subscription/reminders per scheduled slot
- provide a secondary entry point to live radio playback

Notes:
- schedule entries are represented as RadioScheduleSlot entities
- Listen Live Now opens the Radio Player
- reminder state is stored per slot

---

## Music Player
Full-screen on-demand audio playback screen.

Purpose:
- control playback of track queues
- provide seek and track navigation controls
- display track and context metadata

Notes:
- operates on Track entities
- supports seek, previous, and next actions
- opening source determined by active mini-player view

---

## Radio Player
Full-screen live radio playback screen with broadcast context and schedule.

Purpose:
- control live radio playback
- display current broadcast information
- present upcoming scheduled radio slots

Notes:
- operates on Radio and RadioScheduleSlot entities
- does not support seek or queue navigation
- includes reminder actions per scheduled slot

---

## Mini Players
Persistent compact playback UI displayed across application screens.

Notes:
- always visible across main application screens
- includes a view switch between music and radio mini-player representations
- switching views does not change current playback
- pressing Play initiates playback for the displayed mini-player type, stopping the previous source
- tapping the mini-player outside playback controls opens the corresponding full-screen player
