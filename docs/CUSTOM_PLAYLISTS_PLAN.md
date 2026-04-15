# Custom Playlists (создание / редактирование / удаление)

> План реализации фичи кастомных плейлистов. Синхронизирован с `~/.claude/plans/purring-fluttering-sonnet.md` на рабочей машине.

## Context

В приложении сейчас работают только **featured‑плейлисты** (read‑only каталог + лайки). Дизайнеры передали набор экранов для **кастомных плейлистов**: пользователь может создать свой плейлист, добавлять/удалять треки, менять порядок, переименовывать и удалять плейлист. Экран `/music/myplaylists` должен показывать объединённый список — созданные пользователем плейлисты + залайканные featured‑плейлисты.

Бэкенд готов: `POST/PUT/DELETE/GET /api/custom-playlists`. Мутации — одна операция PUT с полным `{Name, Tracks: [docId, ...]}`.

Текущий `PlaylistRepository` охватывает featured + лайки; его имя не отражает роль, а `getFavoritePlaylists()` бросает `UnimplementedError`. Поэтому первым шагом — рефакторинг имени и доработка лайкового метода, затем добавление новой ветки под custom.

## Архитектурные решения (согласованы с пользователем)

1. **Один экран `PlaylistScreen`, два контроллера**. Экран читает `Playlist.type` и выбирает нужный контроллер. Хедер/аппбар/empty state ветвятся по type.
2. **Роут один**: `/music/playlist/:id?type=<featured|custom>` (дефолт `featured`). Edit — отдельный роут `/music/playlist/:id/edit` (только custom).
3. **Два репозитория**: `FeaturedPlaylistRepository` (переименованный существующий) + `CustomPlaylistRepository` (новый). Трек‑лайки (`toggleLikeTrack`, `getFavoriteTracks`) временно остаются в Featured — tech debt, рефакторим отдельной задачей.
4. **Edit как отдельный экран** (hero скрыт, только список с корзинками + ручками, Done → один PUT).
5. **Мутации батчем на явный Save**: reorder и удаления копятся локально, один PUT при сохранении. Add Tracks, Rename — свои save‑кнопки в bottomsheets.
6. **My Playlists** = custom + liked featured, в одной ленте по дате (вперемешку).

## Бэкенд‑контракт (из примеров)

### GET `/api/custom-playlists?populate=*` (список)
```json
{
  "data": [
    {
      "documentId": "n9p9ytn0z0gv8o52r3ezmy2q",
      "Name": "My First Playlist",
      "Tracks": [ { "documentId": "...", "Name": "...", "Length": 178 } ],
      "createdAt": "...", "updatedAt": "...", "publishedAt": "..."
    }
  ],
  "meta": { "pagination": {...} }
}
```

### GET `/api/custom-playlists/:id?populate=*`
Тот же объект в `data`. Обложки (`Cover`) нет — дефолт рендерим на клиенте.

### POST `/api/custom-playlists`
```json
{ "data": { "Name": "My Playlist", "Tracks": [] } }
```
При create — `Tracks: []` (создаём пустой, треки добавляются потом).
Ответ — полный созданный объект с `documentId`.

### PUT `/api/custom-playlists/:id`
```json
{ "data": { "Name": "...", "Tracks": ["docId1", "docId2", ...] } }
```
Единственная мутация. Покрывает rename / add / remove / reorder.

### DELETE `/api/custom-playlists/:id`
Без тела.

