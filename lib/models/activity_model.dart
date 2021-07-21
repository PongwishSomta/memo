import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ActivityModel {
  final String actname;
  final String actdir;
  final String type;
  final String tags;
  final DateTime fromdate;
  final DateTime todate;
  ActivityModel({
    @required this.actname,
    @required this.actdir,
    @required this.type,
    @required this.tags,
    @required this.fromdate,
    @required this.todate,
  });

  Map<String, dynamic> toMap() {
    return {
      'actname': actname,
      'actdir': actdir,
      'type': type,
      'tags': tags,
      'fromdate': fromdate.millisecondsSinceEpoch,
      'todate': todate.millisecondsSinceEpoch,
    };
  }

  factory ActivityModel.fromMap(Map<String, dynamic> map) {
    return ActivityModel(
      actname: map['actname'],
      actdir: map['actdir'],
      type: map['type'],
      tags: map['tags'],
      fromdate: DateTime.fromMillisecondsSinceEpoch(map['fromdate']),
      todate: DateTime.fromMillisecondsSinceEpoch(map['todate']),
    );
  }

  String toJson() => json.encode(toMap());

  factory ActivityModel.fromJson(String source) => ActivityModel.fromMap(json.decode(source));
}
