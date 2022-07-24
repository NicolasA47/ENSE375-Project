import 'package:flutter/cupertino.dart';

class MetricModel{
  String projectGoal;
  List<String> desc;
  List<int> votes;
  Color? statusColor;

MetricModel({required this.projectGoal, required this.desc, required this.votes,this.statusColor});
}