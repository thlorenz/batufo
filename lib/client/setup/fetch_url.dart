import 'package:http/http.dart' as http;

const _GIST_ID = '223d2bf2c281a64bc60af9ea770e13c6';
const _GIST_URL = 'https://gist.github.com/thlorenz/';
final _rx = RegExp(r'(http://.+ngrok.io)');

Future<String> fetchURL([String gistID = _GIST_ID]) async {
  final url = '$_GIST_URL$gistID.json';

  final res = await http.get(url);
  assert(res.statusCode == 200,
      'request failed ${res.statusCode}, ${res.reasonPhrase}');

  final match = _rx.firstMatch(res.body);
  assert(match != null, 'no matches found in ${res.body}');
  return match.group(0);
}
