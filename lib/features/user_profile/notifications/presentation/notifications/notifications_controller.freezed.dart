// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notifications_controller.dart';

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
  bool get isSuccess => throw _privateConstructorUsedError;
  List<Notification> get items => throw _privateConstructorUsedError;
  Notification? get selectedNotification => throw _privateConstructorUsedError;
  List<Notification> get unseenItems => throw _privateConstructorUsedError;

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
    bool isSuccess,
    List<Notification> items,
    Notification? selectedNotification,
    List<Notification> unseenItems,
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
    Object? isSuccess = null,
    Object? items = null,
    Object? selectedNotification = freezed,
    Object? unseenItems = null,
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
            isSuccess: null == isSuccess
                ? _value.isSuccess
                : isSuccess // ignore: cast_nullable_to_non_nullable
                      as bool,
            items: null == items
                ? _value.items
                : items // ignore: cast_nullable_to_non_nullable
                      as List<Notification>,
            selectedNotification: freezed == selectedNotification
                ? _value.selectedNotification
                : selectedNotification // ignore: cast_nullable_to_non_nullable
                      as Notification?,
            unseenItems: null == unseenItems
                ? _value.unseenItems
                : unseenItems // ignore: cast_nullable_to_non_nullable
                      as List<Notification>,
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
    bool isSuccess,
    List<Notification> items,
    Notification? selectedNotification,
    List<Notification> unseenItems,
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
    Object? isSuccess = null,
    Object? items = null,
    Object? selectedNotification = freezed,
    Object? unseenItems = null,
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
        isSuccess: null == isSuccess
            ? _value.isSuccess
            : isSuccess // ignore: cast_nullable_to_non_nullable
                  as bool,
        items: null == items
            ? _value._items
            : items // ignore: cast_nullable_to_non_nullable
                  as List<Notification>,
        selectedNotification: freezed == selectedNotification
            ? _value.selectedNotification
            : selectedNotification // ignore: cast_nullable_to_non_nullable
                  as Notification?,
        unseenItems: null == unseenItems
            ? _value._unseenItems
            : unseenItems // ignore: cast_nullable_to_non_nullable
                  as List<Notification>,
      ),
    );
  }
}

/// @nodoc

class _$NotificationsStateImpl implements _NotificationsState {
  const _$NotificationsStateImpl({
    this.isLoading = false,
    this.error,
    this.isSuccess = false,
    final List<Notification> items = const [],
    this.selectedNotification,
    final List<Notification> unseenItems = const [],
  }) : _items = items,
       _unseenItems = unseenItems;

  @override
  @JsonKey()
  final bool isLoading;
  @override
  final String? error;
  @override
  @JsonKey()
  final bool isSuccess;
  final List<Notification> _items;
  @override
  @JsonKey()
  List<Notification> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  final Notification? selectedNotification;
  final List<Notification> _unseenItems;
  @override
  @JsonKey()
  List<Notification> get unseenItems {
    if (_unseenItems is EqualUnmodifiableListView) return _unseenItems;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_unseenItems);
  }

  @override
  String toString() {
    return 'NotificationsState(isLoading: $isLoading, error: $error, isSuccess: $isSuccess, items: $items, selectedNotification: $selectedNotification, unseenItems: $unseenItems)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotificationsStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.isSuccess, isSuccess) ||
                other.isSuccess == isSuccess) &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.selectedNotification, selectedNotification) ||
                other.selectedNotification == selectedNotification) &&
            const DeepCollectionEquality().equals(
              other._unseenItems,
              _unseenItems,
            ));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    isLoading,
    error,
    isSuccess,
    const DeepCollectionEquality().hash(_items),
    selectedNotification,
    const DeepCollectionEquality().hash(_unseenItems),
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
    final bool isSuccess,
    final List<Notification> items,
    final Notification? selectedNotification,
    final List<Notification> unseenItems,
  }) = _$NotificationsStateImpl;

  @override
  bool get isLoading;
  @override
  String? get error;
  @override
  bool get isSuccess;
  @override
  List<Notification> get items;
  @override
  Notification? get selectedNotification;
  @override
  List<Notification> get unseenItems;

  /// Create a copy of NotificationsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NotificationsStateImplCopyWith<_$NotificationsStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
