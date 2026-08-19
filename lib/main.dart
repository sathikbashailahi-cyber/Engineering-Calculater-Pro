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
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final modules = [
      ['Pipe Weight', Icons.settings, const PipeWeightPage()],
      ['Plate Weight', Icons.crop_square, const PlateWeightPage()],
      ['Structural Weight', Icons.account_tree, const StructuralPage()],
      ['Tank Calculator', Icons.water_drop, const TankPage()],
      ['Labour', Icons.groups, const LabourPage()],
      ['Salary & OT', Icons.payments, const SalaryPage()],
      ['Material Stock', Icons.inventory_2, const StockPage()],
      ['Quotation', Icons.request_quote, const QuotationPage()],
      ['GST Invoice', Icons.receipt_long, const InvoicePage()],
      ['Profit & Loss', Icons.analytics, const ProfitPage()],
      ['Reports', Icons.summarize, const ReportsPage()],
      ['Settings', Icons.settings, const SettingsPage()],
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ILAHI FABRICATORS',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(12),
            child: Text(
              'Engineering Calculator Pro',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: modules.length,
              gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 1.15,
              ),
              itemBuilder: (context, index) {
                final module = modules[index];

                return Card(
                  elevation: 3,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => module[2] as Widget,
                        ),
                      );
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          module[1] as IconData,
                          size: 42,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          module[0] as String,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
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

// ---------------- COMMON CALCULATOR PAGE ----------------

class CalculatorPage extends StatefulWidget {
  final String title;
  final List<String> fields;
  final String Function(List<double>) calculate;

  const CalculatorPage({
    super.key,
    required this.title,
    required this.fields,
    required this.calculate,
  });

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  late List<TextEditingController> controllers;
  String result = '';

  @override
  void initState() {
    super.initState();
    controllers =
        List.generate(widget.fields.length, (_) => TextEditingController());
  }

  @override
  void dispose() {
    for (final controller in controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  double value(int index) {
    return double.tryParse(controllers[index].text) ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          for (int i = 0; i < widget.fields.length; i++)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: TextField(
                controller: controllers[i],
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  labelText: widget.fields[i],
                  border: const OutlineInputBorder(),
                ),
              ),
            ),
          FilledButton.icon(
            onPressed: () {
              setState(() {
                result = widget.calculate(
                  List.generate(
                    controllers.length,
                    value,
                  ),
                );
              });
            },
            icon: const Icon(Icons.calculate),
            label: const Text('CALCULATE'),
          ),
          if (result.isNotEmpty)
            Card(
              margin: const EdgeInsets.only(top: 20),
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Text(
                  result,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// ---------------- PIPE WEIGHT ----------------

class PipeWeightPage extends StatelessWidget {
  const PipeWeightPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CalculatorPage(
      title: 'Pipe Weight',
      fields: [
        'Outside Diameter (mm)',
        'Thickness (mm)',
        'Length (m)',
      ],
      calculate: (v) {
        final d = v[0];
        final t = v[1];
        final length = v[2];

        final kgPerMeter = 0.02466 * t * (d - t);
        final total = kgPerMeter * length;

        return 'Weight / Meter: ${kgPerMeter.toStringAsFixed(2)} kg\n'
            'Total Weight: ${total.toStringAsFixed(2)} kg';
      },
    );
  }
}

// ---------------- PLATE WEIGHT ----------------

class PlateWeightPage extends StatelessWidget {
  const PlateWeightPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CalculatorPage(
      title: 'Plate Weight',
      fields: [
        'Length (mm)',
        'Width (mm)',
        'Thickness (mm)',
      ],
      calculate: (v) {
        final weight = v[0] * v[1] * v[2] * 7.85 / 1000000;

        return 'Plate Weight: ${weight.toStringAsFixed(2)} kg';
      },
    );
  }
}

// ---------------- STRUCTURAL ----------------

class StructuralPage extends StatelessWidget {
  const StructuralPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CalculatorPage(
      title: 'Structural Weight',
      fields: [
        'Unit Weight (kg/m)',
        'Length (m)',
        'Quantity',
      ],
      calculate: (v) {
        final total = v[0] * v[1] * v[2];

        return 'Total Weight: ${total.toStringAsFixed(2)} kg';
      },
    );
  }
}

// ---------------- TANK ----------------

class TankPage extends StatelessWidget {
  const TankPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CalculatorPage(
      title: 'Tank Calculator',
      fields: [
        'Tank Diameter (m)',
        'Shell Height (m)',
        'Thickness (mm)',
      ],
      calculate: (v) {
        final diameter = v[0];
        final height = v[1];
        final thickness = v[2];

        final area = 3.1415926535 * diameter * height;
        final weight = area * thickness * 7.85;

        return 'Shell Area: ${area.toStringAsFixed(2)} m²\n'
            'Approx. Shell Weight: ${weight.toStringAsFixed(2)} kg';
      },
    );
  }
}

// ---------------- LABOUR ----------------

class LabourPage extends StatelessWidget {
  const LabourPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CalculatorPage(
      title: 'Labour Cost',
      fields: [
        'Number of Workers',
        'Working Days',
        'Rate / Day',
      ],
      calculate: (v) {
        final total = v[0] * v[1] * v[2];

        return 'Total Labour Cost: ₹${total.toStringAsFixed(2)}';
      },
    );
  }
}

