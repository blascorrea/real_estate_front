abstract class Repository<T> {
  Future<List<T>> getAll(String? query);
  Future<bool> create(T t);
  Future<bool> update(T t);
  Future<bool> delete(int id);
}