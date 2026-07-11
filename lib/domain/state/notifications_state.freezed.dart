// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notifications_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$NotificationsState {
  bool get isLoading => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;
  List<Notification> get items => throw _privateConstructorUsedError;
  int get unseenCount => throw _privateConstructorUsedError;
  Notification? get selectedNotification => throw _privateConstructorUsedError;

  /// Create a copy of NotificationsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NotificationsStateCopyWith<NotificationsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NotificationsStateCopyWith<$Res> {
  factory $NotificationsStateCopyWith(
    NotificationsState value,
    $Res Function(NotificationsState) then,
  ) = _$NotificationsStateCopyWithImpl<$Res, NotificationsState>;
  @useResult
  $Res call({
    bool isLoading,
    String? error,
    List<Notification> items,
    int unseenCount,
    Notification? selectedNotification,
  });

  $NotificationCopyWith<$Res>? get selectedNotification;
}

/// @nodoc
class _$NotificationsStateCopyWithImpl<$Res, $Val extends NotificationsState>
    implements $NotificationsStateCopyWith<$Res> {
  _$NotificationsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NotificationsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? error = freezed,
    Object? items = null,
    Object? unseenCount = null,
    Object? selectedNotification = freezed,
  }) {
    return _then(
      _value.copyWith(
            isLoading: null == isLoading
                ? _value.isLoading
                : isLoading // ignore: cast_nullable_to_non_nullable
                      as bool,
            error: freezed == error
                ? _value.error
                : error // ignore: cast_nullable_to_non_nullable
                      as String?,
            items: null == items
                ? _value.items
                : items // ignore: cast_nullable_to_non_nullable
                      as List<Notification>,
            unseenCount: null == unseenCount
                ? _value.unseenCount
                : unseenCount // ignore: cast_nullable_to_non_nullable
                      as int,
            selectedNotification: freezed == selectedNotification
                ? _value.selectedNotification
                : selectedNotification // ignore: cast_nullable_to_non_nullable
                      as Notification?,
          )
          as $Val,
    );
  }

  /// Create a copy of NotificationsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $NotificationCopyWith<$Res>? get selectedNotification {
    if (_value.selectedNotification == null) {
      return null;
    }

    return $NotificationCopyWith<$Res>(_value.selectedNotification!, (value) {
      return _then(_value.copyWith(selectedNotification: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$NotificationsStateImplCopyWith<$Res>
    implements $NotificationsStateCopyWith<$Res> {
  factory _$$NotificationsStateImplCopyWith(
    _$NotificationsStateImpl value,
    $Res Function(_$NotificationsStateImpl) then,
  ) = __$$NotificationsStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    bool isLoading,
    String? error,
    List<Notification> items,
    int unseenCount,
    Notification? selectedNotification,
  });

  @override
  $NotificationCopyWith<$Res>? get selectedNotification;
}

/// @nodoc
class __$$NotificationsStateImplCopyWithImpl<$Res>
    extends _$NotificationsStateCopyWithImpl<$Res, _$NotificationsStateImpl>
    implements _$$NotificationsStateImplCopyWith<$Res> {
  __$$NotificationsStateImplCopyWithImpl(
    _$NotificationsStateImpl _value,
    $Res Function(_$NotificationsStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of NotificationsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? error = freezed,
    Object? items = null,
    Object? unseenCount = null,
    Object? selectedNotification = freezed,
  }) {
    return _then(
      _$NotificationsStateImpl(
        isLoading: null == isLoading
            ? _value.isLoading
            : isLoading // ignore: cast_nullable_to_non_nullable
                  as bool,
        error: freezed == error
            ? _value.error
            : error // ignore: cast_nullable_to_non_nullable
                  as String?,
        items: null == items
            ? _value._items
            : items // ignore: cast_nullable_to_non_nullable
                  as List<Notification>,
        unseenCount: null == unseenCount
            ? _value.unseenCount
            : unseenCount // ignore: cast_nullable_to_non_nullable
                  as int,
        selectedNotification: freezed == selectedNotification
            ? _value.selectedNotification
            : selectedNotification // ignore: cast_nullable_to_non_nullable
                  as Notification?,
      ),
    );
  }
}

/// @nodoc

class _$NotificationsStateImpl implements _NotificationsState {
  const _$NotificationsStateImpl({
    this.isLoading = false,
    this.error,
    final List<Notification> items = const [],
    this.unseenCount = 0,
    this.selectedNotification,
  }) : _items = items;

  @override
  @JsonKey()
  final bool isLoading;
  @override
  final String? error;
  final List<Notification> _items;
  @override
  @JsonKey()
  List<Notification> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  @JsonKey()
  final int unseenCount;
  @override
  final Notification? selectedNotification;

  @override
  String toString() {
    return 'NotificationsState(isLoading: $isLoading, error: $error, items: $items, unseenCount: $unseenCount, selectedNotification: $selectedNotification)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotificationsStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.error, error) || other.error == error) &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.unseenCount, unseenCount) ||
                other.unseenCount == unseenCount) &&
            (identical(other.selectedNotification, selectedNotification) ||
                other.selectedNotification == selectedNotification));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    isLoading,
    error,
    const DeepCollectionEquality().hash(_items),
    unseenCount,
    selectedNotification,
  );

  /// Create a copy of NotificationsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NotificationsStateImplCopyWith<_$NotificationsStateImpl> get copyWith =>
      __$$NotificationsStateImplCopyWithImpl<_$NotificationsStateImpl>(
        this,
        _$identity,
      );
}

abstract class _NotificationsState implements NotificationsState {
  const factory _NotificationsState({
    final bool isLoading,
    final String? error,
    final List<Notification> items,
    final int unseenCount,
    final Notification? selectedNotification,
  }) = _$NotificationsStateImpl;

  @override
  bool get isLoading;
  @override
  String? get error;
  @override
  List<Notification> get items;
  @override
  int get unseenCount;
  @override
  Notification? get selectedNotification;

  /// Create a copy of NotificationsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NotificationsStateImplCopyWith<_$NotificationsStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