### GET `/api/user-playlists?populate[Playlist][populate][Cover][populate]=*` (лайкнутые featured)
По аналогии с `getFavoriteAlbums` ([albums_repository_impl.dart:47-75](../lib/data/repositories/albums_repository_impl.dart#L47)).

## План изменений

### 1. Rename: `PlaylistRepository` → `FeaturedPlaylistRepository`

**Файлы переименовать:**
- `lib/domain/repositories/playlist_repository.dart` → `featured_playlist_repository.dart`.
- `lib/data/repositories/playlist_repository_impl.dart` → `featured_playlist_repository_impl.dart`.
- `lib/data/repositories/playlist_repository_mock.dart` → `featured_playlist_repository_mock.dart`.

**Классы:** `PlaylistRepository/Impl/Mock` → `FeaturedPlaylistRepository/Impl/Mock`.
**Провайдер:** `playlistRepositoryProvider` → `featuredPlaylistRepositoryProvider` в `lib/core/di/repository_providers.dart`.

**Консьюмеры — обновить импорты/провайдер:**
- `lib/domain/state/featured_playlists_state.dart` (строки 5, 26, 30).
- `lib/features/favorites/presentation/my_favorites/my_favorites_controller.dart` (5, 23, 27).
- `lib/features/playlists/presentation/playlist/playlist_controller.dart` (34, 43).
- `lib/features/home/presentation/home/home_controller.dart` (44).
- `lib/features/player/presentation/player/widgets/player_control_panel.dart` (145).
- `lib/features/player/presentation/player/mini_player_widget.dart` (235, 460).
- `lib/features/favorites/presentation/my_playlists/my_playlists_controller.dart` — переписывается целиком ниже, не трогаем в рамках rename.

### 2. Доработать `FeaturedPlaylistRepository`

- `getFavoritePlaylists()` → переименовать в `getLikedFeaturedPlaylists()` и реализовать через `GET /api/user-playlists` по образцу `getFavoriteAlbums` из `lib/data/repositories/albums_repository_impl.dart:47-75`.
  - `populate[Playlist][populate][Cover][populate]=*`.
  - Для каждой записи: взять вложенный `Playlist`, проставить `likeId = documentId` родителя, `isLiked = true`, `type = PlaylistType.featured`.

### 3. Domain: `Playlist.type`

- В `lib/domain/entities/playlist.dart` добавить `enum PlaylistType { featured, custom }` (отдельный файл или inline).
- В `Playlist` добавить `@Default(PlaylistType.featured) PlaylistType type`.
- Перегенерировать freezed (`build_runner`).
- В `PlaylistDto.toDomain()` — проставить `type: PlaylistType.featured`.

### 4. Новый: `CustomPlaylistRepository`

**Файлы:**
- `lib/domain/repositories/custom_playlist_repository.dart` — интерфейс.
- `lib/data/repositories/custom_playlist_repository_impl.dart` — реализация.
- `lib/data/repositories/custom_playlist_repository_mock.dart` — mock.
- `lib/data/dto/custom_playlist_dto.dart` — DTO для GET‑ответов.

**Методы:**
- `Future<List<Playlist>> getCustomPlaylists()` — GET `/api/custom-playlists`, маппит в `Playlist` с `type: custom`, `trackCount = Tracks.length`.
- `Future<List<Track>> getCustomPlaylistTracks(String id)` — GET `/api/custom-playlists/:id` с глубоким populate (Album/Cover/Artists/File как в существующем `getPlaylistTracks`).
- `Future<Playlist> createCustomPlaylist(String name)` — POST `{data: {Name: name, Tracks: []}}`.
- `Future<Playlist> updateCustomPlaylist({required String id, required String name, required List<String> trackDocIds})` — PUT.
- `Future<void> deleteCustomPlaylist(String id)` — DELETE.

**DI:** `customPlaylistRepositoryProvider` в `lib/core/di/repository_providers.dart`.

### 5. Controllers

**5.1. `playlistControllerProvider` (existing)** — только обновить импорт провайдера репо.

**5.2. `customPlaylistControllerProvider` (новый)** — `family<..., String>`.
- Файл: `lib/features/playlists/presentation/playlist/custom_playlist_controller.dart`.
- State (sealed freezed): `loading | data(playlist, tracks) | error(message)`.
- Методы: `loadTracks`, `addTracks(List<String> ids)`, `removeTrack(String id)`, `reorder(int from, int to)`, `rename(String newName)`, `delete()`, `save()`.
- `rename` → сразу PUT. `delete` → сразу DELETE. `addTracks` из AddTracks sheet → сразу PUT.
- `reorder` и `removeTrack` — накапливаются локально, PUT только на явный `save()` из `EditPlaylistScreen`.

**5.3. `MyPlaylistsNotifier`** — переписать (`lib/features/favorites/presentation/my_playlists/my_playlists_controller.dart`).
- `Future.wait([featuredRepo.getLikedFeaturedPlaylists(), customRepo.getCustomPlaylists()])`, мерж + сортировка по `updatedAt` descending.
- Рефреш после create/delete (`ref.invalidate` или `refresh()` метод).
- Pagination пока убрать.

### 6. Routing

`lib/core/navigation/app_router.dart`:
- Изменить `playlist/:id` — читать `type` из `state.uri.queryParameters['type']`, дефолт `featured`, передавать в `PlaylistScreen`.
- Добавить `playlist/:id/edit` — только для `type=custom` (если type не custom, делать redirect на `/music/playlist/:id`).

`lib/core/navigation/routes.dart`:
- Добавить `musicPlaylistEdit = '/music/playlist/:id/edit'`.

### 7. Screens

**7.1. `PlaylistScreen`** (`lib/features/playlists/presentation/playlist/playlist_screen.dart`)
- Новый параметр `PlaylistType type`.
- Ветка `featured` — как сейчас (`playlistControllerProvider`, Share в аппбаре, Like+Play в hero).
- Ветка `custom` — `customPlaylistControllerProvider`, Edit‑иконка в аппбаре (открывает `playlist_options` bottomsheet), Add+Play в hero. Empty state когда треков нет. Берёт `Playlist` не из `featuredPlaylistsStateProvider`, а из custom‑контроллера.

**7.2. `PlaylistHero`** (`lib/features/playlists/presentation/widgets/playlist_hero.dart`)
- Параметризовать вторую круглую кнопку (Like vs Add). Два коллбэка.
- Фон: для custom — дефолтный asset (уточнить), для featured — `playlist.imageUrl`.

**7.3. `EditPlaylistScreen` (новый)**
- Файл: `lib/features/playlists/presentation/edit_playlist/edit_playlist_screen.dart`.
- Использует тот же `customPlaylistControllerProvider(id)`.
- Аппбар: back + title + checkmark (Done).
- `ReorderableListView` с трек‑тайлами без обложки (видно на скрине — только корзина, title/artist, ручка).
- Done → `controller.save()` → `context.pop()`.
- Back без сохранения откатывает локальные изменения (без discard‑диалога — его дизайн не оговорен).

**7.4. `MyPlaylistsScreen`** (`lib/features/favorites/presentation/my_playlists/my_playlists_screen.dart`)
- Вставить `actionIcon` в `MyCategoriesHeader` — SVG `+`.
- `onActionIconTap` → показать `create_playlist` bottomsheet.
- После успешного POST — `context.push('/music/playlist/$newId?type=custom')` + `ref.invalidate(myPlaylistsStateProvider)`.

### 8. BottomSheets — переезд + доработка

**Переезд** из `lib/features/shared_widgets/bottom_pop_ups/` в `lib/features/playlists/presentation/bottom_sheets/`:
- `create_playlist.dart`
- `rename_playlist.dart`
- `playlist_options.dart`
- `delete.dart`

**Остаются в shared:**
- `action_button.dart` (reusable).
- `track_options.dart` (не наш случай).

**Новый:**
- `add_tracks.dart` — поиск + список favorite tracks + "+" → Save.

**Доработка всех переехавших:**
- `create_playlist` — `TextEditingController`, `onSave(String name)`.
- `rename_playlist` — `initialName`, `onSave(String newName)`, Cancel закрывает.
- `playlist_options` — 4 callbacks (`onAddTracks`, `onEdit`, `onRename`, `onDelete`).
- `delete` — `onConfirm`, закрывать sheet на обеих кнопках.

### 9. Tile в списке

`lib/features/shared_widgets/playlist_tile.dart`:
- Добавить `PlaylistType type`.
- `onTap`: `context.push('/music/playlist/$id?type=${type.name}')`.

### 10. Документация

`docs/ARCHITECTURE_SPEC.md` — обновить упоминания `playlist_repository.dart` (строки 142, 181, 276). Опционально.

## Открытые вопросы (не блокируют старт)

1. **Источник дефолтного списка в `AddTracksBottomSheet`** — ждём уточнение от дизайнеров (вероятно `/api/user-tracks` = favorite tracks).
2. **Default cover для custom‑плейлиста** — asset уточнить; пока placeholder.
3. **Поведение "+" при повторном тапе в Add Tracks** — превращается в checkmark/минус, или дизабл. Уточнить.
4. **Обработка ошибок PUT/POST/DELETE** — повторить паттерн из `toggleLike`.

## Verification

1. **Codegen/analyze:**
   - `flutter pub run build_runner build --delete-conflicting-outputs` (после Playlist.type).
   - `flutter analyze` — 0 ошибок по изменённым файлам.

2. **Ручные сценарии:**
   - Featured: открыть из дашборда `/music` → поведение не изменилось (Like, Play, Share, треки).
   - My Playlists: лайкнуть featured → появляется; тап → featured‑экран с Unlike.
   - Create: "+" → sheet → Create → новый пустой с `Start adding songs`.
   - Add Tracks: из hero "+" или из меню → sheet → Save → треки появились.
   - Rename: меню → prefilled sheet → Save → title обновился.
   - Edit: меню → экран → drag reorder + корзина → Done → PUT → порядок сохранился.
   - Delete track: Edit → корзина → dialog → исчез.
   - Delete playlist: меню → Delete → dialog → Yes → возврат в My Playlists.
   - Back без сохранения из Edit → откат.

3. **Плеер не сломан:**
   - Play с featured — queue source `playlist`, как раньше.
   - Play с custom — queue source `playlist` (id + title + default image).
   - `mini_player_widget` / `player_control_panel` после rename — работают.

## Порядок реализации

1. Rename `PlaylistRepository` → `FeaturedPlaylistRepository` + все консьюмеры.
2. Доделать `getLikedFeaturedPlaylists()`.
3. `Playlist.type` + freezed regen + маппер.
4. `CustomPlaylistRepository` (+DTO, +mock, +DI).
5. `customPlaylistControllerProvider`.
6. Routing: query‑param `type` + edit‑роут.
7. Переписать `MyPlaylistsNotifier` + `MyPlaylistsScreen` + "+" + Create sheet.
8. `PlaylistScreen` — ветвление по type, hero add‑кнопка, меню, empty state.
9. `EditPlaylistScreen`.
10. Переезд бот‑шитов + доработка callbacks + новый `add_tracks.dart`.
11. `PlaylistTile` с type.
12. Прогон сценариев.
