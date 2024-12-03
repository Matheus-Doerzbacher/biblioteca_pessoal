import 'package:flutter/material.dart';

// Componente personalizado que utiliza o RestorableDateTime para persistir o
//estado da data
class SelecionarDataEmprestimoComponent extends StatefulWidget {
  final String? restorationId;
  final Function handleDate;
  final bool isDevolucao;

  const SelecionarDataEmprestimoComponent({
    super.key,
    this.restorationId,
    required this.handleDate,
    this.isDevolucao = false,
  });

  @override
  State<SelecionarDataEmprestimoComponent> createState() =>
      _DatePickerExampleState();
}

class _DatePickerExampleState extends State<SelecionarDataEmprestimoComponent>
    with RestorationMixin {
  @override
  String? get restorationId => widget.restorationId;

  // Cria uma instância de RestorableDateTime para armazenar a data selecionada.
  // O valor inicial é definido como 25 de julho de 2021.
  final RestorableDateTime _selectedDate = RestorableDateTime(DateTime.now());

  // Cria um RestorableRouteFuture que controla a apresentação do DatePicker.
  late final RestorableRouteFuture<DateTime?> _restorableDatePickerRouteFuture =
      RestorableRouteFuture<DateTime?>(
    // Define a função a ser chamada quando a data for selecionada.
    onComplete: _selectDate,
    // Função que define como o DatePicker será exibido.
    onPresent: (NavigatorState navigator, Object? arguments) {
      return navigator.restorablePush(
        _datePickerRoute, // Função que constrói a rota para o DatePicker.
        // Envia a data selecionada em milissegundos como argumento.
        arguments: _selectedDate.value.millisecondsSinceEpoch,
      );
    },
  );

  // Função que define a rota para exibir o DatePicker usando o DialogRoute.
  //    @program: Marca esta função para que o compilador a mantenha intacta ao
  //    otimizar o código.
  @pragma('vm:entry-point')
  static Route<DateTime> _datePickerRoute(
    BuildContext context,
    Object? arguments,
  ) {
    // Cria uma rota de diálogo que exibe o DatePickerDialog.
    return DialogRoute<DateTime>(
      context: context,
      builder: (BuildContext context) {
        return DatePickerDialog(
          // ID de restauração para o diálogo.
          restorationId: 'date_picker_dialog',
          // Define o modo inicial como "apenas calendário".
          initialEntryMode: DatePickerEntryMode.calendarOnly,
          // Converte os milissegundos da data para DateTime.
          initialDate: DateTime.fromMillisecondsSinceEpoch(arguments! as int),
          // Define a primeira data que pode ser selecionada
          // como 1 de janeiro de 2021.
          firstDate: DateTime.now().subtract(const Duration(days: 15)),
          // Define a última data que pode ser selecionada
          //como 31 de dezembro de 2022.
          lastDate: DateTime(DateTime.now().year + 2),
        );
      },
    );
  }

  // Função chamada para restaurar o estado do widget, registrando as
  // propriedades de restauração.
  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(
      _selectedDate,
      'selected_date',
    ); // Registra a data selecionada para ser restaurada.
    registerForRestoration(
      _restorableDatePickerRouteFuture,
      'date_picker_route_future',
    ); // Registra a rota do DatePicker para ser restaurada.
  }

  // Função que é chamada quando o usuário seleciona uma nova data no DatePicker
  void _selectDate(DateTime? newSelectedDate) {
    if (newSelectedDate != null) {
      setState(() {
        _selectedDate.value = newSelectedDate;
      });
      widget.handleDate(newSelectedDate);
    }
  }

  // Método build que constrói a interface do widget.
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(right: 24, top: 5),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: colorScheme.surfaceContainer,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '${widget.isDevolucao ? 'Devolução' : 'Emprestimo'}: ${_selectedDate.value.day}/${_selectedDate.value.month}/${_selectedDate.value.year}',
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          const SizedBox(width: 14),
          SizedBox(
            height: 48,
            child: FilledButton(
              style: FilledButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(8), // Bordas arredondadas de 8px
                ),
              ),
              child: const Icon(Icons.calendar_month),
              onPressed: () {
                _restorableDatePickerRouteFuture.present();
              },
            ),
          ),
        ],
      ),
    );
  }
}
