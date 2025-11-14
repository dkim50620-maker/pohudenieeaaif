import 'package:flutter/material.dart';
import 'dart:math';
import 'package:shared_preferences/shared_preferences.dart';
import 'form_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? name;
  int? age;
  double? height;
  double? weight;
  String? advice;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString('name');
      age = prefs.getInt('age');
      height = prefs.getDouble('height') ?? prefs.getInt('height')?.toDouble();
      weight = prefs.getDouble('weight') ?? prefs.getInt('weight')?.toDouble();
    });
    if (name != null && age != null && height != null && weight != null) {
      _generateAdvice();
    }
  }

  Future<void> _saveData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', name ?? '');
    await prefs.setInt('age', age ?? 0);
    await prefs.setDouble('height', height ?? 0.0);
    await prefs.setDouble('weight', weight ?? 0.0);
  }

  // Новая функция: сброс всех данных профиля
  Future<void> _resetProfile() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('name');
    await prefs.remove('age');
    await prefs.remove('height');
    await prefs.remove('weight');
    setState(() {
      name = null;
      age = null;
      height = null;
      weight = null;
      advice = null;
    });
  }

  void _generateAdvice() {
    if (height == null || weight == null || age == null) return;

    double bmi = weight! / ((height! / 100) * (height! / 100));
    int calories = 2000 + Random().nextInt(600) - 300;

    List<String> workouts = [
      "Ходи пешком не менее 8 000 шагов в день.",
      "Добавь 3 тренировки по 30 минут в неделю.",
      "Попробуй лёгкое кардио утром и растяжку вечером.",
      "Пей больше воды — не менее 1.5 литров в день.",
      "Старайся спать 7–8 часов для восстановления."
    ];

    List<String> foods = [
      "Уменьши сахар и быстрые углеводы.",
      "Добавь больше белка (мясо, рыба, яйца, бобовые).",
      "Старайся есть овощи в каждом приёме пищи.",
      "Не пропускай завтрак — это важно для обмена веществ.",
      "Ограничь фастфуд и газированные напитки."
    ];

    String workout = workouts[Random().nextInt(workouts.length)];
    String food = foods[Random().nextInt(foods.length)];

    setState(() {
      advice =
      "Твой ИМТ: ${bmi.toStringAsFixed(1)}\n\n"
          "Рекомендуемая калорийность: ~${calories} ккал/день\n\n"
          "🏋️ Советы по активности:\n$workout\n\n"
          "🥗 Советы по питанию:\n$food";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Похудение AI'),
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
            padding: const EdgeInsets.all(20),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (name == null || name!.isEmpty)
                      const Text(
                        'Добро пожаловать!',
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      )
                    else
                      Column(
                        children: [
                          Text(
                            'Привет, $name!',
                            style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Возраст: $age лет\nРост: ${height?.toStringAsFixed(0)} см\nВес: ${weight?.toStringAsFixed(1)} кг',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 16, color: Colors.white70),
                          ),
                        ],
                      ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () async {
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const FormScreen()),
                        );
                        if (result != null && result is Map<String, dynamic>) {
                          setState(() {
                            name = result['name'];
                            age = result['age'];
                            height = result['height'];
                            weight = result['weight'];
                          });
                          await _saveData();
                          _generateAdvice();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 14),
                      ),
                      child: Text(
                        name == null || name!.isEmpty
                            ? 'Заполнить анкету'
                            : 'Изменить данные',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: _resetProfile,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 14),
                      ),
                      child: const Text(
                        'Сбросить данные профиля',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    const SizedBox(height: 20),
                    if (advice != null)
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.85),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          advice!,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

