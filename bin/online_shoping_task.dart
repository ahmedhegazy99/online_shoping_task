import 'dart:io';
import 'package:csv/csv.dart';
import 'package:online_shoping_task/csvToList.dart';
import 'package:test/expect.dart';

Future<void> main() async {
  File input = File("assets/input.csv");
  String inputFile = input.readAsStringSync();

  var data = csvToOrderList(inputFile);
  var nameRepeatMap = Map();
  var bestOrderRepeatMap = Map();
  var input1Map = Map();

  List input0List = [];
  List dirtyInput1List = [];
  List input1List = [];

  // print(data);

  data.forEach((e) {
    if (!nameRepeatMap.containsKey(e.name)) {
      nameRepeatMap[e.name] = int.parse(e.qnt);
    } else {
      nameRepeatMap[e.name] = int.parse(e.qnt) + nameRepeatMap[e.name];
    }

    if (!bestOrderRepeatMap.containsKey("${e.name}+${e.brand}")) {
      bestOrderRepeatMap["${e.name}+${e.brand}"] = 1;
    } else {
      bestOrderRepeatMap["${e.name}+${e.brand}"] += 1;
    }
  });

  nameRepeatMap.forEach((key, value) =>
      input0List.add({"name": key, "number": value / data.length}));

  var sortMapByValue = Map.fromEntries(bestOrderRepeatMap.entries.toList()
    ..sort((e1, e2) => e2.value.compareTo(e1.value)));

  sortMapByValue.forEach((key, value) {
    var keySplitted = key.toString().split("+");
    dirtyInput1List.add(
        {"name": keySplitted[0], "brand": keySplitted[1], "number": value});
  });

  dirtyInput1List.forEach(
    (element) {
      if (!input1Map.containsKey(element["name"])) {
        input1Map[element["name"]] = element['brand'];
      }
    },
  );

  input1Map.forEach(
    (key, value) {
      input1List.add({"name": key, "brand": value});
    },
  );

  print(input0List);
  print(input1List);

  List<List> i0List = <List>[];
  input0List.forEach((element) {

    i0List.add([element["name"], element["number"]]);
  });
  String csv0 = const ListToCsvConverter().convert(i0List,
            fieldDelimiter: ',',
            eol: '\n');
  print(csv0);


  List<List> i1List = <List>[];
  input1List.forEach((element) {

    i1List.add([element["name"], element["brand"]]);
  });
  String csv1 = const ListToCsvConverter().convert(i1List,
            fieldDelimiter: ',',
            eol: '\n');
  print(csv1);

  File file0 = new File("assets/0_input.csv");
  File file1 = new File("assets/1_input.csv");

  file0.writeAsString(csv0); 
  file1.writeAsString(csv1); 

}


// ID644525,Roger Centers, Intelligent Copper Knife,1,Kunze-Bernhard
// D944806,Willard Vista, Intelligent Copper Knife,3,Hilll-Gorczany 
// ID348204,Roger Centers, Small Granite Shoes,4,Rowe and Legros 
// ID710139,Roger Centers, Intelligent Copper Knife,4,Hilll-Gorczany
// ID426632,Willa Hollow, Intelligent Copper Knife,4,Hilll-Gorczany