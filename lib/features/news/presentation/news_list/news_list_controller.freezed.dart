// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'news_list_controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$NewsListState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(
      List<NewsArticle> articles,
      bool hasMore,
      bool isLoadingMore,
    )
    data,
    required TResult Function(String message) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(
      List<NewsArticle> articles,
      bool hasMore,
      bool isLoadingMore,
    )?
    data,
    TResult? Function(String message)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(
      List<NewsArticle> articles,
      bool hasMore,
      bool isLoadingMore,
    )?
    data,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_NewsListLoading value) loading,
    required TResult Function(_NewsListData value) data,
    required TResult Function(_NewsListError value) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_NewsListLoading value)? loading,
    TResult? Function(_NewsListData value)? data,
    TResult? Function(_NewsListError value)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_NewsListLoading value)? loading,
    TResult Function(_NewsListData value)? data,
    TResult Function(_NewsListError value)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NewsListStateCopyWith<$Res> {
  factory $NewsListStateCopyWith(
    NewsListState value,
    $Res Function(NewsListState) then,
  ) = _$NewsListStateCopyWithImpl<$Res, NewsListState>;
}

/// @nodoc
class _$NewsListStateCopyWithImpl<$Res, $Val extends NewsListState>
    implements $NewsListStateCopyWith<$Res> {
  _$NewsListStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NewsListState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$NewsListLoadingImplCopyWith<$Res> {
  factory _$$NewsListLoadingImplCopyWith(
    _$NewsListLoadingImpl value,
    $Res Function(_$NewsListLoadingImpl) then,
  ) = __$$NewsListLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$NewsListLoadingImplCopyWithImpl<$Res>
    extends _$NewsListStateCopyWithImpl<$Res, _$NewsListLoadingImpl>
    implements _$$NewsListLoadingImplCopyWith<$Res> {
  __$$NewsListLoadingImplCopyWithImpl(
    _$NewsListLoadingImpl _value,
    $Res Function(_$NewsListLoadingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of NewsListState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$NewsListLoadingImpl implements _NewsListLoading {
  const _$NewsListLoadingImpl();

  @override
  String toString() {
    return 'NewsListState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$NewsListLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(
      List<NewsArticle> articles,
      bool hasMore,
      bool isLoadingMore,
    )
    data,
    required TResult Function(String message) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(
      List<NewsArticle> articles,
      bool hasMore,
      bool isLoadingMore,
    )?
    data,
    TResult? Function(String message)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(
      List<NewsArticle> articles,
      bool hasMore,
      bool isLoadingMore,
    )?
    data,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_NewsListLoading value) loading,
    required TResult Function(_NewsListData value) data,
    required TResult Function(_NewsListError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_NewsListLoading value)? loading,
    TResult? Function(_NewsListData value)? data,
    TResult? Function(_NewsListError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_NewsListLoading value)? loading,
    TResult Function(_NewsListData value)? data,
    TResult Function(_NewsListError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _NewsListLoading implements NewsListState {
  const factory _NewsListLoading() = _$NewsListLoadingImpl;
}

/// @nodoc
abstract class _$$NewsListDataImplCopyWith<$Res> {
  factory _$$NewsListDataImplCopyWith(
    _$NewsListDataImpl value,
    $Res Function(_$NewsListDataImpl) then,
  ) = __$$NewsListDataImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<NewsArticle> articles, bool hasMore, bool isLoadingMore});
}

/// @nodoc
class __$$NewsListDataImplCopyWithImpl<$Res>
    extends _$NewsListStateCopyWithImpl<$Res, _$NewsListDataImpl>
    implements _$$NewsListDataImplCopyWith<$Res> {
  __$$NewsListDataImplCopyWithImpl(
    _$NewsListDataImpl _value,
    $Res Function(_$NewsListDataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of NewsListState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? articles = null,
    Object? hasMore = null,
    Object? isLoadingMore = null,
  }) {
    return _then(
      _$NewsListDataImpl(
        articles: null == articles
            ? _value._articles
            : articles // ignore: cast_nullable_to_non_nullable
                  as List<NewsArticle>,
        hasMore: null == hasMore
            ? _value.hasMore
            : hasMore // ignore: cast_nullable_to_non_nullable
                  as bool,
        isLoadingMore: null == isLoadingMore
            ? _value.isLoadingMore
            : isLoadingMore // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc

class _$NewsListDataImpl implements _NewsListData {
  const _$NewsListDataImpl({
    required final List<NewsArticle> articles,
    required this.hasMore,
    required this.isLoadingMore,
  }) : _articles = articles;

  final List<NewsArticle> _articles;
  @override
  List<NewsArticle> get articles {
    if (_articles is EqualUnmodifiableListView) return _articles;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_articles);
  }

  @override
  final bool hasMore;
  @override
  final bool isLoadingMore;

  @override
  String toString() {
    return 'NewsListState.data(articles: $articles, hasMore: $hasMore, isLoadingMore: $isLoadingMore)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NewsListDataImpl &&
            const DeepCollectionEquality().equals(other._articles, _articles) &&
            (identical(other.hasMore, hasMore) || other.hasMore == hasMore) &&
            (identical(other.isLoadingMore, isLoadingMore) ||
                other.isLoadingMore == isLoadingMore));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_articles),
    hasMore,
    isLoadingMore,
  );

  /// Create a copy of NewsListState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NewsListDataImplCopyWith<_$NewsListDataImpl> get copyWith =>
      __$$NewsListDataImplCopyWithImpl<_$NewsListDataImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(
      List<NewsArticle> articles,
      bool hasMore,
      bool isLoadingMore,
    )
    data,
    required TResult Function(String message) error,
  }) {
    return data(articles, hasMore, isLoadingMore);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(
      List<NewsArticle> articles,
      bool hasMore,
      bool isLoadingMore,
    )?
    data,
    TResult? Function(String message)? error,
  }) {
    return data?.call(articles, hasMore, isLoadingMore);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(
      List<NewsArticle> articles,
      bool hasMore,
      bool isLoadingMore,
    )?
    data,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (data != null) {
      return data(articles, hasMore, isLoadingMore);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_NewsListLoading value) loading,
    required TResult Function(_NewsListData value) data,
    required TResult Function(_NewsListError value) error,
  }) {
    return data(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_NewsListLoading value)? loading,
    TResult? Function(_NewsListData value)? data,
    TResult? Function(_NewsListError value)? error,
  }) {
    return data?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_NewsListLoading value)? loading,
    TResult Function(_NewsListData value)? data,
    TResult Function(_NewsListError value)? error,
    required TResult orElse(),
  }) {
    if (data != null) {
      return data(this);
    }
    return orElse();
  }
}

