import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:try_count/bloc/bloc.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
          create: (context) => CounterBloc(),
          child: MyBLoCHomePage(title: 'Flutter Demo Home Page')),
    );
  }
}

class MyBLoCHomePage extends StatelessWidget {
  final String title;

  const MyBLoCHomePage({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child:
        BlocBuilder<CounterBloc, CounterState>(builder: (context, state) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                state.toString(),
              ),
              Text(
                state.count.toString(),
                style: Theme.of(context).textTheme.display1,
              ),
            ],
          );
        }),
      ),
      floatingActionButton: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.bottomRight,
            child: BlocBuilder<CounterBloc, CounterState>(
              builder: (context, state) {
                CounterBloc counterBloc = BlocProvider.of<CounterBloc>(context);
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: FloatingActionButton(
                        onPressed: () {
                          counterBloc.add(Add());
                        },
                        tooltip: 'Increment',
                        child: Icon(Icons.add),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: FloatingActionButton(
                        onPressed: () {
                          counterBloc.add(Remove());
                        },
                        tooltip: 'Increment',
                        child: Icon(Icons.remove),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: FloatingActionButton(
                        onPressed: () {
                          counterBloc.add(Refresh());
                        },
                        tooltip: 'Increment',
                        child: Icon(Icons.refresh),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
