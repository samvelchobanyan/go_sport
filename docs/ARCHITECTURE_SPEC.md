# Audio App — Architecture Specification

Version: 1.0  
Status: Canonical (v1_raw)  
Audience: Developers, AI agents (Copilot, Codex, Claude)

---

## 0. Purpose of This Document

This document is the single source of truth for the architecture of the Audio Application.

It defines:
- global project structure
- architectural layers and their responsibilities
- rules and constraints for implementation
- naming and structural conventions

All developers and AI agents must follow this document.
If something is not described here, it must not be invented without explicit approval.

This is an architectural contract, not a guideline.

---

## 1. High-Level Architecture Overview (from arch.txt)

lib/
├── core/                         # Глобальное ядро
│   ├── di/                       # Riverpod providers (Dependency Injection)
│   ├── navigation/               # go_router global route configuration
│   ├── network/                  # Dio, ApiClient, Interceptors
│   ├── theme/                    # Глобальная настройка ThemeData (Material 3)
│   └── utils/                    # Форматтеры, логгеры
│
├── design_system/                # Твоя Дизайн-система
│   ├── foundations/              # Токены (Атомы)
│   │   ├── ds_colors.dart        # Цвета (primary, background, surface...)
│   │   ├── ds_typography.dart    # Стили текста
│   │   ├── ds_spacing.dart       # Отступы и сетка
│   │   └── ds_radius.dart        # Скругления
│   ├── components/               # UI Kit (Молекулы)
│   │   ├── ds_button.dart
│   │   ├── ds_card.dart
│   │   └── ds_track_tile.dart    # Общий виджет трека
│   └── theme/                    # Сборка темы на основе токенов
│       └── ds_theme_data.dart
│
├── domain/                       # БИЗНЕС-ЛОГИКА (Чистый Dart)
│   ├── entities/                 # Модели данных (Freezed)
│   │   ├── track.dart
│   │   ├── artist.dart
│   │   ├── story.dart
│   │   └── news_article.dart
│   └── repositories/             # Интерфейсы (Контракты)
│       ├── track_repository.dart
│       └── news_repository.dart
│
├── data/                         # РЕАЛИЗАЦИЯ (Инфраструктура)
│   ├── dto/                      # JSON-модели (Data Transfer Objects)
│   │   ├── track_dto.dart
│   │   └── story_dto.dart
│   └── repositories/             # Реальные/Mock имплементации
│       ├── track_repository_impl.dart
│       └── story_repository_impl.dart
│
├── features/                     # ПРЕЗЕНТАЦИЯ (UI + Состояние)
│   ├── home/
│   │   └── presentation/
│   │       └── home/
│   │           ├── home_screen.dart
│   │           ├── home_controller.dart
│   │           └── widgets/      # Локальные виджеты экрана (optional)
│   ├── radio/
│   │   └── presentation/
│   │       └── radio/
│   │           ├── radio_screen.dart
│   │           └── radio_controller.dart
│   └── player/                   # Глобальный плеер (Оркестратор)
│       └── presentation/
│           └── player/
│               ├── player_controller.dart
│               ├── mini_player_widget.dart
│               └── full_player_screen.dart
│
└── main.dart                     # Точка входа и инициализация Riverpod

Design System is isolated: visual changes are made only inside design_system.
Controller Pattern: each feature screen has exactly two files — Screen + Controller.

## 2. Layer responsibility and access rules

- Domain layer contains pure business models and repository interfaces.
- Data layer implements domain repositories and owns all infrastructure details.
- Features layer depends only on domain abstractions and shared UI/system utilities.
- Direct access to ApiClient, DTOs, or repository implementations from features is forbidden.

ApiClient is a shared infrastructure component located in `core/network/`.
- Used exclusively by the data layer
- Provides the only allowed HTTP access point
- Must not be accessed from domain or features



---

## 3. Domain Layer Specification


This document describes the **domain layer** of the audio app: entities, repositories, and folder structure.

The domain layer is **UI-agnostic** and **API-agnostic**. It defines *what the app works with*, not *how data is fetched*.

---

### 3.1. Folder Structure

```text
lib/
  domain/
    entities/
      track.dart
      artist.dart
      album.dart
      program.dart
      playlist.dart
      radio.dart
      radio_schedule_slot.dart
      story.dart
      news_article.dart
      track_type.dart
    repositories/
      track_repository.dart
      artist_repository.dart
      album_repository.dart
      program_repository.dart
      playlist_repository.dart
      radio_repository.dart
      story_repository.dart
      news_repository.dart
```

### 3.2. `domain/entities/*`

Contains **pure domain models** (entities), without any knowledge of JSON, HTTP, or persistence.

