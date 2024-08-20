enum TipoStatusSolicitacao {
  EM_ANDAMENTO(id:1, descricao:"Aberta"),
  PENDENTE(id:2, descricao: "Pendente"),
  FINALIZADA(id:3, descricao:"Finalizada"),
  CANCELADA(id:4, descricao:"Cancelada");

  final int id;
  final String descricao;

  factory TipoStatusSolicitacao.deNumero(int numero) {
    return TipoStatusSolicitacao.values.where((e) => e.id == numero).firstOrNull ?? TipoStatusSolicitacao.EM_ANDAMENTO;
  }

  const TipoStatusSolicitacao({required this.id, required this.descricao});
}