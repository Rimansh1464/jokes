import 'package:fecthjocks/model/jocks_modal.dart';
import 'package:http/http.dart' as http;

class JockData {
  JockData._();

  static final JockData joksData = JockData._();

  Future<Joks?> fetchJocksData() async {
    http.Response response = await http.get(
      Uri.parse("https://api.chucknorris.io/jokes/random"),
    );
    print("+++++++++++++++++++++++++++++++++++++++++++++");
    print("+++++++++++++++++++++++++++++++++++++++++++++");
    print(response.body);
    print("+++++++++++++++++++++++++++++++++++++++++++++");
    print("+++++++++++++++++++++++++++++++++++++++++++++");
    if (response.statusCode == 200) {
      Joks joksdata = joksFromJson(response.body);

      return joksdata;
    }
    return null;
  }
}
