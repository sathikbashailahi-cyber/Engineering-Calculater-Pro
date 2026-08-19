import 'package:flutter/material.dart';

void main() {
  runApp(const EngineeringCalculatorPro());
}

class EngineeringCalculatorPro extends StatelessWidget {
  const EngineeringCalculatorPro({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ILAHI FABRICATORS Engineering Calculator Pro',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blueGrey,
        ),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  final List<Map<String, dynamic>> modules = const [
    {'title': 'Pipe Weight', 'icon': Icons.linear_scale},
    {'title': 'Plate Weight', 'icon': Icons.layers},
    {'title': 'Structural', 'icon': Icons.account_tree},
    {'title': 'Tank Calculator', 'icon': Icons.local_drink},
    {'title': 'Labour', 'icon': Icons.engineering},
    {'title': 'Salary & OT', 'icon': Icons.payments},
    {'title': 'Material Stock', 'icon': Icons.inventory_2},
    {'title': 'Quotation', 'icon': Icons.request_quote},
    {'title': 'GST Invoice', 'icon': Icons.receipt_long},
    {'title': 'Profit & Loss', 'icon': Icons.analytics},
    {'title': 'Reports', 'icon': Icons.description},
    {'title': 'Settings', 'icon': Icons.settings},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Engineering Calculator Pro',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            margin: const EdgeInsets.all(12),
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              gradient: const LinearGradient(
                colors: [
                  Color(0xFF263238),
                  Color(0xFF546E7A),
                ],
              ),
            ),
            child: const Column(
              children: [
                Text(
                  'ILAHI FABRICATORS',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'Engineering Calculator Pro',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Version 1.0',
                  style: TextStyle(
                    color: Colors.white60,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: modules.length,
              gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.9,
              ),
              itemBuilder: (context, index) {
                final module = modules[index];

                return Card(
                  elevation: 3,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            '${module['title']} - Coming Soon',
                          ),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            module['icon'],
                            size: 34,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            module['title'],
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
