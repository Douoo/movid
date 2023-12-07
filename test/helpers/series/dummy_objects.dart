import 'package:movid/features/series/data/model/genre_model.dart';
import 'package:movid/features/series/data/model/media_image_model.dart';
import 'package:movid/features/series/data/model/series_detail_model.dart';
import 'package:movid/features/series/domain/entites/genre.dart';
import 'package:movid/features/series/domain/entites/media_image.dart';
import 'package:movid/features/series/domain/entites/series.dart';
import 'package:movid/features/series/domain/entites/series_detail.dart';

const testTvSeriesId = 23112;
const testTvSeriesQuery = "baby";
final testTvSeriesList = [testTvSeries];
const testTvSeries = TvSeries(
  id: 1,
  title: 'test',
  description: "this is a random ass description",
  language: "en",
  isAdult: false,
  date: "2023/20/3",
  rating: 8.3,
  genreIds: [1, 2, 3],
  backdropPath: "/path/to/backdrop.jpg",
  poster: "/path/to/backdrop.jpg",
);

const testRecommendedTvSeries = TvSeries(
  id: 1,
  title: 'test',
  description: "this is a random ass description",
  language: "en",
  isAdult: false,
  date: "2023/20/3",
  rating: 8.3,
  genreIds: [1, 2, 3],
  backdropPath: "/path/to/backdrop.jpg",
  poster: "/path/to/backdrop.jpg",
);
const testOnAirTvSeries = TvSeries(
  id: 1,
  title: 'test',
  description: "this is a random ass description",
  language: "en",
  isAdult: false,
  date: "2023/20/3",
  rating: 8.3,
  genreIds: [1, 2, 3],
  backdropPath: "/path/to/backdrop.jpg",
  poster: "/path/to/backdrop.jpg",
);
const testTopRatedTvSeries = TvSeries(
  id: 1,
  title: 'test',
  description: "this is a random ass description",
  language: "en",
  isAdult: false,
  date: "2023/20/3",
  rating: 8.3,
  genreIds: [1, 2, 3],
  backdropPath: "/path/to/backdrop.jpg",
  poster: "/path/to/backdrop.jpg",
);

const testDetailTvSeries = SeriesDetail(
    backdropPath: '/path.jpg',
    genres: [Genre(id: 1, name: 'Genre 1')],
    id: 1,
    posterPath: '/path.jpg',
    releaseDate: '2022-01-01',
    runtime: [100],
    title: 'Title',
    voteAverage: 1.0,
    voteCount: 1,
    numberOfEpisodes: 2,
    numberOfSeasons: 2);

const testImage = MediaImage(
  id: 1,
  backdropPaths: ['/path.jpg'],
  logoPaths: ['/path.jpg'],
  posterPaths: ['/path.jpg'],
);
const testImageModel = MediaImageModel(
  id: 1,
  backdropPaths: ['/path.jpg'],
  logoPaths: ['/path.jpg'],
  posterPaths: ['/path.jpg'],
);
const testDetailTvSeriesModel = SeriesDetailModel(
    backdropPath: '/path.jpg',
    genres: [GenreModel(id: 1, name: 'Genre 1')],
    id: 1,
    posterPath: '/path.jpg',
    releaseDate: '2022-01-01',
    runtime: [100],
    title: 'Title',
    voteAverage: 1.0,
    voteCount: 1,
    numberOfEpisodes: 1,
    numberOfSeasons: 2);
