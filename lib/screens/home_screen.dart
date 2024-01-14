import 'package:flutter/material.dart';
import 'package:toonflix/models/webtoon_model.dart';
import 'package:toonflix/services/api_service.dart';
import 'package:toonflix/widgets/webtoon_widget.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final Future<List<WebtoonModel>> webtoons = ApiService.getTodaysToons();
  // List<WebtoonModel> webtoons = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          foregroundColor: Colors.green,
          surfaceTintColor: Colors.white,
          shadowColor: Colors.black,
          elevation: 2,
          // foregroundColor referes to the text color in AppBar
          title: const Text(
            'Today\'s webtoons',
            style: TextStyle(
              fontSize: 24,
            ),
          ),
        ),
        body: FutureBuilder(
          future: webtoons,
          builder: (context, futureState) {
            // futureState(snapshot) is the state of future
            if (futureState.hasData) {
              return Column(
                children: [
                  const SizedBox(height: 50),
                  Expanded(child: makeList(futureState)),
                ],
              );
              // only activated when Future finished and server responds
              // of course, going to show List of item, It has children
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ));
  }

  ListView makeList(AsyncSnapshot<List<WebtoonModel>> futureState) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      separatorBuilder: (context, index) => const SizedBox(width: 40),
      itemCount: futureState.data!.length,
      itemBuilder: (context, index) {
        var webtoon = futureState.data![index];
        return Webtoon(
          title: webtoon.title,
          thumb: webtoon.thumb,
          id: webtoon.id,
        );
        // if I don't see the item, then itemBuilder will destroy the item to free the memory
        // only way to know what I'm building is by using index.
      },
    );
  }
}
