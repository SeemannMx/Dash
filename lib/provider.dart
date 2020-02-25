import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart';

class Provider {
  Provider._internal() {}
  static Provider _provider = Provider._internal();

  // Objects
  Timer _timer;

  // Parameter
  var _parameter;
  var _value;
  int _runner = 0;

  // URL
  String url_numbers = "http://numbersapi.com/random/math?json";
  String url = "http://localhost:5005";

  factory Provider({var p}) {
    return _provider;
  }

  run(StreamController ctr, limit, intervall) {
    if (_runner == 0) {
      print('Timer started ...');
      _timer = Timer.periodic(Duration(seconds: intervall), (_) {
        _getTime(ctr, limit);
      });
      _runner++;
    }
  }

  _getTime(StreamController ctr, int limit) async {
    _cancelTimer(limit);

    await get(url_numbers).then((_t) {
      _value = jsonDecode(_t.body);
      ctr.sink.add(_value['number']);
    });
  }

  _cancelTimer(int limit) {
    if (_timer.tick > limit) {
      _timer.cancel();
      print('Timer stoped at Tick: ${_timer.tick}');
    }
  }

  clear() {
    if (_timer != null) _timer.cancel();
  }

  chatbot() async {
    print("send request to rasa $url");
    await get(url).then((response) => print(response.body));
  }
}
