class Cadastro {
  final String texto;
  final int numero;

  Cadastro({
    required this.texto,
    required this.numero,
  });

  Map<String, dynamic> toMap() {
    return {
      'texto': texto,
      'numero': numero,
    };
  }

  factory Cadastro.fromMap(Map<String, dynamic> map) {
    return Cadastro(
      texto: map['texto'],
      numero: map['numero'],
    );
  }
}
