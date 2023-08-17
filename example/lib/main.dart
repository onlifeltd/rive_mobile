import 'package:flutter/material.dart';
import 'package:rive_mobile/rive_animation_view.dart';

void main() => runApp(const MaterialApp(home: ExampleApp()));

class ExampleApp extends StatefulWidget {
  const ExampleApp({Key? key}) : super(key: key);

  @override
  State<ExampleApp> createState() => _ExampleAppState();
}

class _ExampleAppState extends State<ExampleApp> {
  late final TextEditingController _assetPathController;

  String assetPath = 'assets/coyote.riv';

  @override
  void initState() {
    _assetPathController = TextEditingController(text: 'assets/vehicles.riv');
    super.initState();
  }

  @override
  void dispose() {
    _assetPathController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Rive example')),
      body: Column(
        children: [
          TextFormField(
            controller: _assetPathController,
          ),
          ElevatedButton(
            onPressed: () => setState(() {
              assetPath = _assetPathController.text;
            }),
            child: const Text('Load Rive asset'),
          ),
          SizedBox(
            height: 200,
            width: 300,
            child: RiveAnimation.asset(
              assetPath,
              fit: BoxFit.fill,
            ),
          ),
          SizedBox(
            height: 200,
            width: 300,
            child: RiveAnimation.asset(
              assetPath,
              fit: BoxFit.fitHeight,
            ),
          ),
        ],
      ),
    );
  }
}