// ---------------- SALARY & OT ----------------

class SalaryPage extends StatelessWidget {
  const SalaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CalculatorPage(
      title: 'Salary & OT',
      fields: [
        'Monthly Salary',
        'OT Hours',
        'OT Rate / Hour',
      ],
      calculate: (v) {
        final ot = v[1] * v[2];
        final total = v[0] + ot;

        return 'OT Amount: ₹${ot.toStringAsFixed(2)}\n'
            'Total Salary: ₹${total.toStringAsFixed(2)}';
      },
    );
  }
}

// ---------------- STOCK ----------------

class StockPage extends StatelessWidget {
  const StockPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CalculatorPage(
      title: 'Material Stock',
      fields: [
        'Opening Quantity',
        'Received Quantity',
        'Issued Quantity',
      ],
      calculate: (v) {
        final balance = v[0] + v[1] - v[2];

        return 'Available Stock: ${balance.toStringAsFixed(2)}';
      },
    );
  }
}

// ---------------- QUOTATION ----------------

class QuotationPage extends StatelessWidget {
  const QuotationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CalculatorPage(
      title: 'Quotation',
      fields: [
        'Material Cost',
        'Labour Cost',
        'Other Charges',
      ],
      calculate: (v) {
        final total = v[0] + v[1] + v[2];

        return 'Quotation Subtotal: ₹${total.toStringAsFixed(2)}';
      },
    );
  }
}

// ---------------- GST INVOICE ----------------

class InvoicePage extends StatelessWidget {
  const InvoicePage({super.key});

  @override
  Widget build(BuildContext context) {
    return CalculatorPage(
      title: 'GST Invoice',
      fields: [
        'Subtotal',
        'GST %',
        'Discount',
      ],
      calculate: (v) {
        final taxable = v[0] - v[2];
        final gst = taxable * v[1] / 100;
        final total = taxable + gst;

        return 'Taxable Amount: ₹${taxable.toStringAsFixed(2)}\n'
            'GST: ₹${gst.toStringAsFixed(2)}\n'
            'Invoice Total: ₹${total.toStringAsFixed(2)}';
      },
    );
  }
}

// ---------------- PROFIT & LOSS ----------------

class ProfitPage extends StatelessWidget {
  const ProfitPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CalculatorPage(
      title: 'Profit & Loss',
      fields: [
        'Sales',
        'Material Cost',
        'Labour + Other Cost',
      ],
      calculate: (v) {
        final cost = v[1] + v[2];
        final profit = v[0] - cost;
        final margin = v[0] == 0 ? 0 : profit / v[0] * 100;

        return 'Profit / Loss: ₹${profit.toStringAsFixed(2)}\n'
            'Margin: ${margin.toStringAsFixed(2)}%';
      },
    );
  }
}

// ---------------- REPORTS ----------------

class ReportsPage extends StatelessWidget {
  const ReportsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reports'),
      ),
      body: const Center(
        child: Text(
          'Engineering Reports\n\n'
          'Calculator modules are active.\n'
          'Detailed report database can be added next.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}

// ---------------- SETTINGS ----------------

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: const ListTile(
        leading: Icon(Icons.business),
        title: Text('ILAHI FABRICATORS'),
        subtitle: Text(
          'Engineering Calculator Pro\nVersion 1.0',
        ),
      ),
    );
  }
}

