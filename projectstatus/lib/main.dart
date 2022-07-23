import 'dart:developer';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:flutter/services.dart';
import 'metric_model.dart';

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
      home: MyHomePage(title: 'Flutter Demo Home Page', metricList: [],),
    );
  }
}

class MyHomePage extends StatefulWidget {
  List<MetricModel> metricList;
  MyHomePage({Key? key, required String title, required this.metricList}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> descriptions = [
        "The number of defects are well below where expected",
        "The number of defects are about where we expect",
        "The number of defects are slightly above what is expected",
        "The number of defects greatly exceed expectations"
      ];
  List<int> votes = [1, 4, 8, 10];
  late MetricModel defaultMetric;
  late MetricModel a;
  late MetricModel b;
  late MetricModel c;
  @override
    void initState(){
      super.initState();
      a = new MetricModel(projectGoal: "Total Number Of Defects", desc: descriptions,votes: votes );
      b = new MetricModel(projectGoal: "Schedule Feasibility", desc: descriptions,votes: votes );
      c = new MetricModel(projectGoal: "Design Progress", desc: descriptions,votes: votes );
      defaultMetric = new MetricModel(projectGoal: "DEFAULT", desc: descriptions,votes: votes );
      widget.metricList = [a,b,c];
      print("INASDIASNDIANSDIA");
    }

  @override
  Widget build(BuildContext context) {
    
      List<MetricModel> list = [a,b,c];
      
    return Scaffold(
        appBar: AppBar(
          title: Text("Project Status Indicator"),
        ),
        body: (
           Column(
            children: [
              TextButton(
                style: ButtonStyle(
                  overlayColor: MaterialStateProperty.resolveWith<Color?>(
                    (Set<MaterialState> states) {
                      if (states.contains(MaterialState.focused))
                        return Colors.red;
                      return null; // Defer to the widget's default.
                    }
                  ),
                ),
                onPressed: () => setState(() => {print(widget.metricList), widget.metricList.add(defaultMetric), print(widget.metricList)}),
                child: Text('ADD ME DAD'),
              ),
              Expanded(
              child: 
              ListView.builder(
                itemCount: widget.metricList.length,
                itemBuilder: (context, index){
                  return goalContainer(metric: widget.metricList[index]);
                }
                )
              ),
              
              //for (int i = 0; i < metricList.length; i++) goalContainer(metric: metricList[i]),
            ],
          )
        ));
  }
}

class goalContainer extends StatefulWidget {
  MetricModel metric;
  goalContainer({Key? key, required this.metric}) : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: (MediaQuery.of(context).size.width) * 0.55,
        child: GFAccordion(
          collapsedIcon: const Icon(Icons.arrow_left_rounded),
          expandedIcon: Transform.rotate(
              angle: -90 * pi / 180,
              child: const Icon(Icons.arrow_left_rounded)),
          titleChild: Row(
            children: [
              Expanded(
                flex: 45,
                child: SizedBox(
                  child: TextFormField(
                    initialValue: widget.metric.projectGoal,
                    enabled: false,
                    decoration: const InputDecoration(
                      labelText: "Project Goal",
                    ),
                  ),
                ),
              ),
              const Expanded(
                flex: 25,
                child: SizedBox(),
              ),
              const Expanded(
                flex: 15,
                child: SizedBox(child: Text("Metric Status")),
              ),
              Expanded(
                flex: 15,
                child: SizedBox(
                  child: Icon(
                    Icons.circle,
                    color: getStatusColor(widget.metric.votes),
                    size: 50,
                  ),
                ),
              ),
            ],
          ),
          contentChild: SingleChildScrollView(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                for (int i = 0; i < 4; i++)
                  SubGoalContainer(
                      index: i,
                      description: widget.metric.desc[i],
                      riskLevel: riskLevels[i],
                      voteCount: widget.metric.votes[i])
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SubGoalContainer extends StatefulWidget {
  int index;
  String riskLevel;
  String description;
  int voteCount;
  SubGoalContainer(
      {Key? key,
      required this.index,
      required this.description,
      required this.riskLevel,
      required this.voteCount})
      : super(key: key);

  @override
  State<SubGoalContainer> createState() => _SubGoalContainerState();
}

class _SubGoalContainerState extends State<SubGoalContainer> {
  TextEditingController desc = TextEditingController();
  TextEditingController votes = TextEditingController();

  void updateFieldValue() {
    setState(() {
      widget.description = desc.text;
      widget.voteCount = int.parse(votes.text);
    });
  }

  @override
  void initState() {
    super.initState();
    votes = TextEditingController(text: "${widget.voteCount}");
    votes.addListener(updateFieldValue);

    desc = TextEditingController(text: widget.description);
    desc.addListener(updateFieldValue);
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
                initialValue: widget.riskLevel,
                enabled: false,
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
              controller: desc,
              decoration: const InputDecoration(
                labelText: "Description",
              ),
            )),
          ),
          Expanded(
              flex: 10,
              child: SizedBox(
                child: TextFormField(
                  controller: votes,
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

Color getStatusColor(List<int> voteList) {
  Color statusColor;
  int totalVotes = 0;
  double riskLevel = 0;

  for (int i = 0; i < voteList.length; i++) {
    switch (i) {
      case 0:
        totalVotes += voteList[i];
        break;
      case 1:
        totalVotes += voteList[i];
        riskLevel += voteList[i] / 3;
        break;
      case 2:
        totalVotes += voteList[i];
        riskLevel += voteList[i] * 2 / 3;
        break;
      case 3:
        totalVotes += voteList[i];
        riskLevel += voteList[i] / 3;
        break;
    }
  }
  riskLevel = riskLevel / totalVotes;
  if (riskLevel < 1 / 3) {
    statusColor = Colors.green;
  } else if (riskLevel > 2 / 3) {
    statusColor = Colors.red;
  } else {
    statusColor = Colors.yellow;
  }
  return statusColor;
}