- `track.dart` – unified playable audio unit.
- `artist.dart` – music artist / band.
- `album.dart` – canonical music release.
- `program.dart` – podcast / show entity.
- `playlist.dart` – user or system playlist.
- `radio.dart` – live radio stream entity.
- `radio_schedule_slot.dart` – scheduled radio broadcast slot.
- `story.dart` – editorial story entity.
- `news_article.dart` – text-based news content.
- `track_type.dart` – enum describing track content type.

### 3.3. `domain/repositories/*`

Contains **interfaces (abstract classes)** that describe how the domain expects to access data.
Implementations will live in the `data/` layer.

- `track_repository.dart`
- `artist_repository.dart`
- `album_repository.dart`
- `program_repository.dart`
- `playlist_repository.dart`
- `radio_repository.dart`
- `story_repository.dart`
- `news_repository.dart`

---

### 3.4. Entities

All entities are **immutable value objects implemented with Freezed** (fields are `final` and set in the constructor).
Detailed entity structure is defined in DOMAIN_SPEC.md.

### Freezed (Domain Entities) — Mandatory

All domain entities in `lib/domain/entities/*` MUST be implemented using Freezed.
Domain entities must NOT contain JSON parsing (`fromJson/toJson`) or DTO logic.

---

### 3.5. Repositories (Domain Interfaces)

All repositories are defined as `abstract class`es in `domain/repositories/*`.
They do not know anything about HTTP, Dio, JSON, or persistence.
Detailed repository interfaces (methods and signatures) are defined in DOMAIN_SPEC.md.



---

### 3.6 Summary

- Domain layer contains pure entities (no JSON/HTTP/persistence).
- Domain layer defines repository interfaces; implementations live in the data layer.

---


## 4. Data Layer Specification

This document describes the **data layer** of the audio application.
The data layer is responsible for:

- talking to external data sources (HTTP API for now)
- mapping raw JSON → DTOs → domain entities
- implementing domain repository interfaces

We intentionally keep the data layer **simple**:
- no separate remote/local data sources (for now)
- no over-segmentation
- just DTOs + repository implementations
- a shared `ApiClient` lives in `core/`

---

### 4.1. Folder Structure

```text
lib/
  core/
    network/
      api_client.dart
      api_exceptions.dart   // optional
  domain/
    entities/
    repositories/
  data/
    dto/
      track_dto.dart
      artist_dto.dart
      album_dto.dart
      program_dto.dart
      playlist_dto.dart
      radio_dto.dart
      radio_schedule_slot_dto.dart
      story_dto.dart
      news_article_dto.dart
    repositories/
      track_repository_impl.dart
      artist_repository_impl.dart
      album_repository_impl.dart
      program_repository_impl.dart
      playlist_repository_impl.dart
      radio_repository_impl.dart
      story_repository_impl.dart
      news_repository_impl.dart
```

- `core/network/api_client.dart` – low-level HTTP client (Dio/HttpClient wrapper).
- `domain/` – pure domain entities and repository interfaces (see DOMAIN_SPEC.md).
- `data/dto/` – models that reflect API responses and handle JSON parsing + basic validation.
- `data/repositories/` – concrete implementations of domain repositories using DTOs + `ApiClient`.

---


### 4.2. DTOs (data/dto/*)

DTOs represent **how API responses look**, not how the domain models look.
Each DTO:
- has a `fromJson` factory
- may perform basic validation / normalization
- has a `toDomain()` method to convert into a domain entity

### Freezed DTOs + JSON — Mandatory

All DTOs in `lib/data/dto/*` MUST be implemented using Freezed + json_serializable.

Rules:
- DTO fields represent the API response shape.
- Each DTO provides generated `fromJson`.
- Each DTO MUST provide mapping to domain (`toDomain()`), either as a method or extension.
- DTOs must not be used outside the data layer.


---

### 4.3. Repository Implementations (data/repositories/*)

Each `*RepositoryImpl`:
- implements a domain repository interface
- uses `ApiClient` to talk to the backend
- uses DTOs to parse and map JSON to domain entities



---

### 4.4. Summary

- The **data layer** is responsible for:
  - using `ApiClient` (HTTP)
  - mapping JSON → DTO → domain entities
  - implementing domain repositories
- We keep it simple:
  - no separate local/remote data sources for now
  - no complex caching
- If in future we add offline/cache support, we can:
  - introduce local storage (e.g. `local/`)
  - keep DTOs as the main persisted format
  - keep domain layer unchanged.


---

## 4.5 Error Handling (Contract)

Goals:
- Features and UI MUST NOT depend on transport-level exceptions (Dio/HTTP).
- Errors MUST be represented in a stable, app-level form.

