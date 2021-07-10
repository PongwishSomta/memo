import 'dart:convert';

class MedicalModel {
  final String mname;
  final String mdetail;
  final String mcount;
  final String time;
  final String type;
  MedicalModel({
    this.mname,
    this.mdetail,
    this.mcount,
    this.time,
    this.type,
  });

  MedicalModel copyWith({
    String mname,
    String mdetail,
    String mcount,
    String time,
    String type,
  }) {
    return MedicalModel(
      mname: mname ?? this.mname,
      mdetail: mdetail ?? this.mdetail,
      mcount: mcount ?? this.mcount,
      time: time ?? this.time,
      type: type ?? this.type,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'mname': mname,
      'mdetail': mdetail,
      'mcount': mcount,
      'time': time,
      'type': type,
    };
  }

  factory MedicalModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return MedicalModel(
      mname: map['mname'],
      mdetail: map['mdetail'],
      mcount: map['mcount'],
      time: map['time'],
      type: map['type'],
    );
  }

  String toJson() => json.encode(toMap());

  factory MedicalModel.fromJson(String source) => MedicalModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'MedicalModel(mname: $mname, mdetail: $mdetail, mcount: $mcount, time: $time, type: $type)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is MedicalModel &&
      o.mname == mname &&
      o.mdetail == mdetail &&
      o.mcount == mcount &&
      o.time == time &&
      o.type == type;
  }

  @override
  int get hashCode {
    return mname.hashCode ^
      mdetail.hashCode ^
      mcount.hashCode ^
      time.hashCode ^
      type.hashCode;
  }
}
