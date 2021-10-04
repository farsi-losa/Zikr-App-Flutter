import 'package:flutter/material.dart';
import 'package:dzikirapp/db.dart';

class ItemList extends StatefulWidget {
  @override
  _ItemListState createState() => new _ItemListState();
}

class _ItemListState extends State<ItemList> {
  // This widget is the root of your application.
  late DatabaseHandler handler;

  @override
  void initState() {
    super.initState();

    this.handler = DatabaseHandler();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: this.handler.retrieveDzikirs(),
        builder: (BuildContext context, AsyncSnapshot<List<Dzikir>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (BuildContext context, int index) {
                return Dismissible(
                  direction: DismissDirection.endToStart,
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Icon(Icons.delete_forever),
                  ),
                  key: ValueKey<int>(index),
                  onDismissed: (DismissDirection direction) async {
                    // await this.handler.deleteUser(snapshot.data![index].id);
                    setState(() {
                      snapshot.data!.remove(snapshot.data![index]);
                    });
                  },
                  child: Card(
                    child: ListTile(
                      contentPadding: EdgeInsets.all(8.0),
                      title: Text(snapshot.data![index].name),
                      subtitle: Text(snapshot.data![index].qty.toString()),
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
