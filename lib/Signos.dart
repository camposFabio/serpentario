import 'package:flutter/material.dart';
import 'package:serpentario/Mensagem.dart';
import 'package:serpentario/modelo/signo.dart';
import 'package:serpentario/repositorio/signoApi.dart';

class _Seletor extends StatefulWidget {
  @override
  const _Seletor({this.signos});

  final List<Signo> signos;

  _SeletorState createState() => new _SeletorState();
}

class _SeletorState extends State<_Seletor>
    with TickerProviderStateMixin {
  TabController tabController;
  SignoApi signoApi;

  @override
  void initState() {
    super.initState();
    tabController = new TabController(vsync: this, length: widget.signos.length);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  void _handleScroll(DragUpdateDetails details) {
    print(details.delta.dx);
    if (details.delta.dx > 0) // Drag Direita
    {
      _handleArrowButtonPress(1);
    } else if (details.delta.dx < 0) // Drag Direita
    {
      _handleArrowButtonPress(-1);
    }
  }

  void _handleArrowButtonPress(int delta) {
    int max = widget.signos.length - 1;
    int index = tabController.index + delta;

    index = index < 0 ? max : index > max ? 0 : index;

    
     if (!tabController.indexIsChanging) tabController.animateTo(index);
  }

  @override
  Widget build(BuildContext context) {
    final Color color = Theme.of(context).accentColor;
    return DefaultTabController(
      length: widget.signos.length,
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
                      _handleArrowButtonPress(-1);
                    },
                    tooltip: 'Anterior',
                  ),
                  TabPageSelector(controller: tabController,
                  ),
                  IconButton(
                    icon: const Icon(Icons.chevron_right),
                    color: color,
                    onPressed: () {
                      _handleArrowButtonPress(1);
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
                  controller: tabController,
                  children: widget.signos.map<Widget>((Signo signo) {
                    return Container(
                      padding: const EdgeInsets.all(12.0),
                      child: Card(
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          side: BorderSide(color: Colors.blue),
                        ),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                  'assets/imagem/${signo.nomeImagem}.png'),
                              Text(
                                signo.nome,
                                style: TextStyle(
                                  fontSize: 40,
                                ),
                              ),
                              Text(signo.dtInicio),
                              Text(signo.dtFim),
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

class Signos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SignoApi signoApi = SignoApi();

    return Scaffold(
      appBar: AppBar(
        
        title: const Text('Serpentário'),
        centerTitle: true,
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
                  return _Seletor(signos: snapshot.data);
                }
            }
          }),
    );
  }
}
