import 'package:equatable/equatable.dart';

import '../../../entities/movie_entity.dart';
import '../../../utils/status_util.dart';

class MoviesState extends Equatable {
  /// Stores a list of Movie objects, representing the loaded movies.
  /// It is initialized as required, ensuring that the state always has a
  /// list of movies (empty or filled).
  final List<Movie> movies;

  /// It represents the current status of the state using the StateStatus enum ,
  /// with values such as initial, loading, success, and error. This allows the
  /// state to indicate whether it is, for example, waiting for a response from
  /// the server (loading) or whether the data has been successfully loaded
  /// (success).
  final StateStatus fetchMoviesStatus;

  const MoviesState({
    this.movies = const [],
    this.fetchMoviesStatus = StateStatus.initial,
  });

  @override
  List<Object?> get props => [movies, fetchMoviesStatus];

  /// The copyWith method makes it easy to create new instances of MoviesState
  /// with partial changes.
  MoviesState copyWith({
    List<Movie>? movies,
    StateStatus? fetchMoviesStatus,
  }) {
    return MoviesState(
      movies: movies ?? this.movies,
      fetchMoviesStatus: fetchMoviesStatus ?? this.fetchMoviesStatus,
    );
  }
}
