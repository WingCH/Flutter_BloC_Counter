# BLoC Example - Counter 

> 使用Library - [flutter_bloc](https://github.com/felangel/bloc/)
>此筆記不同於[官方的Counter例子](https://bloclibrary.dev/#/fluttercountertutorial)，使用較完整的結構
>如果有誤解，請指正，我也是新手!
>[Source Code](https://github.com/WingCH?tab=repositories)

![2019-12-26_20-30-48](https://i.loli.net/2019/12/26/Tfo1YZe6aDVNvs7.gif)

## 我理解的流程

![Flutter_bloc](https://i.loli.net/2019/12/26/KXqxjFyaL9iPeJO.png)
-------

## 安裝插件

[Bloc Code Generator](https://bloclibrary.dev/#/blocintellijextension)，這個插件可以幫助我們生成[flutter_bloc](https://github.com/felangel/bloc/)所需的檔案

##### 生成步驟: 
![-w784](https://i.loli.net/2019/12/26/qQEKw7tsrlIMubN.jpg)
![-w360](https://i.loli.net/2019/12/26/ry4pfVuQBoi6kA2.jpg)

插件會生成會生成以下檔案
```json
bloc
 ├── counter_bloc.dart  // 所有business logic, 例如加數，減數
 ├── counter_state.dart // 所有state(狀態), 例如Added(已加), Decreased(已減)
 ├── counter_event.dart // 所有event(動作), 例如Add(我要加), Remove(我要減)
 └── bloc.dart //不用改，只是export以上3個檔，使用的時候import這個檔案就好
```
-------
## 定義BLoC
##### counter_event.dart
簡單定義了三個所需的event `Add`, `Remove` 和 `Refresh`
```dart
abstract class CounterEvent {}

class Add extends CounterEvent {}

class Remove extends CounterEvent {}

class Refresh extends CounterEvent {}
```
##### counter_state.dart
定義了4個State(狀態), `Initial`, `Added`, `Decreased` 和 `Reset`
一開始定義了`count` 是為了在wight可以很方便獲得`count`
```dart
abstract class CounterState {
  int count;

  CounterState(this.count);
}

class Initial extends CounterState {
  Initial(int count) : super(count);
}

class Added extends CounterState {
  Added(int count) : super(count);
}

class Decreased extends CounterState {
  Decreased(int count) : super(count);
}

class Reset extends CounterState {
  Reset(int count) : super(count);
}
```

##### counter_bloc.dart

這裡處理所有**business logic**
```dart
import 'package:bloc/bloc.dart';
import './bloc.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  int _initCount = 0;

  //一開始必須定義初始化的State(狀態)
  @override
  CounterState get initialState => Initial(_initCount);

  @override
  Stream<CounterState> mapEventToState(
    CounterEvent event,
  ) async* {
    //如果是event是`Add`, 將count+1 再用相應的State 傳出去
    if (event is Add) {
      _initCount++;
      yield Added(_initCount);
    } else if (event is Remove) {
      _initCount--;
      yield Decreased(_initCount);
    } else if (event is Refresh) {
      _initCount = 0;
      yield Reset(_initCount);
    }
  }
}
```


-------
## 介面

`BlocProvider` --包住-> `BlocBuilder`


![Flutter_bloc -2-](https://i.loli.net/2019/12/26/j5rdLHO3eftvDn1.png)

##### main.dart
```dart
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
            BlocBuilder<CounterBloc, CounterState>(
                builder: (context, state) {
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

```