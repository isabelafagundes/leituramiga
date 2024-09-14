import 'package:flutter/material.dart';
import 'package:projeto_leituramiga/domain/tema.dart';
import 'package:projeto_leituramiga/interface/util/responsive.dart';
import 'package:projeto_leituramiga/interface/widget/botao/botao.widget.dart';
import 'package:projeto_leituramiga/interface/widget/input.widget.dart';
import 'package:projeto_leituramiga/interface/widget/menu.widget.dart';
import 'package:projeto_leituramiga/interface/widget/texto/texto.widget.dart';

class FormularioEnderecoWidget extends StatelessWidget {
  final Tema tema;
  final TextEditingController controllerRua;
  final TextEditingController controllerBairro;
  final TextEditingController controllerCep;
  final TextEditingController controllerNumero;
  final TextEditingController controllerComplemento;
  final TextEditingController controllerCidade;
  final TextEditingController controllerEstado;
  final Function(String) aoSelecionarCidade;
  final Function(String) aoSelecionarEstado;
  final List<String> cidades;
  final Function()? aoSalvar;
  final List<String> estados;
  final Widget? botaoInferior;

  const FormularioEnderecoWidget({
    super.key,
    required this.tema,
    required this.controllerRua,
    required this.controllerBairro,
    required this.controllerCep,
    required this.controllerNumero,
    required this.controllerComplemento,
    required this.controllerCidade,
    required this.controllerEstado,
    required this.aoSelecionarCidade,
    required this.aoSelecionarEstado,
    required this.cidades,
    required this.estados,
    this.aoSalvar,
    this.botaoInferior,
  });

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.vertical,
      mainAxisSize: MainAxisSize.max,
      children: [
        TextoWidget(
          texto: "Preencha com o endereço que será feita a entrega!",
          tema: tema,
          align: TextAlign.center,
          cor: Color(tema.baseContent),
        ),
        SizedBox(height: tema.espacamento * 2),
        Flexible(
          child: Flex(
            mainAxisSize: MainAxisSize.min,
            direction: Responsive.larguraP(context) ? Axis.vertical : Axis.horizontal,
            children: [
              Flexible(
                child: InputWidget(
                  tema: tema,
                  controller: controllerCep,
                  label: "CEP",
                  tamanho: tema.tamanhoFonteM,
                  onChanged: (valor) {},
                ),
              ),
              SizedBox(
                width: tema.espacamento * 2,
                height: tema.espacamento * 2,
              ),
              Flexible(
                child: SizedBox(
                  height: 65,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextoWidget(
                        texto: "Estado",
                        tema: tema,
                        cor: Color(tema.baseContent),
                      ),
                      SizedBox(height: tema.espacamento / 2),
                      Expanded(
                        child: MenuWidget(
                          tema: tema,
                          valorSelecionado: controllerEstado.text.isEmpty ? null : controllerEstado.text,
                          escolhas: estados,
                          aoClicar: aoSelecionarEstado,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: tema.espacamento * 2,
          height: tema.espacamento * 2,
        ),
        Flexible(
          child: Flex(
            mainAxisSize: MainAxisSize.min,
            direction: Responsive.larguraP(context) ? Axis.vertical : Axis.horizontal,
            children: [
              Flexible(
                child: SizedBox(
                  height: 65,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextoWidget(
                        texto: "Cidade",
                        tema: tema,
                        cor: Color(tema.baseContent),
                      ),
                      SizedBox(height: tema.espacamento / 2),
                      Expanded(
                        child: MenuWidget(
                          tema: tema,
                          valorSelecionado: controllerCidade.text.isEmpty ? null : controllerCidade.text,
                          escolhas: cidades,
                          aoClicar: aoSelecionarCidade,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: tema.espacamento * 2,
                height: tema.espacamento * 2,
              ),
              Flexible(
                child: InputWidget(
                  tema: tema,
                  controller: controllerBairro,
                  label: "Bairro",
                  tamanho: tema.tamanhoFonteM,
                  onChanged: (valor) {},
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: tema.espacamento * 2,
          height: tema.espacamento * 2,
        ),
        Flexible(
          child: Flex(
            mainAxisSize: MainAxisSize.min,
            direction: Responsive.larguraP(context) ? Axis.vertical : Axis.horizontal,
            children: [
              Flexible(
                flex: Responsive.larguraP(context) ? 1 : 2,
                child: InputWidget(
                  tema: tema,
                  controller: controllerRua,
                  label: "Rua",
                  tamanho: tema.tamanhoFonteM,
                  onChanged: (valor) {},
                ),
              ),
              SizedBox(
                width: tema.espacamento * 2,
                height: tema.espacamento * 2,
              ),
              Flexible(
                child: InputWidget(
                  tema: tema,
                  controller: controllerNumero,
                  label: "Número",
                  tamanho: tema.tamanhoFonteM,
                  onChanged: (valor) {},
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: tema.espacamento * 2,
          height: tema.espacamento * 2,
        ),
        Flexible(
          child: Flex(
            mainAxisSize: MainAxisSize.min,
            direction: Responsive.larguraP(context) ? Axis.vertical : Axis.horizontal,
            children: [
              Flexible(
                child: InputWidget(
                  tema: tema,
                  controller: controllerComplemento,
                  label: "Complemento",
                  tamanho: tema.tamanhoFonteM,
                  onChanged: (valor) {},
                ),
              ),
              if (!Responsive.larguraP(context))
                SizedBox(
                  width: tema.espacamento * 2,
                  height: tema.espacamento * 2,
                ),
              if (!Responsive.larguraP(context))
                Flexible(
                  child: Opacity(
                    opacity: 0,
                    child: InputWidget(
                      tema: tema,
                      controller: controllerNumero,
                      label: "Número",
                      tamanho: tema.tamanhoFonteM,
                      onChanged: (valor) {},
                    ),
                  ),
                ),
            ],
          ),
        ),
        if (botaoInferior != null) ...[
          SizedBox(height: tema.espacamento * 4),
          Container( child: botaoInferior!),
        ],
      ],
    );
  }
}
