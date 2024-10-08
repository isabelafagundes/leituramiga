import 'package:flutter/material.dart';
import 'package:leituramiga/component/livros.component.dart';
import 'package:leituramiga/domain/solicitacao/tipo_solicitacao.dart';
import 'package:projeto_leituramiga/application/state/tema.state.dart';
import 'package:projeto_leituramiga/contants.dart';
import 'package:projeto_leituramiga/domain/tema.dart';
import 'package:projeto_leituramiga/infrastructure/repo/mock/categoria_mock.repo.dart';
import 'package:projeto_leituramiga/infrastructure/repo/mock/endereco_mock.repo.dart';
import 'package:projeto_leituramiga/infrastructure/repo/mock/instituicao_mock.repo.dart';
import 'package:projeto_leituramiga/infrastructure/repo/mock/livro_mock.repo.dart';
import 'package:projeto_leituramiga/interface/configuration/rota/app_router.dart';
import 'package:projeto_leituramiga/interface/configuration/rota/rota.dart';
import 'package:projeto_leituramiga/interface/util/responsive.dart';
import 'package:projeto_leituramiga/interface/widget/background/background.widget.dart';
import 'package:projeto_leituramiga/interface/widget/botao/botao.widget.dart';
import 'package:projeto_leituramiga/interface/widget/chip/chip.widget.dart';
import 'package:projeto_leituramiga/interface/widget/imagem.widget.dart';
import 'package:projeto_leituramiga/interface/widget/menu_lateral/conteudo_menu_lateral.widget.dart';
import 'package:projeto_leituramiga/interface/widget/notificacao.widget.dart';
import 'package:projeto_leituramiga/interface/widget/texto/texto.widget.dart';
import 'package:projeto_leituramiga/interface/widget/texto/texto_com_icone.widget.dart';
import 'package:auto_route/auto_route.dart';

@RoutePage()
class LivrosPage extends StatefulWidget {
  final int numeroLivro;

  const LivrosPage({super.key, @PathParam('numeroLivro') required this.numeroLivro});

  @override
  State<LivrosPage> createState() => _LivrosPageState();
}

class _LivrosPageState extends State<LivrosPage> {
  TipoSolicitacao? _tipoSolicitacaoSelecionado;
  final LivrosComponent _livrosComponent = LivrosComponent();

  TemaState get _temaState => TemaState.instancia;

  Tema get tema => _temaState.temaSelecionado!;

