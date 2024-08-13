import 'package:flutter/material.dart';

class BirdthdayPickerWidget extends StatefulWidget {
  final TextEditingController birdthdayCtrl;
  const BirdthdayPickerWidget({super.key, required this.birdthdayCtrl});

  @override
  State<BirdthdayPickerWidget> createState() => _BirdthdayPickerWidgetState();
}

class _BirdthdayPickerWidgetState extends State<BirdthdayPickerWidget> {
  DateTime? selectedDateTime;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDateTime ?? DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      // final TimeOfDay? pickedTime = await showTimePicker(
      //   context: context,
      //   initialTime: selectedDateTime != null
      //       ? TimeOfDay(
      //           hour: selectedDateTime!.hour, minute: selectedDateTime!.minute)
      //       : TimeOfDay.now(),
      // );

      // if (pickedTime != null) {
      setState(() {
        selectedDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          // pickedTime.hour,
          // pickedTime.minute,
        );

        widget.birdthdayCtrl.text = selectedDateTime.toString().split(' ')[0];
      });
      // }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () => _selectDate(context),
            child: const Text('Seleccione fecha'),
          ),
          const SizedBox(height: 20),
          Text(
            selectedDateTime != null
                ? 'Fecha: ${selectedDateTime!.toLocal().toString().split(' ')[0]}'
                : 'Sin seleccionar',
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
