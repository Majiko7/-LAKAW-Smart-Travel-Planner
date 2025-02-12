import '../database.dart';

class UsersTable extends SupabaseTable<UsersRow> {
  @override
  String get tableName => 'users';

  @override
  UsersRow createRow(Map<String, dynamic> data) => UsersRow(data);
}

class UsersRow extends SupabaseDataRow {
  UsersRow(super.data);

  @override
  SupabaseTable get table => UsersTable();

  String get id => getField<String>('id')!;
  set id(String value) => setField<String>('id', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);

  int get username => getField<int>('username')!;
  set username(int value) => setField<int>('username', value);

  int get email => getField<int>('email')!;
  set email(int value) => setField<int>('email', value);

  String get password => getField<String>('password')!;
  set password(String value) => setField<String>('password', value);
}
