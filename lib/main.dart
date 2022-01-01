import 'package:flutter/material.dart';
import 'package:testnew/Model/newsmodel.dart';
import 'package:testnew/apimodel/api.dart';
import 'package:testnew/view/screen1.dart';

void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "test",
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FetchApi _fetchApi = FetchApi();

  List<ModelResults> news = [];
  int page = 5;
  int currentPage = 1;
  bool isLoading = true;

  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    fetchApiMethodeExtern();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        fetchApiMethodeExtern();
      } else {
        print("End of Pages");
        //Text("End of Pages");
      }
    });
  }

  fetchApiMethodeExtern() {
    _fetchApi.fetchArticle(currentPage).then(
      (value) {
        news.addAll(value);
        setState(
          () {
            isLoading = false;
            if (currentPage != page) {
              currentPage++;
            }
          },
        );
      },
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("NEWS APP"),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              controller: _scrollController,
              itemCount: news.length + 1,
              itemBuilder: (context, index) {
                if (index == news.length) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return Card(
                  child: ListTile(
                    title: Text(news[index].title),
                    subtitle: Text(news[index].author),
                    trailing: IconButton(
                      icon: const Icon(
                        Icons.arrow_right,
                        size: 30,
                      ),
                      tooltip: 'Description',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Screen1(
                                    author: news[index].author,
                                    description: news[index].description,
                                    image: news[index].urlToImage,
                                    content: news[index].content,
                                  )),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }
}
