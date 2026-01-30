import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'favorite_provider.dart';
import 'counter_model.dart';

void main() {
  runApp(
    ChangeNotifierProvider(create: (_) => FavoriteProvider(), child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Provider Heart Toggle',
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favorite List')),
      body: ListView.builder(
        itemCount: FavoriteProvider.maxItems,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Item #${index}'),
            trailing: Consumer<FavoriteProvider>(
              builder: (context, fav, _) {
                final isFav = fav.isFavorite(index);
                return IconButton(
                  onPressed: () => fav.toggleFavorite(index),
                  icon: Icon(
                    isFav ? Icons.favorite : Icons.favorite_border,
                    color: isFav ? Colors.red : null,
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

  // Widget build(BuildContext context) {
  //   return MaterialApp(home: CounterScreen());
//   }
// }


// class CounterScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Reactive Counter')),
//       body: Consumer<CounterModel>(
//         builder: (context, counter, child) {
//           return Center(child: Text("Count: ${counter.count}", style: TextStyle(fontSize: 32)));
//         },
//       ),
//         floatingActionButton: Column(
//         mainAxisAlignment: MainAxisAlignment.end,
//         children: [
//           FloatingActionButton(onPressed: () => increment(context), child: Icon(Icons.add)),
//           SizedBox(height: 10),
//           FloatingActionButton(onPressed: () => reset(context), child: Icon(Icons.refresh)),
//         ],
//       ),
//     );
//   }

//   void increment(context) {
//     final counter = Provider.of<CounterModel>(context, listen: false);
//     counter.increment();
//   }

//   void reset(context) {
//     final counter = Provider.of<CounterModel>(context, listen: false);
//     counter.reset();
//   }
// }
