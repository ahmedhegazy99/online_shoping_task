import 'dart:io';
import 'package:csv/csv.dart';

//create a string list that holds n rows of orders
//here create a multi dimentional list that holds n rows from the list above and col from the content of tghe list above rows comma separated
class Order {
  String id;
  String area;
  String name;
  String qnt;
  String brand;

  Order(this.id, this.area, this.name, this.qnt, this.brand);
}


List<Order> csvToOrderList(String data) {
  List<Order> orders = [];
  List<String> _orders = data.split("\n");

  for(int i =0; i < _orders.length ; i++){
    List<String> order = _orders[i].split(",");
    orders.add(new Order(order[0].trim(),order[1].trim(),order[2].trim(),order[3].trim(),order[4].trim()));
  }

  return orders;
  //return const CsvToListConverter().convert(data, eol: "\n");
}