# Data Layer Specification

## Purpose

This document defines the **rules and conventions** for the data layer.

The data layer is responsible for:
- communicating with external data sources (HTTP API for now)
- mapping API JSON → DTOs → domain entities
- implementing domain repository interfaces

This document does NOT attempt to mirror the full implementation code.
It defines the contract and approved patterns.

---

## Core Rules

- Features MUST NOT access `ApiClient`, DTOs, or repository implementations directly.
- Only data-layer repositories may use `ApiClient`.
- DTOs represent API response shapes and live in `lib/data/dto/*`.
- Repository implementations live in `lib/data/repositories/*` and implement domain repository interfaces.

We intentionally keep the data layer simple:
- no separate remote/local data sources (for now)
- no complex caching layer (for now)
- just DTOs + repository implementations
- shared `ApiClient` lives in `lib/core/network/`

---

## DTO Standard (Mandatory)

All DTOs in `lib/data/dto/*` MUST:
- be implemented using **Freezed**
- use **json_serializable** for JSON parsing
- NOT implement manual `fromJson` parsing
- provide mapping to domain via `toDomain()` (method or extension)

DTOs must not be used outside the data layer.

---

## Mapping Rules

- Domain models must remain API-agnostic (no JSON).
- DTOs must perform normalization required for domain safety (defaults, trimming, null handling).
- Enum/string mapping (API → domain enums) is owned by DTO mapping.

---

## Repository Implementation Rules

Each `*RepositoryImpl` in `lib/data/repositories/*` MUST:
- implement exactly one domain repository interface
- use `ApiClient` for HTTP calls
- parse JSON into DTOs using generated `fromJson`
- return only domain entities from public methods
- never expose DTOs to callers

---

## Example Pattern (Reference Only)

Use the following pattern as the approved approach (illustrative, not exhaustive):

- DTO: Freezed + generated `fromJson`
- Mapping: `toDomain()`
- Repo method: `api.get(...)` → `Dto.fromJson` → `toDomain()`

---

## Non-Goals

The data layer does NOT:
- define UI state
- contain business logic
- expose DTOs to features
- implement offline storage/caching (for now)

---

## Future Extension

If offline/caching is introduced later:
- add `data/local/` (or similar)
- keep DTOs as the persisted format (if appropriate)
- keep domain layer unchanged
