import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'dart:html';

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import 'network/api_client.dart';

class Repository {
  Repository();

  final ApiClient _api = GetIt.I.get<ApiClient>();

  Stream<String> test() async* {
    for (int i = 1; i <= 5; i++) {
      yield i.toString(); // Emit the next value in the stream
      await Future.delayed(Duration(seconds: 1)); // Simulate some delay
    }
  }

  genResponse() async {
    final baseUrl = Uri.parse('http://localhost:11434/api/generate');
    const prompt = "why is the sky blue? please answer in 10 words";

    // final Response response = await _api.dio.post(
    //   'http://localhost:11434/api/generate',
    //   data: {
    //     "model": "gemma2:2b",
    //     "prompt": prompt,
    //     "stream": true,
    //   },
    //   options: Options(responseType: ResponseType.stream),
    // );

    // return response.data;

    // StreamTransformer<Uint8List, List<int>> unit8Transformer = StreamTransformer.fromHandlers(
    //   handleData: (data, sink) {
    //     sink.add(List<int>.from(data));
    //   },
    // );

    // return response.data?.stream
    //     .transform(unit8Transformer)
    //     .transform(const Utf8Decoder())
    //     .transform(const LineSplitter());

    // return response.data.stream;

    // // ===

    // // Access the stream from the response data
    // final stream = response.data.stream;

    // await for (var chunk in stream) {
    //   // Process chunk here; e.g., decode JSON if needed
    //   final data = utf8.decode(chunk).toString();
    //   yield data; // Emit each chunk as it's received
    // }

    // ===

    // //Stream<Uint8List>
    // final stream = response.data.stream;

    // print(stream.runtimeType); //_ControllerStream<Uint8List>

    // await for (var chunk in stream) {
    //   // Process chunk here; e.g., decode JSON if needed
    //   final data = chunk.toString();
    //   yield data; // Emit each chunk as it's received

    //   // yield chunk['response'];
    // }

    // return response.data.stream;

    // ===

    // // var url = Uri.https('http://localhost:11434', 'api/generate');
    // // var response = await http.post(url, body: {
    // //   "model": "gemma2:2b",
    // //   "prompt": "please answer less than 10 words. what is water?",
    // //   "stream": false
    // // });

    // // print('Response status: ${response.statusCode}');
    // // print('Response body: ${response.body}');

    // ===

    // final url = Uri.parse('http://localhost:11434/api/generate');
    // final client = http.Client();

    // final request = http.Request('POST', url);

    // final body = jsonEncode({
    //   "model": "gemma2:2b",
    //   "prompt": prompt,
    // });

    // request.body = body;

    // final response = await client.send(request);

    // // return response.stream.transform(utf8.decoder);

    // int c = 0;

    // await for (var chunk in response.stream.transform(utf8.decoder)) {
    //   print(++c);
    //   print(chunk);

    //   final resp = json.decode(chunk);

    //   print(resp['']);

    //   // yield resp['response'].toString();

    //   // yield chunk;
    // }

    // ===

    bool syncingz = true;
    Map<String, String> body = {
      "model": "gemma2:2b",
      "prompt": prompt,
    };

    // This is for Flutter Web
    final httpReq = HttpRequest();
    String alreadyReceived = '';
    var parts = [];
    body.forEach((key, value) {
      parts.add('$key=$value');
      // parts.add('${Uri.encodeQueryComponent(key)}='
      //     '${Uri.encodeQueryComponent(value)}');
    });
    var data = parts.join('&');

    httpReq
      ..open('POST', 'http://localhost:11434/api/generate')
      ..setRequestHeader('Content-Type', 'application/JSON; charset=UTF-8')
      ..onProgress.listen((event) {
        // 3 characters is the min before it registers as an event...less than 3 characters, its gonna return blank until above 3.
        final res = httpReq.responseText!.replaceAll(RegExp(alreadyReceived), '');
        print(res);
        alreadyReceived = httpReq.responseText ?? '';
      })
      ..onLoadEnd.listen((event) {
        print('all done');
        syncingz = false;
      })
      ..onError.listen((event) {})
      ..send(data);
    await httpReq
        .onLoadEnd.isEmpty; // this is to block the code from going forward until httpReq is done
    print('this is the END');
  }
}
