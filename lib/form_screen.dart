import 'package:flutter/material.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final _formKey = GlobalKey<FormState>();
  final nameCtrl = TextEditingController();
  final ageCtrl = TextEditingController();
  final heightCtrl = TextEditingController();
  final weightCtrl = TextEditingController();

  void _apply() {
    if (_formKey.currentState!.validate()) {
      Navigator.pop(context, {
        'name': nameCtrl.text,
        'age': int.parse(ageCtrl.text),
        'height': double.parse(heightCtrl.text),
        'weight': double.parse(weightCtrl.text),
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Анкета'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: CircleAvatar(
              radius: 20,
              backgroundImage: const AssetImage('assets/me.png'),
            ),
          ),
        ],
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset('assets/fon.png', fit: BoxFit.cover),
          Container(color: Colors.black.withOpacity(0.4)),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  TextFormField(
                    controller: nameCtrl,
                    decoration: const InputDecoration(
                      labelText: 'Имя',
                      filled: true,
                      fillColor: Colors.white70,
                    ),
                    validator: (v) =>
                    v == null || v.isEmpty ? 'Введите имя' : null,
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: ageCtrl,
                    decoration: const InputDecoration(
                      labelText: 'Возраст',
                      filled: true,
                      fillColor: Colors.white70,
                    ),
                    keyboardType: TextInputType.number,
                    validator: (v) =>
                    v == null || v.isEmpty ? 'Введите возраст' : null,
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: heightCtrl,
                    decoration: const InputDecoration(
                      labelText: 'Рост (см)',
                      filled: true,
                      fillColor: Colors.white70,
                    ),
                    keyboardType: TextInputType.number,
                    validator: (v) =>
                    v == null || v.isEmpty ? 'Введите рост' : null,
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: weightCtrl,
                    decoration: const InputDecoration(
                      labelText: 'Вес (кг)',
                      filled: true,
                      fillColor: Colors.white70,
                    ),
                    keyboardType: TextInputType.number,
                    validator: (v) =>
                    v == null || v.isEmpty ? 'Введите вес' : null,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _apply,
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        padding:
                        const EdgeInsets.symmetric(vertical: 14)),
                    child: const Text('Применить',
                        style: TextStyle(fontSize: 16)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
