class Signo {
final String nome;
final String imagem;

Signo(this.nome, this.imagem);


factory Signo.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;

    return Signo(
      json['nome'],
      json['imagem'],
    );
  }


}