

class Kata2 {
  List<ItemKata> _list = [];
  Kata2.fromSnapshot(Map<dynamic, dynamic> values) {
    List<ItemKata> temp = [];
    values.forEach((key, value) {
      ItemKata item = ItemKata(value);
//      Kata isi = Kata.fromSnapshot(value);
//      Kata isi = Kata(values['id'].toString(),values['indonesia'].toString(),values['penjelasan'].toString(),values['sunda'].toString());

      temp.add(item);
    });
    _list = temp;
  }
  List<ItemKata> get list => _list;
}

class ItemKata {
  String id;
  String indonesia;
  String penjelasan;
  String sunda;
  ItemKata(content) {
    this.id = content['id'];
    indonesia = content['indonesia'];
    penjelasan = content['penjelasan'];
    sunda = content['sunda'];
  }
}
