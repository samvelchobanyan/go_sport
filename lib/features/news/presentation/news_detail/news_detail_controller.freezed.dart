// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'news_detail_controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$NewsDetailState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(NewsArticle article) data,
    required TResult Function(String message) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(NewsArticle article)? data,
    TResult? Function(String message)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(NewsArticle article)? data,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_NewsDetailLoading value) loading,
    required TResult Function(_NewsDetailData value) data,
    required TResult Function(_NewsDetailError value) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_NewsDetailLoading value)? loading,
    TResult? Function(_NewsDetailData value)? data,
    TResult? Function(_NewsDetailError value)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_NewsDetailLoading value)? loading,
    TResult Function(_NewsDetailData value)? data,
    TResult Function(_NewsDetailError value)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NewsDetailStateCopyWith<$Res> {
  factory $NewsDetailStateCopyWith(
    NewsDetailState value,
    $Res Function(NewsDetailState) then,
  ) = _$NewsDetailStateCopyWithImpl<$Res, NewsDetailState>;
}

/// @nodoc
class _$NewsDetailStateCopyWithImpl<$Res, $Val extends NewsDetailState>
    implements $NewsDetailStateCopyWith<$Res> {
  _$NewsDetailStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NewsDetailState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$NewsDetailLoadingImplCopyWith<$Res> {
  factory _$$NewsDetailLoadingImplCopyWith(
    _$NewsDetailLoadingImpl value,
    $Res Function(_$NewsDetailLoadingImpl) then,
  ) = __$$NewsDetailLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$NewsDetailLoadingImplCopyWithImpl<$Res>
    extends _$NewsDetailStateCopyWithImpl<$Res, _$NewsDetailLoadingImpl>
    implements _$$NewsDetailLoadingImplCopyWith<$Res> {
  __$$NewsDetailLoadingImplCopyWithImpl(
    _$NewsDetailLoadingImpl _value,
    $Res Function(_$NewsDetailLoadingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of NewsDetailState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$NewsDetailLoadingImpl implements _NewsDetailLoading {
  const _$NewsDetailLoadingImpl();

  @override
  String toString() {
    return 'NewsDetailState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$NewsDetailLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(NewsArticle article) data,
    required TResult Function(String message) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(NewsArticle article)? data,
    TResult? Function(String message)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(NewsArticle article)? data,
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
    required TResult Function(_NewsDetailLoading value) loading,
    required TResult Function(_NewsDetailData value) data,
    required TResult Function(_NewsDetailError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_NewsDetailLoading value)? loading,
    TResult? Function(_NewsDetailData value)? data,
    TResult? Function(_NewsDetailError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_NewsDetailLoading value)? loading,
    TResult Function(_NewsDetailData value)? data,
    TResult Function(_NewsDetailError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _NewsDetailLoading implements NewsDetailState {
  const factory _NewsDetailLoading() = _$NewsDetailLoadingImpl;
}

/// @nodoc
abstract class _$$NewsDetailDataImplCopyWith<$Res> {
  factory _$$NewsDetailDataImplCopyWith(
    _$NewsDetailDataImpl value,
    $Res Function(_$NewsDetailDataImpl) then,
  ) = __$$NewsDetailDataImplCopyWithImpl<$Res>;
  @useResult
  $Res call({NewsArticle article});

  $NewsArticleCopyWith<$Res> get article;
}

/// @nodoc
class __$$NewsDetailDataImplCopyWithImpl<$Res>
    extends _$NewsDetailStateCopyWithImpl<$Res, _$NewsDetailDataImpl>
    implements _$$NewsDetailDataImplCopyWith<$Res> {
  __$$NewsDetailDataImplCopyWithImpl(
    _$NewsDetailDataImpl _value,
    $Res Function(_$NewsDetailDataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of NewsDetailState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? article = null}) {
    return _then(
      _$NewsDetailDataImpl(
        article: null == article
            ? _value.article
            : article // ignore: cast_nullable_to_non_nullable
                  as NewsArticle,
      ),
    );
  }

  /// Create a copy of NewsDetailState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $NewsArticleCopyWith<$Res> get article {
    return $NewsArticleCopyWith<$Res>(_value.article, (value) {
      return _then(_value.copyWith(article: value));
    });
  }
}

/// @nodoc

class _$NewsDetailDataImpl implements _NewsDetailData {
  const _$NewsDetailDataImpl({required this.article});

  @override
  final NewsArticle article;

  @override
  String toString() {
    return 'NewsDetailState.data(article: $article)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NewsDetailDataImpl &&
            (identical(other.article, article) || other.article == article));
  }

  @override
  int get hashCode => Object.hash(runtimeType, article);

  /// Create a copy of NewsDetailState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NewsDetailDataImplCopyWith<_$NewsDetailDataImpl> get copyWith =>
      __$$NewsDetailDataImplCopyWithImpl<_$NewsDetailDataImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(NewsArticle article) data,
    required TResult Function(String message) error,
  }) {
    return data(article);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(NewsArticle article)? data,
    TResult? Function(String message)? error,
  }) {
    return data?.call(article);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(NewsArticle article)? data,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (data != null) {
      return data(article);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_NewsDetailLoading value) loading,
    required TResult Function(_NewsDetailData value) data,
    required TResult Function(_NewsDetailError value) error,
  }) {
    return data(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_NewsDetailLoading value)? loading,
    TResult? Function(_NewsDetailData value)? data,
    TResult? Function(_NewsDetailError value)? error,
  }) {
    return data?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_NewsDetailLoading value)? loading,
    TResult Function(_NewsDetailData value)? data,
    TResult Function(_NewsDetailError value)? error,
    required TResult orElse(),
  }) {
    if (data != null) {
      return data(this);
    }
    return orElse();
  }
}

