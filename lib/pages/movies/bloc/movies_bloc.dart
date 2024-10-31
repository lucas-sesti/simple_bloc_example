import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../entities/movie_entity.dart';
import '../../../utils/status_util.dart';
import 'movies_event.dart';
import 'movies_state.dart';

/// Bloc responsible for managing the state and logic of the movies page.
class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  /// Initializes the bloc with an initial state.
  MoviesBloc() : super(const MoviesState()) {
    /// Listens for FetchMovies events and processes them using _onFetchMovies.
    /// You should add more events and handlers as needed.
    on<FetchMovies>(_onFetchMovies);
  }

  /// Handles the FetchMovies event by fetching movies and updating the state.
  Future<void> _onFetchMovies(
    FetchMovies event,
    Emitter<MoviesState> emit,
  ) async {
    try {
      /// Prevents multiple simultaneous fetch requests
      if (state.fetchMoviesStatus.isLoading) return;

      /// Updates the state to loading while fetching movies
      emit(state.copyWith(fetchMoviesStatus: StateStatus.loading));

      /// Fetches movies from a fake implementation
      final movies = await _fetchMovies();

      /// Updates the state with the fetched movies and success status
      emit(state.copyWith(
        movies: movies,
        fetchMoviesStatus: StateStatus.success,
      ));
    } catch (e) {
      /// Updates the state to error if an exception occurs
      emit(state.copyWith(fetchMoviesStatus: StateStatus.error));
    }
  }

  /// Fake implementation for fetch movies
  Future<List<Movie>> _fetchMovies() async {
    /// Simulates a delay to mimic a network request
    await Future.delayed(const Duration(seconds: 2));

    /// Returns a list of fake movies
    return [
      const Movie(
        title: 'Avengers: Endgame',
        posterPath:
            'https://upload.wikimedia.org/wikipedia/pt/9/9b/Avengers_Endgame.jpg',
        overview:
            'After Thanos snaps half of all life in the universe out of existence, the remaining Avengers must do whatever it takes to undo the devastation and restore hope to the universe. Five years later, they embark on a daring time heist through the Quantum Realm to collect the Infinity Stones from the past and bring everyone back.',
      ),
      const Movie(
        title: 'The Matrix',
        posterPath:
            'https://upload.wikimedia.org/wikipedia/pt/c/c1/The_Matrix_Poster.jpg',
        overview:
            'A computer hacker learns from mysterious rebels about the true nature of his reality and his role in the war against its controllers.',
      ),
      const Movie(
        title: 'The Dark Knight',
        posterPath:
            'https://upload.wikimedia.org/wikipedia/pt/d/d1/The_Dark_Knight.jpg',
        overview:
            'When the menace known as the Joker wreaks havoc and chaos on the people of Gotham, Batman must accept one of the greatest psychological and physical tests of his ability to fight injustice.',
      ),
    ];
  }
}
