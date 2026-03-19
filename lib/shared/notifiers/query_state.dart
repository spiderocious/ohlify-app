sealed class QueryState<T> {
  const QueryState();
}

final class QueryIdle<T> extends QueryState<T> {
  const QueryIdle();
}

final class QueryLoading<T> extends QueryState<T> {
  const QueryLoading();
}

final class QuerySuccess<T> extends QueryState<T> {
  const QuerySuccess(this.data);
  final T data;
}

final class QueryError<T> extends QueryState<T> {
  const QueryError(this.error);
  final Object error;
}
