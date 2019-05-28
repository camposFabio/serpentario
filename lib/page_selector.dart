// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:serpentario/Mensagem.dart';
import 'package:serpentario/modelo/signo.dart';
import 'package:serpentario/repositorio/signoApi.dart';

class _PageSelector extends StatelessWidget {
  const _PageSelector({this.signos});

  final List<Signo> signos;

  void _handleArrowButtonPress(BuildContext context, int delta) {
    final TabController controller = DefaultTabController.of(context);
    if (!controller.indexIsChanging)
      controller
          .animateTo((controller.index + delta).clamp(0, signos.length - 1));
  }

  @override
  Widget build(BuildContext context) {
    final TabController controller = DefaultTabController.of(context);
    final Color color = Theme.of(context).accentColor;
    return DefaultTabController(
      length: signos.length,
      child: SafeArea(
        top: false,
        bottom: false,
        child: Column(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(top: 16.0),
              child: Row(
                children: <Widget>[
                  IconButton(
                    icon: const Icon(Icons.chevron_left),
                    color: color,
                    onPressed: () {
                      _handleArrowButtonPress(context, -1);
                    },
                    tooltip: 'Anterior',
                  ),
                  TabPageSelector(controller: controller),
                  IconButton(
                    icon: const Icon(Icons.chevron_right),
                    color: color,
                    onPressed: () {
                      _handleArrowButtonPress(context, 1);
                    },
                    tooltip: 'Próximo',
                  ),
                ],
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
              ),
            ),
            Expanded(
              child: IconTheme(
                data: IconThemeData(
                  size: 128.0,
                  color: color,
                ),
                child: TabBarView(
                  children: signos.map<Widget>((Signo signo) {
                    return Container(
                      padding: const EdgeInsets.all(12.0),
                      child: Card(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                          Image.asset('assets/imagem/${signo.imagem}.png'),
                          Text(
                            signo.nome,
                            style: TextStyle(
                              fontSize: 40,
                            ),
                          ),
                        ]),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PageSelectorDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SignoApi signoApi = SignoApi();

    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.star_border),
        title: const Text('Serpentário'),
      ),
      body: FutureBuilder<List<Signo>>(
          future: signoApi.lerSignos('signos.json'),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return Mensagem(mensagem: "Carregando dados");
                break;
              default:
                if (snapshot.hasError) {
                  return Mensagem(mensagem: "Erro ao carregar dados! :(");
                } else {
                  return _PageSelector(signos: snapshot.data);
                }
            }
          }),
    );
  }
}
