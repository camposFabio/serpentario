class Signo {
final String nome;
final String nomeImagem;
final String dtInicio;
final String dtFim;

Signo(this.nome, this.nomeImagem, this.dtInicio, this.dtFim);


factory Signo.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;

    return Signo(
      json['nome'],
      json['nomeImagem'],
      json['dtInicio'],
      json['dtFim'],
    );
  }


}