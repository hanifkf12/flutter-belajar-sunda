import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'item_model.dart';

class WordPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _WordPageState();
  }

//  State<StatefulWidget> createState() => _WordPageState();
}

class _WordPageState extends State<WordPage> {
  var database;
  List<ItemKata> list;

//  DelegateSeearchKata _delegate;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
//    _delegate = DelegateSeearchKata(list);
    database = FirebaseDatabase.instance.reference();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Beranda'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              await showSearch<String>(
                  context: context, delegate: DelegateSeearchKata(list));
            },
          )
        ],
      ),
      body: StreamBuilder(
          stream: FirebaseDatabase.instance.reference().child('kata').onValue,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              print('errornya adalah $snapshot.error.toString()');
            }
            return _showKata(snapshot.data.snapshot);
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Scaffold.of(context)
              .showSnackBar(SnackBar(content: Text('add kata')));
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _showKata(DataSnapshot snapshot) {
    Kata2 kata2 = Kata2.fromSnapshot(snapshot.value);
    print(kata2.list.length);
    list = kata2.list;
    kata2.list.sort((a, b) => (a.sunda).compareTo(b.sunda));
    return ListView.builder(
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(kata2.list[index].sunda),
          subtitle: Text(kata2.list[index].indonesia),
        );
      },
      itemCount: kata2.list.length,
    );
  }
}

class DelegateSeearchKata extends SearchDelegate<String> {
  List<ItemKata> _search;

  DelegateSeearchKata(List<ItemKata> content)
      : _search = content,
        super();

  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      query.isEmpty
          ? IconButton(
              tooltip: 'voice search',
              icon: Icon(Icons.mic),
            )
          : IconButton(
              tooltip: 'Clear',
              icon: Icon(Icons.clear),
              onPressed: () {
                query = '';
              },
            )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      tooltip: 'Back',
      icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    print(query);
    return Column();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final Iterable<ItemKata> suggestions = _search
        .where((word) => word.sunda.toLowerCase().startsWith(query))
        .toList();
    return SuggestionList(suggestions, query);
//    return Column();
  }
}

class SuggestionList extends StatelessWidget {
  SuggestionList(this.sugestions, this.query);

  String query;
  List<ItemKata> sugestions;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme.subhead;
    return ListView.builder(
        itemCount: sugestions.length,
        itemBuilder: (context, index) {
          ItemKata item = sugestions[index];
          return ListTile(
            title: RichText(
              text: TextSpan(
                  text: item.sunda.substring(0, query.length),
                  style: textTheme.copyWith(fontWeight: FontWeight.bold),
                  children: <TextSpan>[
                    TextSpan(
                      text: item.sunda.substring(query.length),
                      style: textTheme,
                    )
                  ]),
            ),
            subtitle: Text(item.indonesia),
          );
        });
  }
}
