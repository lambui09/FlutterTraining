import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:untitled/base/base_page.dart';
import 'package:untitled/data/model/movie.dart';
import 'package:untitled/ui/home/detail/movie_detail_bloc.dart';
import 'package:untitled/utils/extension/image_etx.dart';
import 'package:untitled/utils/extension/size_ext.dart';
import 'package:untitled/utils/navigate_utils.dart';
import 'package:untitled/utils/resource/color_app.dart';
import 'package:untitled/utils/resource/image_app.dart';
import 'package:untitled/utils/resource/string_app.dart';

class MovieDetailPage extends BaseStateFul {
  const MovieDetailPage({Key? key, required this.movie}) : super(key: key);

  final Movie movie;

  static const String routeName = "/movie_detail";

  @override
  _MovieDetailPageState createState() => _MovieDetailPageState();
}

class _MovieDetailPageState
    extends BaseBlocState<MovieDetailPage, MovieDetailBloc> {
  @override
  void init() {}

  @override
  Widget buildUI(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildContentScroll(context),
          _BackButton(margin: const EdgeInsets.only(left: 20, top: 20)),
        ],
      ),
    );
  }

  Widget _buildContentScroll(BuildContext context) {
    final heightImageHeader = 300 * getRatio(context);
    final heightContentHeader = 188 * getRatio(context);
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: double.infinity,
            height: heightImageHeader + heightContentHeader * 3 / 5,
            child: Stack(
              children: [
                _buildImageHeader(heightImageHeader),
                _buildContentHeader(heightContentHeader),
              ],
            ),
          ),
          _buildOverview(),
          _buildCastList(context),
          _buildBottomButton(context),
        ],
      ),
    );
  }

  Widget _buildImageHeader(double height) {
    const heightIcon = 56.0;
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: double.infinity,
          height: height,
          child: buildImage(widget.movie.imageUrl, BoxFit.cover),
        ),
        Container(
          width: heightIcon,
          height: heightIcon,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(heightIcon / 2),
            gradient: LinearGradient(
              begin: FractionalOffset(0.0, 0.5),
              end: FractionalOffset(1.0, 1.0),
              colors: [
                Color.fromRGBO(249, 159, 0, 1),
                Color.fromRGBO(219, 48, 105, 1),
              ],
            ),
          ),
          child: InkWell(
            onTap: () {},
            child: const Icon(
              Icons.play_arrow_rounded,
              size: 40,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildContentHeader(double height) {
    final Movie movie = widget.movie;
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: height,
        alignment: Alignment.bottomCenter,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            AspectRatio(
              aspectRatio: 120 / 180,
              child: PhysicalModel(
                color: Colors.transparent,
                elevation: 24,
                shadowColor: Colors.black,
                borderRadius: BorderRadius.circular(6),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: Hero(
                    tag: movie.id,
                    child: buildImage(movie.posterUrl),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: height * 2 / 5,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        movie.title.toUpperCase(),
                        textAlign: TextAlign.start,
                        maxLines: 2,
                        style: const TextStyle(
                            height: 1.3,
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    '${movie.popularity.toInt()} ' + StringApp.people_awaiting,
                    textAlign: TextAlign.start,
                    maxLines: 2,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.normal),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    movie.releaseDate,
                    textAlign: TextAlign.start,
                    maxLines: 1,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.normal),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Text(
                          movie.firstAverage(),
                          style: const TextStyle(
                              color: ColorApp.color_214_24_42, fontSize: 20),
                        ),
                        Text(
                          '.',
                          style: const TextStyle(
                              color: ColorApp.color_214_24_42, fontSize: 12),
                        ),
                        Text(
                          movie.lastAverage(),
                          style: const TextStyle(
                              color: ColorApp.color_214_24_42, fontSize: 14),
                        ),
                        const SizedBox(width: 12),
                        _buildRatingBar(),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildRatingBar() {
    print(double.parse(widget.movie.voteAverage));
    return RatingBar.builder(
      initialRating: double.parse(widget.movie.voteAverage) / 2,
      itemSize: 20,
      minRating: 1,
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemCount: 5,
      itemPadding: EdgeInsets.symmetric(horizontal: 3.0),
      itemBuilder: (context, _) => Icon(
        Icons.star,
        color: ColorApp.color_214_24_42,
      ),
      onRatingUpdate: (rating) {
        print(rating);
      },
    );
  }

  Widget _buildOverview() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
      child: Text(
        widget.movie.overview,
        maxLines: 6,
        style: TextStyle(
            color: ColorApp.color_text_102,
            fontSize: 20,
            fontWeight: FontWeight.normal,
            height: 1.6),
      ),
    );
  }

  Widget _buildCastList(BuildContext context) {
    return Container();
  }

  Widget _buildBottomButton(BuildContext context) {
    final height = 100 * getRatio(context);
    final itemSize = height * 0.75;
    final iconSize = itemSize * 0.45;
    return SizedBox(
      width: double.infinity,
      height: height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildLike(itemSize, iconSize),
          _buildFavorite(itemSize, iconSize),
          _buildComment(itemSize, iconSize),
        ],
      ),
    );
  }

  Widget _buildLike(double itemSize, double iconSize) {
    return Column(
      children: [
        SizedBox(
          width: itemSize,
          height: itemSize,
          child: Card(
            shape: const CircleBorder(),
            shadowColor: Colors.black54,
            elevation: 4,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(itemSize / 2),
                    gradient: LinearGradient(
                      begin: FractionalOffset(0.0, 0.5),
                      end: FractionalOffset(1.0, 1.0),
                      colors: [
                        Color.fromRGBO(249, 159, 0, 1),
                        Color.fromRGBO(219, 48, 105, 1),
                      ],
                    ),
                  ),
                ),
                Center(
                  child: SizedBox(
                    width: iconSize,
                    height: iconSize,
                    child: Image.asset(
                      ImageApp.ic_like_white,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Text(
              '${widget.movie.voteCount}K',
              style: const TextStyle(
                fontSize: 14,
                color: ColorApp.color_text_102,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFavorite(double itemSize, double iconSize) {
    return Column(
      children: [
        SizedBox(
          width: itemSize,
          height: itemSize,
          child: Card(
            shape: const CircleBorder(),
            shadowColor: Colors.black54,
            elevation: 4,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.amberAccent,
                    borderRadius: BorderRadius.circular(itemSize / 2),
                  ),
                ),
                Center(
                  child: SizedBox(
                    width: iconSize,
                    height: iconSize,
                    child: Image.asset(
                      ImageApp.ic_favorite_white,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Text(
              StringApp.favorite,
              style: const TextStyle(
                fontSize: 14,
                color: ColorApp.color_text_102,
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildComment(double itemSize, double iconSize) {
    return Column(
      children: [
        SizedBox(
          width: itemSize,
          height: itemSize,
          child: Card(
            shape: const CircleBorder(),
            shadowColor: Colors.black54,
            elevation: 4,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(itemSize / 2),
                  ),
                ),
                Center(
                  child: SizedBox(
                    width: iconSize,
                    height: iconSize,
                    child: Image.asset(
                      ImageApp.ic_comment_white,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Text(
              StringApp.comment,
              style: const TextStyle(
                fontSize: 14,
                color: ColorApp.color_text_102,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _BackButton extends BaseStateLess {
  const _BackButton({Key? key, this.onTap, this.margin}) : super(key: key);

  final GestureTapCallback? onTap;
  final EdgeInsets? margin;

  @override
  Widget build(BuildContext context) {
    final double paddingTop = getPaddingTop(context);
    const color = Colors.white;
    return InkWell(
      onTap: onTap != null ? onTap : () => NavigateUtils.pop(context),
      child: Ink(
        child: Container(
          margin: margin,
          padding: EdgeInsets.only(top: paddingTop),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.arrow_back_ios, color: color),
              Text(
                StringApp.back,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                  color: color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
