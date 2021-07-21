import 'dart:convert';
import 'package:flutter/material.dart';

class Medmodel {
  String medname;
  String valueChoose;
  String meddir;
  DateTime selectedDateTime;
  String medtag;
  String daytag;

  Medmodel({
    @required this.medname,
    @required this.valueChoose,
    @required this.meddir,
    @required this.selectedDateTime,
    @required this.medtag,
    @required this.daytag,
  });

  Medmodel copyWith({
    String medname,
    String valueChoose,
    String meddir,
    DateTime selectedDateTime,
    String medtag,
    String daytag,
  }) {
    return Medmodel(
      medname: medname ?? this.medname,
      valueChoose: valueChoose ?? this.valueChoose,
      meddir: meddir ?? this.meddir,
      selectedDateTime: selectedDateTime ?? this.selectedDateTime,
      medtag: medtag ?? this.medtag,
      daytag: daytag ?? this.daytag,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'medname': medname,
      'valueChoose': valueChoose,
      'meddir': meddir,
      'selectedDateTime': selectedDateTime.millisecondsSinceEpoch,
      'medtag': medtag,
      'daytag': daytag,
    };
  }

  factory Medmodel.fromMap(Map<String, dynamic> map) {
    return Medmodel(
      medname: map['medname'],
      valueChoose: map['valueChoose'],
      meddir: map['meddir'],
      selectedDateTime: DateTime.fromMillisecondsSinceEpoch(map['selectedDateTime']),
      medtag: map['medtag'],
      daytag: map['daytag'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Medmodel.fromJson(String source) => Medmodel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Medmodel(medname: $medname, valueChoose: $valueChoose, meddir: $meddir, selectedDateTime: $selectedDateTime, medtag: $medtag, daytag: $daytag)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Medmodel &&
      other.medname == medname &&
      other.valueChoose == valueChoose &&
      other.meddir == meddir &&
      other.selectedDateTime == selectedDateTime &&
      other.medtag == medtag &&
      other.daytag == daytag;
  }

  @override
  int get hashCode {
    return medname.hashCode ^
      valueChoose.hashCode ^
      meddir.hashCode ^
      selectedDateTime.hashCode ^
      medtag.hashCode ^
      daytag.hashCode;
  }
}
