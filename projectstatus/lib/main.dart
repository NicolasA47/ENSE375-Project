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
      home: MyHomePage(
        title: 'Flutter Demo Home Page',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({
    Key? key,
    required String title,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  updateState() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    metricList = [
      MetricModel(projectGoal: "Total Number Of Defects", desc: <String>[
        "The number of defects are well below where expected",
        "The number of defects are about where we expect",
        "The number of defects are slightly above what is expected",
        "The number of defects greatly exceed expectations"
      ], votes: <int>[
        3,
        4,
        8,
        9
      ]),
      MetricModel(projectGoal: "Schedule feasibility", desc: <String>[
        "The project can be easily completed in the scheduled time",
        "The project can be completed in the scheduled time with strict time management",
        "The project may be completed in the scheduled time, but will require crunch",
        "The project is unlikely to be completed in the scheduled time"
      ], votes: <int>[
        7,
        8,
        7,
        2
      ]),
      MetricModel(projectGoal: "Design progress", desc: <String>[
        "The design is complete",
        "The design is mostly complete and no major problems are noted",
        "The design is incomplete and one major problem is noted with strategies to mitigate",
        "The design is incomplete, has several major problems with no plans to mitigate"
      ], votes: <int>[
        11,
        6,
        6,
        1
      ]),
      MetricModel(projectGoal: "Implementation progress", desc: <String>[
        "The implementation is ahead of schedule",
        "The implementation is on schedule",
        "The implementation is slightly behind schedule",
        "The implementation is far behind schedule"
      ], votes: <int>[
        5,
        6,
        5,
        6
      ]),
      MetricModel(projectGoal: "Integration progress", desc: <String>[
        "No major integration problems have been detected",
        "Minor integration problems have been detected",
        "At least one major integration problem has been detected, with plans to remedy",
        "Multiple major integration problems have been detected, with no plans to remedy"
      ], votes: <int>[
        9,
        8,
        7,
        0
      ])
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Risk Management"),
        ),
        body: (Column(
          children: [
            SizedBox(
              width: (MediaQuery.of(context).size.width) * 0.53,
              child: Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Row(
                  children: [
                    const Expanded(
                      flex: 5,
                      child: Text(
                        "Overall Status",
                        textScaleFactor: 2,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Icon(
                        Icons.circle,
                        key: const Key('totalRiskCircle'),
                        color: totalRiskColor = totalRisk(),
                        size: 75,
                      ),
                    ),
                    const Expanded(
                      flex: 5,
                      child: SizedBox(),
                    ),
                    Expanded(
                      flex: 5,
                      child: TextButton(
                        onPressed: () => setState(() => metricList.add(
                            MetricModel(
                                projectGoal: "Default Project Metric",
                                desc: [
                                  "Default",
                                  "Default",
                                  "Default",
                                  "Default"
                                ],
                                votes: [0, 0, 0, 0],
                                statusColor: Colors.blueGrey))),
                        child: const Text('ADD METRIC'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
                child: ListView.builder(
                    itemCount: metricList.length,
                    itemBuilder: (context, index) {
                      return goalContainer(
                          updateParent: updateState,
                          metricIndex: index,
                          metric: metricList[index],
                          metricList: metricList);
                    })),
          ],
        )));
  }

  Widget deleteButton(MetricModel metric) {
    return TextButton(
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.focused)) {
            return Colors.red;
          }
          return null; // Defer to the widget's default.
        }),
      ),
      onPressed: () => setState(() => {metricList.remove(metric)}),
      child: const Text('DELETE'),
    );
  }
}

class goalContainer extends StatefulWidget {
  Function updateParent;
  int metricIndex;
  MetricModel metric;
  List<MetricModel> metricList;
  goalContainer(
      {Key? key,
      required this.updateParent(),
      required this.metricIndex,
      required this.metric,
      required this.metricList})
      : super(key: key);

  @override
  State<goalContainer> createState() => _goalContainerState();
}

class _goalContainerState extends State<goalContainer> {
  updateState() {
    setState(() {});
    widget.updateParent();
  }

  @override
  Widget build(BuildContext context) {
    widget.metric.statusColor = getStatusColor(widget.metric.votes);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: (MediaQuery.of(context).size.width) * 0.55,
          child: Material(
            borderRadius: BorderRadius.circular(20),
            elevation: 5,
            shadowColor: Colors.black,
            child: GFAccordion(
              key: Key('accordion${widget.metricIndex}'),
              margin: const EdgeInsets.all(4),
              titlePadding: const EdgeInsets.all(25),
              contentPadding: const EdgeInsets.all(25),
              expandedTitleBackgroundColor: const Color(0xFFA1CDEB),
              collapsedTitleBackgroundColor: const Color(0xFF9FC5CC),
              contentBackgroundColor: const Color(0xFF9FC5CC),
              titleBorderRadius: const BorderRadius.all(Radius.circular(15)),
              contentBorderRadius: const BorderRadius.all(Radius.circular(15)),
              collapsedIcon: const Icon(Icons.arrow_left_rounded),
              expandedIcon: Transform.rotate(
                  angle: -90 * pi / 180,
                  key: const Key('closedArrow'),
                  child: const Icon(Icons.arrow_left_rounded)),
              titleChild: Row(
                children: [
                  Expanded(
                    flex: 45,
                    child: SizedBox(
                      child: TextFormField(
                        initialValue: metricList
                            .elementAt(widget.metricIndex)
                            .projectGoal,
                        decoration: const InputDecoration(
                          labelText: "Metric",
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
                    child: SizedBox(child: Text("Status")),
                  ),
                  Expanded(
                    flex: 15,
                    child: SizedBox(
                      child: Icon(
                        Icons.circle,
                        key: const Key('goalContainerColor'),
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
                        updateParent: updateState,
                      )
                  ],
                ),
              ),
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
      metricList.elementAt(widget.metricIndex).votes[widget.index] =
          widget.voteCount;
      metricList.elementAt(widget.metricIndex).desc[widget.index] =
          widget.description;
      metricList.elementAt(widget.metricIndex).statusColor =
          getStatusColor(metricList.elementAt(widget.metricIndex).votes);
      totalRiskColor = totalRisk();
      widget.updateParent();
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
            flex: 65,
            child: SizedBox(
                child: TextFormField(
              key: Key("desc${widget.index}"),
              controller: desc,
              decoration: const InputDecoration(),
            )),
          ),
          Expanded(
              flex: 10,
              child: SizedBox(
                child: TextFormField(
                  controller: votes,
                  key: const Key('subGoalVotes'),
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

Color totalRisk() {
  double totalRisk = 0;
  for (int i = 0; i < metricList.length; i++) {
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

double calculateRisk(List<int> voteList) {
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
