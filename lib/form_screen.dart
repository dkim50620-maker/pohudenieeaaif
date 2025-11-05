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
      appBar: AppBar(title: const Text('Анкета')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: nameCtrl,
                decoration: const InputDecoration(labelText: 'Имя'),
                validator: (v) => v == null || v.isEmpty ? 'Введите имя' : null,
              ),
              TextFormField(
                controller: ageCtrl,
                decoration: const InputDecoration(labelText: 'Возраст'),
                keyboardType: TextInputType.number,
                validator: (v) => v == null || v.isEmpty ? 'Введите возраст' : null,
              ),
              TextFormField(
                controller: heightCtrl,
                decoration: const InputDecoration(labelText: 'Рост (см)'),
                keyboardType: TextInputType.number,
                validator: (v) => v == null || v.isEmpty ? 'Введите рост' : null,
              ),
              TextFormField(
                controller: weightCtrl,
                decoration: const InputDecoration(labelText: 'Вес (кг)'),
                keyboardType: TextInputType.number,
                validator: (v) => v == null || v.isEmpty ? 'Введите вес' : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _apply,
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14)),
                child: const Text('Применить', style: TextStyle(fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
