import 'dart:io';
import 'package:csv/csv.dart';
import 'package:online_shoping_task/csvToList.dart';

void main() {
  
  File input = File("assets/input.csv");
  String inputFile = input.readAsStringSync();

  var data = csvToOrderList(inputFile);

  print(data);
}
