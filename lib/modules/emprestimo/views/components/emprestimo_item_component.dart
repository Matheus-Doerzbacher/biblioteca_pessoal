import 'package:biblioteca_pessoal/core/functions/format_date_function.dart';
import 'package:biblioteca_pessoal/modules/emprestimo/models/emprestimo.dart';
import 'package:flutter/material.dart';

class EmprestimoItemComponents extends StatefulWidget {
  final Emprestimo emprestimo;
  final Function fazerDevolucao;
  final Function excluirDevolucao;

  const EmprestimoItemComponents({
    super.key,
    required this.emprestimo,
    required this.fazerDevolucao,
    required this.excluirDevolucao,
  });

  @override
  State<EmprestimoItemComponents> createState() =>
      _EmprestimoItemComponentsState();
}

class _EmprestimoItemComponentsState extends State<EmprestimoItemComponents> {
  @override
  Widget build(BuildContext context) {
    final agora = DateTime.now();
    final ano = agora.year.toString();
    final mes = agora.month.toString().padLeft(2, '0');
    final dia = agora.day.toString().padLeft(2, '0');
    final hoje = DateTime.parse('$ano-$mes-$dia');

    final livro = widget.emprestimo.livro;
    var estaAtrsado = false;

    if (widget.emprestimo.dataDevolucao != null) {
      estaAtrsado = widget.emprestimo.dataDevolucao!.compareTo(hoje) < 0 &&
          widget.emprestimo.foiDevolvido == false;
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Dismissible(
        key: Key(widget.emprestimo.id!),
        direction: DismissDirection.startToEnd,
        background: widget.emprestimo.foiDevolvido == false
            ? Container(
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: const Icon(Icons.edit, color: Colors.white),
              )
            : Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.red,
                ),
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: const Icon(Icons.delete, color: Colors.white),
              ),
        onDismissed: (direction) {
          if (widget.emprestimo.foiDevolvido == false) {
            widget.fazerDevolucao();
          } else {
            widget.excluirDevolucao();
          }
        },
        confirmDismiss: (direction) async {
          if (widget.emprestimo.foiDevolvido == false) {
            await widget.fazerDevolucao();
            return false;
          }
          return true;
        },
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainer,
            borderRadius: BorderRadius.circular(8),
          ),
          child: ListTile(
            leading: Image.network(livro?.urlImage ?? ''),
            title: Text(
              livro?.titulo ?? '',
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.emprestimo.destinatario.length < 25
                      ? widget.emprestimo.destinatario
                      : '${widget.emprestimo.destinatario.substring(0, 25)}...',
                ),
                const SizedBox(height: 8),
                Text(
                  // ignore: lines_longer_than_80_chars
                  'Empréstimo: ${formatDateFunction(widget.emprestimo.dataEmprestimo)}',
                ),
                if (widget.emprestimo.dataDevolucao != null)
                  Text(
                    // ignore: lines_longer_than_80_chars
                    'Devolução: ${formatDateFunction(widget.emprestimo.dataDevolucao!)}',
                  ),
                Text('Quantidade: ${widget.emprestimo.quantidade}'),
                const SizedBox(height: 8),
                Text(
                  widget.emprestimo.foiDevolvido
                      ? 'Devolvido'
                      : 'Pendente de devolução',
                  style: TextStyle(
                    color: widget.emprestimo.foiDevolvido
                        ? Colors.green
                        : Colors.red,
                  ),
                ),
                if (estaAtrsado)
                  const Text(
                    'Atrassado',
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
              ],
            ),
            trailing: Icon(
              widget.emprestimo.foiDevolvido
                  ? Icons.check_circle
                  : Icons.hourglass_empty,
              color: widget.emprestimo.foiDevolvido ? Colors.green : Colors.red,
            ),
          ),
        ),
      ),
    );
  }
}