abstract class _NewsListData implements NewsListState {
  const factory _NewsListData({
    required final List<NewsArticle> articles,
    required final bool hasMore,
    required final bool isLoadingMore,
  }) = _$NewsListDataImpl;

  List<NewsArticle> get articles;
  bool get hasMore;
  bool get isLoadingMore;

  /// Create a copy of NewsListState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NewsListDataImplCopyWith<_$NewsListDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$NewsListErrorImplCopyWith<$Res> {
  factory _$$NewsListErrorImplCopyWith(
    _$NewsListErrorImpl value,
    $Res Function(_$NewsListErrorImpl) then,
  ) = __$$NewsListErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$NewsListErrorImplCopyWithImpl<$Res>
    extends _$NewsListStateCopyWithImpl<$Res, _$NewsListErrorImpl>
    implements _$$NewsListErrorImplCopyWith<$Res> {
  __$$NewsListErrorImplCopyWithImpl(
    _$NewsListErrorImpl _value,
    $Res Function(_$NewsListErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of NewsListState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null}) {
    return _then(
      _$NewsListErrorImpl(
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$NewsListErrorImpl implements _NewsListError {
  const _$NewsListErrorImpl({required this.message});

  @override
  final String message;

  @override
  String toString() {
    return 'NewsListState.error(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NewsListErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of NewsListState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NewsListErrorImplCopyWith<_$NewsListErrorImpl> get copyWith =>
      __$$NewsListErrorImplCopyWithImpl<_$NewsListErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(
      List<NewsArticle> articles,
      bool hasMore,
      bool isLoadingMore,
    )
    data,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(
      List<NewsArticle> articles,
      bool hasMore,
      bool isLoadingMore,
    )?
    data,
    TResult? Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(
      List<NewsArticle> articles,
      bool hasMore,
      bool isLoadingMore,
    )?
    data,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_NewsListLoading value) loading,
    required TResult Function(_NewsListData value) data,
    required TResult Function(_NewsListError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_NewsListLoading value)? loading,
    TResult? Function(_NewsListData value)? data,
    TResult? Function(_NewsListError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_NewsListLoading value)? loading,
    TResult Function(_NewsListData value)? data,
    TResult Function(_NewsListError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _NewsListError implements NewsListState {
  const factory _NewsListError({required final String message}) =
      _$NewsListErrorImpl;

  String get message;

  /// Create a copy of NewsListState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NewsListErrorImplCopyWith<_$NewsListErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
