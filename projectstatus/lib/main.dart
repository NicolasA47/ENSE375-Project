import 'dart:html';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Project Status Indicator',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.deepOrange,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Project Status Indicator"),
      ),
      body: goalContainer(),
    );
  }
}

class goalContainer extends StatefulWidget {
  const goalContainer({Key? key}) : super(key: key);

  @override
  State<goalContainer> createState() => _goalContainerState();
}

class _goalContainerState extends State<goalContainer> {
  List<String> riskLevels = [
    "Mininmal Risk",
    "Low Risk",
    "Reasonable Risk",
    "High Risk"
  ];
  List<String> descriptions = [
    "The number of defects are well below where expected",
    "The number of defects are about where we expect",
    "The number of defects are slightly above what is expected",
    "The number of defects greatly exceed expectations"
  ];
  List<int> votes = [0, 0, 0, 0];
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: (MediaQuery.of(context).size.width) * 0.55,
        child: GFAccordion(
          title: 'Project goal',
          collapsedIcon: const Icon(Icons.arrow_left_rounded),
          expandedIcon: Transform.rotate(
              angle: -90 * pi / 180,
              child: const Icon(Icons.arrow_left_rounded)),
          contentChild: SingleChildScrollView(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                for (int i = 0; i < 4; i++) SubGoalContainer(index: i)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SubGoalContainer extends StatefulWidget {
  final int index;
  const SubGoalContainer({Key? key, required this.index}) : super(key: key);

  @override
  State<SubGoalContainer> createState() => _SubGoalContainerState();
}

class _SubGoalContainerState extends State<SubGoalContainer> {
  TextEditingController voteCount = TextEditingController(text: "0");
  List<String> riskLevels = [
    "Mininmal Risk",
    "Low Risk",
    "Reasonable Risk",
    "High Risk"
  ];
  List<String> descriptions = [
    "The number of defects are well below where expected",
    "The number of defects are about where we expect",
    "The number of defects are slightly above what is expected",
    "The number of defects greatly exceed expectations"
  ];
  void updateFieldValue() {
    setState(() {
      print(voteCount.text);
    });
  }

  @override
  void initState() {
    super.initState();
    voteCount = TextEditingController(text: "0");
    voteCount.addListener(updateFieldValue);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        children: [
          Expanded(
            flex: 25,
            child: SizedBox(
              child: TextFormField(
                initialValue: riskLevels[widget.index],
                decoration: const InputDecoration(
                  labelText: "Risk Level",
                ),
              ),
            ),
          ),
          Expanded(
            flex: 65,
            child: SizedBox(
                child: TextFormField(
              initialValue: descriptions[widget.index],
              decoration: const InputDecoration(
                labelText: "Description",
              ),
            )),
          ),
          Expanded(
              flex: 10,
              child: SizedBox(
                child: TextFormField(
                  controller: voteCount,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.person_outline_rounded),
                    labelText: "Votes",
                  ),
                ),
              )),
        ],
      ),
    );
  }
}

Color getStatusColor(int riskLevel) {
  Color statusColor;
  if (riskLevel < 1 / 3) {
    statusColor = Colors.green;
  } else if (riskLevel > 2 / 3) {
    statusColor = Colors.red;
  } else {
    statusColor = Colors.yellow;
  }
  return statusColor;
}