abstract class _NewsDetailData implements NewsDetailState {
  const factory _NewsDetailData({required final NewsArticle article}) =
      _$NewsDetailDataImpl;

  NewsArticle get article;

  /// Create a copy of NewsDetailState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NewsDetailDataImplCopyWith<_$NewsDetailDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$NewsDetailErrorImplCopyWith<$Res> {
  factory _$$NewsDetailErrorImplCopyWith(
    _$NewsDetailErrorImpl value,
    $Res Function(_$NewsDetailErrorImpl) then,
  ) = __$$NewsDetailErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$NewsDetailErrorImplCopyWithImpl<$Res>
    extends _$NewsDetailStateCopyWithImpl<$Res, _$NewsDetailErrorImpl>
    implements _$$NewsDetailErrorImplCopyWith<$Res> {
  __$$NewsDetailErrorImplCopyWithImpl(
    _$NewsDetailErrorImpl _value,
    $Res Function(_$NewsDetailErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of NewsDetailState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null}) {
    return _then(
      _$NewsDetailErrorImpl(
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$NewsDetailErrorImpl implements _NewsDetailError {
  const _$NewsDetailErrorImpl({required this.message});

  @override
  final String message;

  @override
  String toString() {
    return 'NewsDetailState.error(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NewsDetailErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of NewsDetailState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NewsDetailErrorImplCopyWith<_$NewsDetailErrorImpl> get copyWith =>
      __$$NewsDetailErrorImplCopyWithImpl<_$NewsDetailErrorImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(NewsArticle article) data,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(NewsArticle article)? data,
    TResult? Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(NewsArticle article)? data,
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
    required TResult Function(_NewsDetailLoading value) loading,
    required TResult Function(_NewsDetailData value) data,
    required TResult Function(_NewsDetailError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_NewsDetailLoading value)? loading,
    TResult? Function(_NewsDetailData value)? data,
    TResult? Function(_NewsDetailError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_NewsDetailLoading value)? loading,
    TResult Function(_NewsDetailData value)? data,
    TResult Function(_NewsDetailError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _NewsDetailError implements NewsDetailState {
  const factory _NewsDetailError({required final String message}) =
      _$NewsDetailErrorImpl;

  String get message;

  /// Create a copy of NewsDetailState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NewsDetailErrorImplCopyWith<_$NewsDetailErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
