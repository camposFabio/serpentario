import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:serpentario/modelo/signo.dart';

class SignoApi {
  Future<List<Signo>> lerSignos(String arquivo) async {
    List<Signo> signos;

    String json = await rootBundle.loadString('assets/json/$arquivo');

    signos = (jsonDecode(json) as List)
        .map((value) => new Signo.fromJson(value))
        .toList();

    return signos;
  }
}
