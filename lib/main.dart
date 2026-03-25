import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isDarkMode = true;

  void _toggleTheme() {
    setState(() => _isDarkMode = !_isDarkMode);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Мой Профиль',
      theme: _isDarkMode
          ? ThemeData.dark(useMaterial3: true)
          : ThemeData.light(useMaterial3: true),
      home: const MainScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const ProfileScreen(),
    const GalleryScreen(),
    const ContactsScreen(),
    const AboutScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        selectedItemColor: Colors.deepPurpleAccent,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Профиль'),
          BottomNavigationBarItem(
              icon: Icon(Icons.photo_library), label: 'Галерея'),
          BottomNavigationBarItem(
              icon: Icon(Icons.contacts), label: 'Контакты'),
          BottomNavigationBarItem(
              icon: Icon(Icons.info_outline), label: 'О приложении'),
        ],
      ),
    );
  }
}

// ==================== ПРОФИЛЬ ====================
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int _likes = 53;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Мой профиль'),
        actions: [
          IconButton(
            icon: Icon(Theme.of(context).brightness == Brightness.dark
                ? Icons.light_mode
                : Icons.dark_mode),
            onPressed: () {
              final state = context.findAncestorStateOfType<_MyAppState>();
              state?._toggleTheme();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 20),
              CircleAvatar(
                radius: 78,
                backgroundColor: Colors.deepPurpleAccent.withOpacity(0.2),
                child: const CircleAvatar(
                  radius: 70,
                  backgroundColor: Colors.deepPurple,
                  child: Text('АД',
                      style: TextStyle(
                          fontSize: 54,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                ),
              ),
              const SizedBox(height: 24),
              const Text('Александр Дмитриев',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text('Flutter • Docker • Backend Developer',
                  style: TextStyle(
                      fontSize: 16.5,
                      color: Theme.of(context).colorScheme.secondary)),
              const SizedBox(height: 40),
              Card(
                elevation: 6,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Column(
                    children: [
                      _buildListTile(Icons.email, 'Email',
                          'aleksandrdmitriev@example.com'),
                      _buildDivider(),
                      _buildListTile(
                          Icons.phone, 'Телефон', '+7 (999) 123-45-67'),
                      _buildDivider(),
                      _buildListTile(Icons.location_on, 'Город', 'Москва'),
                      _buildDivider(),
                      _buildListTile(Icons.school, 'Университет', 'НГУЭУ'),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 40),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text('Интересы',
                    style:
                        TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: const [
                  _InterestChip(label: 'Flutter', icon: Icons.flutter_dash),
                  _InterestChip(label: 'Docker', icon: Icons.dock),
                  _InterestChip(label: 'Backend', icon: Icons.storage),
                  _InterestChip(label: 'GitHub', icon: Icons.code),
                  _InterestChip(label: 'Музыка', icon: Icons.music_note),
                  _InterestChip(label: 'Путешествия', icon: Icons.flight),
                ],
              ),
              const SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: () => setState(() => _likes++),
                    icon: const Icon(Icons.favorite),
                    label: Text('Нравится ($_likes)'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 16),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                    ),
                  ),
                  OutlinedButton.icon(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Сообщение отправлено! ✅'),
                            duration: Duration(seconds: 2)),
                      );
                    },
                    icon: const Icon(Icons.message),
                    label: const Text('Написать'),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 16),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildListTile(IconData icon, String title, String subtitle) =>
      ListTile(
        leading: Icon(icon, color: Theme.of(context).colorScheme.primary),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
        subtitle: Text(subtitle),
      );

  Widget _buildDivider() => const Divider(height: 1, indent: 20, endIndent: 20);
}

// ==================== ГАЛЕРЕЯ ====================
class GalleryScreen extends StatelessWidget {
  const GalleryScreen({super.key});

  static const List<String> images = [
    'https://picsum.photos/id/1015/600/400',
    'https://picsum.photos/id/133/600/400',
    'https://picsum.photos/id/201/600/400',
    'https://picsum.photos/id/237/600/400',
    'https://picsum.photos/id/251/600/400',
    'https://picsum.photos/id/870/600/400',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Галерея')),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          children: images
              .map((url) => ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(url,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.error)),
                  ))
              .toList(),
        ),
      ),
    );
  }
}

// ==================== КОНТАКТЫ ====================
class ContactsScreen extends StatelessWidget {
  const ContactsScreen({super.key});

  static const List<Map<String, String>> contacts = [
    {
      'name': 'Анна Смирнова',
      'phone': '+7 (901) 234-56-78',
      'role': 'Frontend Developer'
    },
    {
      'name': 'Дмитрий Ковалёв',
      'phone': '+7 (905) 111-22-33',
      'role': 'DevOps Engineer'
    },
    {
      'name': 'Екатерина Морозова',
      'phone': '+7 (999) 555-44-33',
      'role': 'UI/UX Designer'
    },
    {
      'name': 'Максим Орлов',
      'phone': '+7 (912) 777-88-99',
      'role': 'Backend Developer'
    },
    {
      'name': 'Ольга Петрова',
      'phone': '+7 (903) 222-11-00',
      'role': 'Project Manager'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Контакты')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          final c = contacts[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: CircleAvatar(
                  backgroundColor: Colors.deepPurpleAccent,
                  child: Text(c['name']![0])),
              title: Text(c['name']!),
              subtitle: Text(c['role']!),
              trailing: Text(c['phone']!, style: const TextStyle(fontSize: 13)),
            ),
          );
        },
      ),
    );
  }
}

// ==================== О ПРИЛОЖЕНИИ ====================
class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('О приложении')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Profile App',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
            const Text('Версия 1.0.0',
                style: TextStyle(fontSize: 18, color: Colors.grey)),
            const SizedBox(height: 30),
            const Text(
              'Учебное приложение, созданное в рамках лабораторной работы №2 по Flutter.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 40),
            const Text('Использованные виджеты:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            ...[
              'BottomNavigationBar + 4 вкладки',
              'Material 3 Design',
              'StatefulWidget + setState',
              'Переключение тёмной/светлой темы',
              'GridView + Image.network',
              'ListView.builder',
              'Card, ListTile, CircleAvatar',
              'SnackBar и Navigator',
            ].map((item) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    children: [
                      const Icon(Icons.check_circle,
                          color: Colors.green, size: 22),
                      const SizedBox(width: 12),
                      Text(item, style: const TextStyle(fontSize: 16)),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}

// Чип для интересов
class _InterestChip extends StatelessWidget {
  final String label;
  final IconData icon;

  const _InterestChip({required this.label, required this.icon, super.key});

  @override
  Widget build(BuildContext context) {
    return Chip(
      avatar: Icon(icon, size: 18),
      label: Text(label),
      backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
      side: BorderSide.none,
    );
  }
}
