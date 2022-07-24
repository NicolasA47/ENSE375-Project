import 'dart:developer';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:flutter/services.dart';
import 'metric_model.dart';

late List<MetricModel> metricList;
Color? totalRiskColor;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Risk Management',
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
        primarySwatch: Colors.blueGrey,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page',),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required String title,}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  updateState(){
    setState(() {
      
    });
  }
  @override
    void initState(){
      super.initState();
      metricList = [
        MetricModel(projectGoal: "Total Number Of Defects", desc: <String>[
          "The number of defects are well below where expected",
          "The number of defects are about where we expect",
          "The number of defects are slightly above what is expected",
          "The number of defects greatly exceed expectations"], 
          votes: <int>[3,4,8,9]),
        MetricModel(projectGoal: "Schedule feasibility", desc: <String>[
          "The project can be easily completed in the scheduled time",
          "The project can be completed in the scheduled time with strict time management",
          "The project may be completed in the scheduled time, but will require crunch",
          "The project is unlikely to be completed in the scheduled time"], 
          votes: <int>[7,8,7,2]),
          MetricModel(projectGoal: "Design progress", desc: <String>[
          "The design is complete",
          "The design is mostly complete and no major problems are noted",
          "The design is incomplete and one major problem is noted with strategies to mitigate",
          "The design is incomplete, has several major problems with no plans to mitigate"], 
          votes: <int>[11,6,6,1]),
          MetricModel(projectGoal: "Implementation progress", desc: <String>[
          "The implementation is ahead of schedule",
          "The implementation is on schedule",
          "The implementation is slightly behind schedule",
          "The implementation is far behind schedule"], 
          votes: <int>[5,6,5,6]),
          MetricModel(projectGoal: "Integration progress", desc: <String>[
          "No major integration problems have been detected",
          "Minor integration problems have been detected",
          "At least one major integration problem has been detected, with plans to remedy",
          "Multiple major integration problems have been detected, with no plans to remedy"], 
          votes: <int>[9,8,7,0])
        ];
    }

  @override
  Widget build(BuildContext context) {
      
    return Scaffold(
        appBar: AppBar(
          title: const Text("Risk Management"),
        ),
        body: (
           Column(
            children: [
              Row(children: [
              const SizedBox(child: Text("Metric Status")),
              Expanded(
                flex: 15,
                child: SizedBox(
                  child: Icon(
                    Icons.circle,
                    color: totalRiskColor = totalRisk(),
                    size: 50,
                  ),
                ),
              ),
              TextButton(
                style: ButtonStyle(
                  overlayColor: MaterialStateProperty.resolveWith<Color?>(
                    (Set<MaterialState> states) {
                      if (states.contains(MaterialState.focused)) {
                        return Colors.red;
                      }
                      return null; // Defer to the widget's default.
                    }
                  ),
                ),
                onPressed: (() => { metricList.add(MetricModel(projectGoal: "Default Project Goal", desc: ["Default","Default","Default","Default"], votes: [0,0,0,0],statusColor: Color(0xFF388E3C))), updateState()}),
                child: const Text('ADD GOAL'),
              ),
              ],),
              Expanded(
              child: 
              ListView.builder(
                itemCount: metricList.length,
                itemBuilder: (context, index){
                  return Card(
                    child: Column(children: [
                      goalContainer(updateParent: updateState,metricIndex: index, metric: metricList[index], metricList: metricList),
                      //deleteButton(metricList[index])
                    ],),
                  );
                }
                )
              ),
              
            ],
          )
        ));
  }

  Widget deleteButton(MetricModel metric){
    return TextButton(
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.focused)) {
              return Colors.red;
            }
            return null; // Defer to the widget's default.
          }
        ),
      ),
      onPressed: () => setState(() => {metricList.remove(metric), updateState()}),
      child: const Text('DELETE'),
    );
  }
}

class goalContainer extends StatefulWidget {
  Function updateParent;
  int metricIndex;
  MetricModel metric;
  List<MetricModel> metricList;
  goalContainer({Key? key,required this.updateParent(),required this.metricIndex, required this.metric, required this.metricList}) : super(key: key);

  @override
  State<goalContainer> createState() => _goalContainerState();
}

class _goalContainerState extends State<goalContainer> {
  TextEditingController projectGoalName = TextEditingController();
  void updateFieldValue() {
      setState(() {
        widget.metric.projectGoal = projectGoalName.text;
      });
    }

  @override
  void initState() {
    super.initState();
    projectGoalName = TextEditingController(text: widget.metric.projectGoal);
    
  }

  updateState(){
    setState(() {
      
    });
    widget.updateParent();
  }

  @override
  Widget build(BuildContext context) {
  widget.metric.statusColor = getStatusColor(widget.metric.votes);
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
                    controller: projectGoalName,
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
                    color: widget.metric.statusColor,
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
                      metricIndex: widget.metricIndex,
                      index: i,
                      description: widget.metric.desc[i],
                      voteCount: widget.metric.votes[i],
                      updateParent: updateState,)
              ],
            ),
          ),
        ),
      ),
    );
  }

  
}

class SubGoalContainer extends StatefulWidget {
  int metricIndex;
  int index;
  String description;
  int voteCount;
  Function updateParent;
  SubGoalContainer(
      {Key? key,
      required this.metricIndex,
      required this.index,
      required this.description,
      required this.voteCount,
      required this.updateParent()})
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
      metricList.elementAt(widget.metricIndex).votes[widget.index] = widget.voteCount;
      metricList.elementAt(widget.metricIndex).desc[widget.index] = widget.description;
      metricList.elementAt(widget.metricIndex).statusColor = getStatusColor(metricList.elementAt(widget.metricIndex).votes);
      totalRiskColor = totalRisk();
      widget.updateParent();
      print(metricList.elementAt(widget.metricIndex).statusColor);
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
      child:
      Row(
        children: [
          Expanded(
            flex: 65,
            child: SizedBox(
                child: TextFormField(
              controller: desc,
              decoration: const InputDecoration(
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
        riskLevel += voteList[i];
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

Color totalRisk(){
  double totalRisk = 0;
  for (int i = 0; i < metricList.length; i++){
    totalRisk += calculateRisk(metricList[i].votes);
  }
  totalRisk /= metricList.length;
  Color statusColor;
  if (totalRisk < 1 / 3) {
    statusColor = Colors.green;
  } else if (totalRisk > 2 / 3) {
    statusColor = Colors.red;
  } else {
    statusColor = Colors.yellow;
  }
  return statusColor;
}

double calculateRisk(List<int> voteList){
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
        riskLevel += voteList[i];
        break;
    }
  }
  riskLevel = riskLevel / totalVotes;
  return riskLevel;
}