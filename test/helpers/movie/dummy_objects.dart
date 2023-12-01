import 'package:movid/features/movies/data/models/genre_model.dart';
import 'package:movid/features/movies/data/models/media_image_model.dart';
import 'package:movid/features/movies/data/models/movie_detail_model.dart';
import 'package:movid/features/movies/data/models/movie_model.dart';
import 'package:movid/features/movies/domain/entities/genre.dart';
import 'package:movid/features/movies/domain/entities/media_image.dart';
import 'package:movid/features/movies/domain/entities/movie.dart';
import 'package:movid/features/movies/domain/entities/movie_detail.dart';

const testId = 123;
const testMovieQuery = 'Spider-Man';

const testMovie = Movie(
  backdropPath: '/1Rr5SrvHxMXHu5RjKpaMba8VTzi.jpg',
  genreIds: [28, 12, 878],
  id: 634649,
  overview:
      'Peter Parker is unmasked and no longer able to separate his normal life from the high-stakes of being a super-hero. When he asks for help from Doctor Strange the stakes become even more dangerous, forcing him to discover what it truly means to be Spider-Man.',
  posterPath: '/1g0dhYtq4irTY1GPXvft6k4YLjm.jpg',
  releaseDate: '2021-12-15',
  title: 'Spider-Man: No Way Home',
  voteAverage: 8.4,
  voteCount: 3427,
);

const testMovieModel = MovieModel(
  backdropPath: '/1Rr5SrvHxMXHu5RjKpaMba8VTzi.jpg',
  genreIds: [28, 12, 878],
  id: 634649,
  overview:
      'Peter Parker is unmasked and no longer able to separate his normal life from the high-stakes of being a super-hero. When he asks for help from Doctor Strange the stakes become even more dangerous, forcing him to discover what it truly means to be Spider-Man.',
  posterPath: '/1g0dhYtq4irTY1GPXvft6k4YLjm.jpg',
  releaseDate: '2021-12-15',
  title: 'Spider-Man: No Way Home',
  voteAverage: 8.4,
  voteCount: 3427,
);

final testMovieList = [testMovieModel];

const testMovieDetail = MovieDetail(
  backdropPath: '/path.jpg',
  genres: [Genre(id: 1, name: 'Genre 1')],
  id: 1,
  overview: 'Overview',
  posterPath: '/path.jpg',
  releaseDate: '2022-01-01',
  runtime: 100,
  title: 'Title',
  voteAverage: 1.0,
  voteCount: 1,
);

final testMovieMap = {
  'releaseDate': '2022-01-01',
  'id': 1,
  'overview': 'Overview',
  'posterPath': '/path.jpg',
  'title': 'Title',
  'voteAverage': 1.0,
};

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

const testMovieDetailModel = MovieDetailModel(
  backdropPath: '/path.jpg',
  genres: [GenreModel(id: 1, name: 'Genre 1')],
  id: 1,
  overview: 'Overview',
  posterPath: '/path.jpg',
  releaseDate: '2022-01-01',
  runtime: 100,
  title: 'Title',
  voteAverage: 1.0,
  voteCount: 1,
);

