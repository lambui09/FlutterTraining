import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/base/base_page.dart';
import 'package:untitled/data/model/movie.dart';
import 'package:untitled/data/source/remote/repository/movie_repository.dart';
import 'package:untitled/ui/home/widgets/movie_item_view.dart';
import 'package:untitled/utils/extension/image_etx.dart';
import 'package:untitled/utils/resource/color_app.dart';

import 'search_bloc.dart';
import 'search_sate.dart';

class SearchPage extends BasePage {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends BasePageState<SearchPage> {
  late SearchBloc _searchBloc;

  @override
  void init() {
    _searchBloc = SearchBloc(RepositoryProvider.of<MovieRepository>(context));
  }

  @override
  void dispose() {
    _searchBloc.dispose();
    super.dispose();
  }

  @override
  Widget buildUI(BuildContext context) {
    return StreamBuilder<SearchState>(
      stream: _searchBloc.state,
      initialData: SearchNoTerm(),
      builder: (context, snapshot) {
        final state = snapshot.data;
        return Scaffold(
          body: Stack(
            children: <Widget>[
              Flex(direction: Axis.vertical, children: <Widget>[
                SafeArea(
                  child: Container(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Search Movie, Tv...',
                      ),
                      style: TextStyle(
                        fontSize: 36.0,
                        fontFamily: 'Hind',
                        decoration: TextDecoration.none,
                      ),
                      onChanged: _searchBloc.onTextChanged.add,
                    ),
                  ),
                ),
                Expanded(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: _buildChild(state!),
                  ),
                )
              ])
            ],
          ),
        );
      },
    );
  }

  Widget _buildChild(SearchState state) {
    if (state is SearchNoTerm) {
      return SearchIntro();
    } else if (state is SearchEmpty) {
      return EmptyWidget();
    } else if (state is SearchLoading) {
      return LoadingWidget();
    } else if (state is SearchError) {
      return SearchErrorWidget();
    } else if (state is SearchPopulated) {
      return SearchResultWidget(items: state.items);
    }

    throw Exception('${state.runtimeType} is not supported');
  }
}

class SearchErrorWidget extends StatelessWidget {
  const SearchErrorWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: FractionalOffset.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.error_outline, color: Colors.red[300], size: 80.0),
          Container(
            padding: EdgeInsets.only(top: 16.0),
            child: Text(
              'Rate limit exceeded',
              style: TextStyle(
                color: Colors.red[300],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class SearchIntro extends StatelessWidget {
  const SearchIntro({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: FractionalOffset.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.info, color: Colors.green[200], size: 80.0),
          Container(
            padding: EdgeInsets.only(top: 16.0),
            child: Text(
              'Enter a search term to begin',
              style: TextStyle(
                fontSize: 24,
                color: Colors.green,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: FractionalOffset.center,
      child: CircularProgressIndicator(),
    );
  }
}

class SearchResultWidget extends StatelessWidget {
  final List<Movie> items;

  const SearchResultWidget({Key? key, required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 10,
        childAspectRatio: 158 / 290,
      ),
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return InkWell(
          onTap: () => showItem(context, item),
          child: Container(
            alignment: FractionalOffset.center,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                AspectRatio(
                  aspectRatio: 158 / 237,
                  child: PhysicalModel(
                    shape: BoxShape.rectangle,
                    clipBehavior: Clip.antiAlias,
                    color: Colors.transparent,
                    elevation: 20,
                    shadowColor: Colors.black,
                    borderRadius: BorderRadius.circular(8),
                    child: Stack(
                      children: [
                        Hero(
                            tag: item.id,
                            child: buildImage(item.posterUrl, BoxFit.fill)),
                        Align(
                          alignment: Alignment.topRight,
                          child: MovieItemCell.buildAverage(item),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  item.title.toUpperCase(),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  style: TextStyle(
                    height: 1.3,
                    fontSize: 15,
                    color: ColorApp.color_text_33,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void showItem(BuildContext context, Movie item) {
    Navigator.push(
      context,
      MaterialPageRoute<Null>(
        builder: (BuildContext context) {
          return Scaffold(
            body: GestureDetector(
              key: Key(item.backdropUrl),
              onTap: () => Navigator.pop(context),
              child: SizedBox.expand(
                child: Hero(
                  tag: item.id,
                  child: Image.network(
                    item.posterUrl,
                    width: double.infinity,
                    height: 300.0,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: FractionalOffset.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.warning,
            color: Colors.yellowAccent,
            size: 80.0,
          ),
          Container(
            padding: EdgeInsets.only(top: 16.0),
            child: Text(
              'No results',
              style: TextStyle(fontSize: 24, color: Colors.black87),
            ),
          )
        ],
      ),
    );
  }
}