  @override
  void initState() {
    _livrosComponent.inicializar(
      LivroMockRepo(),
      CategoriaMockRepo(),
      InstituicaoMockRepo(),
      EnderecoMockRepo(),
      atualizar,
    );
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _livrosComponent.obterLivro(widget.numeroLivro);
    });
  }

  void atualizar() => setState(() {});

  @override
  Widget build(BuildContext context) {
    return BackgroundWidget(
      tema: tema,
      child: ConteudoMenuLateralWidget(
        tema: tema,
        atualizar: atualizar,
        voltar: () => Rota.navegar(context, Rota.HOME),
        carregando: _livrosComponent.carregando || _livrosComponent.livroSelecionado == null,
        child: SizedBox(
          width: Responsive.largura(context),
          height: Responsive.altura(context),
          child: SingleChildScrollView(
            child: _livrosComponent.livroSelecionado == null
                ? const SizedBox()
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flex(
                        direction: Responsive.larguraM(context) ? Axis.vertical : Axis.horizontal,
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment:
                            Responsive.larguraM(context) ? CrossAxisAlignment.center : CrossAxisAlignment.start,
                        children: [

                          Flexible(
                            child: Column(
                              children: [
                                ImagemWidget(
                                  tema: tema,
                                  visualizacao: true,
                                  salvarImagem: (imagem64) => print(imagem64),
                                ),
                                SizedBox(height: tema.espacamento * 2),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    TextoWidget(
                                      texto: _livrosComponent.livroSelecionado?.nome ?? '',
                                      tema: tema,
                                      tamanho: tema.tamanhoFonteG,
                                      cor: Color(tema.accent),
                                    ),
                                    SizedBox(height: tema.espacamento),
                                    TextoWidget(
                                      texto: _livrosComponent.livroSelecionado?.nomeAutor ?? '',
                                      tema: tema,
                                      cor: Color(tema.baseContent),
                                    ),
                                    SizedBox(height: tema.espacamento / 2),
                                    if (Responsive.larguraM(context))
                                      SizedBox(
                                        width: 200,
                                        child: Divider(
                                          color: Color(tema.accent),
                                        ),
                                      ),
                                    SizedBox(height: tema.espacamento),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: tema.espacamento * 5),
                          Flexible(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextoWidget(
                                  texto: "Descrição: ",
                                  tema: tema,
                                  weight: FontWeight.w500,
                                  cor: Color(tema.accent),
                                ),
                                TextoWidget(
                                  texto: _livrosComponent.livroSelecionado?.descricao ?? '',
                                  tema: tema,
                                  cor: Color(tema.baseContent),
                                ),
                                SizedBox(height: tema.espacamento),
                                TextoWidget(
                                  texto: "Estado do livro: ",
                                  tema: tema,
                                  weight: FontWeight.w500,
                                  cor: Color(tema.accent),
                                ),
                                TextoWidget(
                                  texto: _livrosComponent.livroSelecionado?.descricaoEstado ?? '',
                                  tema: tema,
                                  cor: Color(tema.baseContent),
                                ),
                                SizedBox(height: tema.espacamento),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: SizedBox(
                                    width: 300,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        TextoComIconeWidget(
                                          tema: tema,
                                          nomeSvg: 'usuario/user',
                                          texto: _livrosComponent.livroSelecionado?.nomeUsuario ?? '',
                                          tamanhoFonte: tema.tamanhoFonteM,
                                        ),
                                        SizedBox(height: tema.espacamento / 2),
                                        TextoComIconeWidget(
                                          tema: tema,
                                          nomeSvg: 'academico/academic-cap',
                                          texto: _livrosComponent.livroSelecionado?.nomeInstituicao ?? '',
                                          tamanhoFonte: tema.tamanhoFonteM,
                                        ),
                                        SizedBox(height: tema.espacamento / 2),
                                        TextoComIconeWidget(
                                          tema: tema,
                                          nomeSvg: 'menu/map-pin-fill',
                                          texto: _livrosComponent.livroSelecionado?.nomeMunicipio ?? '',
                                          tamanhoFonte: tema.tamanhoFonteM,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: tema.espacamento * 2),
                      Column(
                        children: [
                          TextoWidget(
                            texto: "Selecione o tipo de solicitação que deseja efetuar",
                            tema: tema,
                            cor: Color(tema.baseContent),
                          ),
                          SizedBox(height: tema.espacamento),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              if (_livrosComponent.livroSelecionado?.tiposSolicitacao.contains(TipoSolicitacao.TROCA) ??
                                  false) ...[
                                ChipWidget(
                                  tema: tema,
                                  cor: kCorPessego,
                                  texto: "Troca",
                                  corTexto: kCorFonte,
                                  ativado: _tipoSolicitacaoSelecionado == TipoSolicitacao.TROCA,
                                  aoClicar: () => setState(() => _tipoSolicitacaoSelecionado = TipoSolicitacao.TROCA),
                                ),
                                SizedBox(width: tema.espacamento * 2),
                              ],
                              if (_livrosComponent.livroSelecionado!.tiposSolicitacao
                                  .contains(TipoSolicitacao.EMPRESTIMO)) ...[
                                ChipWidget(
                                  tema: tema,
                                  cor: kCorVerde,
                                  texto: "Empréstimo",
                                  ativado: _tipoSolicitacaoSelecionado == TipoSolicitacao.EMPRESTIMO,
                                  corTexto: kCorFonte,
                                  aoClicar: () =>
                                      setState(() => _tipoSolicitacaoSelecionado = TipoSolicitacao.EMPRESTIMO),
                                ),
                                SizedBox(width: tema.espacamento * 2),
                              ],
                              if (_livrosComponent.livroSelecionado!.tiposSolicitacao.contains(TipoSolicitacao.DOACAO))
                                ChipWidget(
                                  tema: tema,
                                  cor: kCorAzul,
                                  texto: "Doação",
                                  corTexto: kCorFonte,
                                  ativado: _tipoSolicitacaoSelecionado == TipoSolicitacao.DOACAO,
                                  aoClicar: () => setState(() => _tipoSolicitacaoSelecionado = TipoSolicitacao.DOACAO),
                                ),
                            ],
                          ),
                          SizedBox(height: tema.espacamento * 2),
                          BotaoWidget(
                            tema: tema,
                            texto: 'Criar solicitação',
                            icone: Icon(
                              Icons.chevron_right,
                              color: Color(tema.base200),
                            ),
                            aoClicar: () {
                              if (_tipoSolicitacaoSelecionado == null) {
                                Notificacoes.mostrar("Selecione um tipo de solicitação", Emoji.ALERTA);
                                return;
                              }
                              Rota.navegarComArgumentos(
                                context,
                                CriarSolicitacaoRoute(
                                  numeroLivro: _livrosComponent.livroSelecionado!.numero,
                                  tipoSolicitacao: _tipoSolicitacaoSelecionado!.id,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

}
