import 'package:flutter/material.dart';

class StudyMaterialPage extends StatefulWidget {
  const StudyMaterialPage({super.key});

  @override
  State<StudyMaterialPage> createState() => _StudyMaterialPageState();
}

class Item {
  Item({
    required this.expandedValue,
    required this.headerValue,
    this.isExpanded = false,
  });

  String expandedValue;
  String headerValue;
  bool isExpanded;
}

List<Item> generateItems(int numberOfItems) {
  return List<Item>.generate(numberOfItems, (int index) {
    return Item(
      headerValue: 'Panel $index',
      expandedValue: 'This is item number $index',
    );
  });
}

class _StudyMaterialPageState extends State<StudyMaterialPage> {
  final List<Item> _data = generateItems(8);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("S T U D Y"),
      ),
      body: Column(children: [
        ExpansionPanelList(
          expansionCallback: (int index, bool isExpanded) {
            setState(() {
              _data[index].isExpanded = !isExpanded;
            });
          },
          children: _data.map<ExpansionPanel>((Item item) {
            return ExpansionPanel(
              headerBuilder: (BuildContext context, bool isExpanded) {
                return ListTile(
                  title: Text(item.headerValue),
                );
              },
              body: ListTile(
                  title: Text(item.expandedValue),
                  subtitle: const Text(
                      'To delete this panel, tap the trash can icon'),
                  trailing: const Icon(Icons.download_rounded),
                  onTap: () {
                    setState(() {
                      _data.removeWhere(
                          (Item currentItem) => item == currentItem);
                    });
                  }),
              isExpanded: item.isExpanded,
            );
          }).toList(),
        )
      ]),
    );
  }
}
