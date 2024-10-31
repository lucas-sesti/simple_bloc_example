import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_bloc_example/utils/status_util.dart';

import 'bloc/movies_bloc.dart';
import 'bloc/movies_event.dart';
import 'bloc/movies_state.dart';

class MoviesPage extends StatelessWidget {
  const MoviesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// Provides the MoviesBloc to the widget tree
      body: BlocProvider(
        /// Creates the MoviesBloc and adds a FetchMovies event
        create: (context) => MoviesBloc()..add(FetchMovies()),
        child: BlocBuilder<MoviesBloc, MoviesState>(
          /// Builds the UI based on the current state of the MoviesBloc
          builder: (context, state) {
            /// Displays a loading indicator if the fetch is in progress
            if (state.fetchMoviesStatus.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            /// Displays an error message if the fetch fails
            if (state.fetchMoviesStatus.isError) {
              return const Center(child: Text('Error'));
            }

            /// Displays a list of movies
            return ListView.builder(
              itemCount: state.movies.length,
              itemBuilder: (context, index) {
                return Text(state.movies[index].title);
              },
            );
          },
        ),
      ),
    );
  }
}