Rules:
- The data layer MUST convert transport-level failures (HTTP status, timeouts, network issues, invalid JSON) into a stable app-level error representation.
- Features/controllers MUST NOT catch or depend on Dio/HTTP exceptions directly.
- Repositories MUST expose errors only in app-level form (no DTOs, no Dio exceptions).
- Controllers MUST expose errors to the UI via UI-safe state (e.g., error state or `errorMessage`).
- Screens SHOULD support the relevant states: loading, empty, error, success.

Non-goals:
- This document does not define a specific error type yet (e.g. `Failure`), only the contract.

---

## 4.6 Navigation (Standard)

- The project uses `go_router` as the navigation solution.
- Global route configuration lives in `lib/core/navigation/`.
- Features define screens only; they MUST NOT own global route configuration.
- Navigation targets MUST be screen-level widgets (`*Screen`).
- Route naming SHOULD be stable and human-readable (e.g., `/home`, `/album/:id`, `/program/:id`).

---

## 4.7 Dependency Injection (Standard)

- Riverpod is the primary DI mechanism.
- Infrastructure dependencies (ApiClient, repository implementations, other core services) MUST be exposed via Riverpod providers in `lib/core/di/`.
- Features/controllers MUST NOT construct `ApiClient` or repository implementations directly.
- Features/controllers MAY read only:
  - domain repository providers (interfaces)
  - feature-safe services (e.g., playback controller, analytics) if explicitly provided via `core/di/`
- Domain layer MUST NOT depend on DI.

---

## 5. Features / Presentation Layer Specification

This document fixes only the **folder/file structure** and **mandatory files** for the `features/` layer.

We use a **feature-first** structure for presentation code:
- `domain/` and `data/` are global (shared across features)
- `features/` contains **presentation only**

State management choice (for this project): **Riverpod (flutter_riverpod v2)**
### UI State — Freezed (Standard)
Screen state models in the features layer SHOULD be implemented using Freezed.

Naming rules (fixed):
- UI entry widgets are **Screen**: `AlbumScreen`, `RadioScreen`, etc.
- Screen file names use `*_screen.dart`
- Each screen has its own controller file: `*_controller.dart`
- **No `*_providers.dart` by default**

---

### 5.1. What Lives in `features/` (high-level)

**Included:**
- Screens (Flutter UI)
- Feature-local widgets (only when needed)
- Screen state + logic + provider (kept inside controller file)

**Excluded:**
- HTTP / ApiClient (belongs to `core/`)
- DTOs (belong to `data/dto/`)
- repository implementations (belong to `data/repositories/`)
- domain entities and repository interfaces (belong to `domain/`)

---

### 5.2. Mandatory Screen Files (approved)

For every screen we create exactly these mandatory files:

```text
<screen>_screen.dart
<screen>_controller.dart   // includes: State + Notifier + Provider
```

Optional:
- `widgets/` folder only if the screen has multiple local widgets.

---

### 5.3. One Screen Folder Template (approved)

```text
features/<feature>/presentation/<screen>/
  <screen>_screen.dart
  <screen>_controller.dart
  widgets/                   // optional
```

---

### 5.4. Approved `features/` Structure (V1)

```text
lib/
  features/
    home/
      presentation/
        home/
          home_screen.dart
          home_controller.dart

    search/
      presentation/
        search/
          search_screen.dart
          search_controller.dart

    music/
      presentation/
        artist/
          artist_screen.dart
          artist_controller.dart
        album/
          album_screen.dart
          album_controller.dart

    programs/
      presentation/
        program/
          program_screen.dart
          program_controller.dart
        new_episodes/
          new_episodes_screen.dart
          new_episodes_controller.dart
        my_programs/
          my_programs_screen.dart
          my_programs_controller.dart

    playlists/
      presentation/
        my_playlists/
          my_playlists_screen.dart
          my_playlists_controller.dart
        playlist/
          playlist_screen.dart
          playlist_controller.dart

    favorites/
      presentation/
        favorites/
          favorites_screen.dart
          favorites_controller.dart

    radio/
      presentation/
        radio/
          radio_screen.dart
          radio_controller.dart
        schedule/
          radio_schedule_screen.dart
          radio_schedule_controller.dart

    news/
      presentation/
        list/
          news_list_screen.dart
          news_list_controller.dart
        article/
          news_article_screen.dart
          news_article_controller.dart

    story/
      presentation/
        story/
          story_screen.dart
          story_controller.dart

    player/
      presentation/
        player/
          player_controller.dart
          mini_player_widget.dart
          full_player_screen.dart
```

---

## 6. Player Rule (fixed, structural)

- Player feature lives in `features/player/`
- List/detail screens do not store playback flags; they only invoke player actions.


---

## 7. Rules for AI Agents

- This document is canonical
- Do not invent new layers or folders
- Do not bypass domain repositories
- Do not move playback logic into screens
- Follow naming and structural conventions strictly
- If something is unclear — ask, do not guess

---

End of ARCHITECTURE_SPEC.md
