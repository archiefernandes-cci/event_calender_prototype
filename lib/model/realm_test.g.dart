// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'realm_test.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// ignore_for_file: type=lint
class RealmAdditionalNotes extends _RealmAdditionalNotes
    with RealmEntity, RealmObjectBase, RealmObject {
  RealmAdditionalNotes(
    String id,
    String routineDesc,
    String timeOfTheDay,
    String minutes,
    String routineLabel,
    int backgroundColor,
    bool checked,
  ) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'routineDesc', routineDesc);
    RealmObjectBase.set(this, 'timeOfTheDay', timeOfTheDay);
    RealmObjectBase.set(this, 'minutes', minutes);
    RealmObjectBase.set(this, 'routineLabel', routineLabel);
    RealmObjectBase.set(this, 'backgroundColor', backgroundColor);
    RealmObjectBase.set(this, 'checked', checked);
  }

  RealmAdditionalNotes._();

  @override
  String get id => RealmObjectBase.get<String>(this, 'id') as String;
  @override
  set id(String value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get routineDesc =>
      RealmObjectBase.get<String>(this, 'routineDesc') as String;
  @override
  set routineDesc(String value) =>
      RealmObjectBase.set(this, 'routineDesc', value);

  @override
  String get timeOfTheDay =>
      RealmObjectBase.get<String>(this, 'timeOfTheDay') as String;
  @override
  set timeOfTheDay(String value) =>
      RealmObjectBase.set(this, 'timeOfTheDay', value);

  @override
  String get minutes => RealmObjectBase.get<String>(this, 'minutes') as String;
  @override
  set minutes(String value) => RealmObjectBase.set(this, 'minutes', value);

  @override
  String get routineLabel =>
      RealmObjectBase.get<String>(this, 'routineLabel') as String;
  @override
  set routineLabel(String value) =>
      RealmObjectBase.set(this, 'routineLabel', value);

  @override
  int get backgroundColor =>
      RealmObjectBase.get<int>(this, 'backgroundColor') as int;
  @override
  set backgroundColor(int value) =>
      RealmObjectBase.set(this, 'backgroundColor', value);

  @override
  bool get checked => RealmObjectBase.get<bool>(this, 'checked') as bool;
  @override
  set checked(bool value) => RealmObjectBase.set(this, 'checked', value);

  @override
  Stream<RealmObjectChanges<RealmAdditionalNotes>> get changes =>
      RealmObjectBase.getChanges<RealmAdditionalNotes>(this);

  @override
  RealmAdditionalNotes freeze() =>
      RealmObjectBase.freezeObject<RealmAdditionalNotes>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(RealmAdditionalNotes._);
    return const SchemaObject(
        ObjectType.realmObject, RealmAdditionalNotes, 'RealmAdditionalNotes', [
      SchemaProperty('id', RealmPropertyType.string, primaryKey: true),
      SchemaProperty('routineDesc', RealmPropertyType.string),
      SchemaProperty('timeOfTheDay', RealmPropertyType.string),
      SchemaProperty('minutes', RealmPropertyType.string),
      SchemaProperty('routineLabel', RealmPropertyType.string),
      SchemaProperty('backgroundColor', RealmPropertyType.int),
      SchemaProperty('checked', RealmPropertyType.bool),
    ]);
  }
}
