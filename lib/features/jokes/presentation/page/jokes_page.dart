import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jokes_app/core/services/dependencies.dart';
import 'package:jokes_app/features/jokes/presentation/bloc/jokes_bloc.dart';

class JokePage extends StatelessWidget {
  const JokePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.cyan,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Jokes App',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.cyan,
        ),
        body: PageView.builder(
          onPageChanged: (s) {
            di<JokesBloc>().add(GetRandomJokeEvent());
          },
          itemBuilder: (context, index) => BlocBuilder<JokesBloc, JokesState>(
            bloc: di<JokesBloc>(),
            builder: (context, state) {
              return Center(
                child: Container(
                  margin: EdgeInsets.all(20),
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: Color(0xffFCE8D5),
                      borderRadius: BorderRadius.circular(12)),
                  child: AnimatedSwitcher(
                    duration: Durations.extralong1,
                    child: state.status == Status.loading
                        ? CircularProgressIndicator(
                            color: Colors.cyan,
                          )
                        : state.status == Status.success
                            ? Text(state.joke!.joke)
                            : IconButton(
                                onPressed: () {
                                  di<JokesBloc>().add(GetRandomJokeEvent());
                                },
                                icon: Icon(Icons.refresh)),
                  ),
                ),
              );
            },
          ),
        ));
  }
}
