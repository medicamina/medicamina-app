import 'package:flutter/material.dart';

class MedicaminaDashConsultationPage extends StatefulWidget {
  const MedicaminaDashConsultationPage({Key? key}) : super(key: key);

  @override
  State<MedicaminaDashConsultationPage> createState() => _MedicaminaDashConsultationPageState();
}

class _MedicaminaDashConsultationPageState extends State<MedicaminaDashConsultationPage> {
  @override
  Widget build(BuildContext context) {
    return Column(children: const [
      SizedBox(height: 48),
      Text('Book an appointment with a doctor'),
      SizedBox(height: 48),
      CircularProgressIndicator()
    ],);
  }
}