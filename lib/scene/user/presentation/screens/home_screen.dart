import 'package:capco_app/scene/user/presentation/bloc/user_bloc.dart';
import 'package:capco_app/base/widgets/loading_section.dart';
import 'package:capco_app/scene/user/presentation/widgets/home/home_header.dart';
import 'package:capco_app/scene/user/presentation/widgets/home/user_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    BlocProvider.of<UserBloc>(context).add(GetUsersEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<UserBloc, UserState>(builder: (context, state) {
        if (state is UsersLoading) {
          return const LoadingSection();
        } else if (state is UsersLoadedWithSuccess) {
          return SafeArea(
              child: RefreshIndicator(
                onRefresh: () async => BlocProvider.of<UserBloc>(context).add(
                  GetUsersEvent(),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const HomeHeader(),
                      UserList(users: state.users),
                    ],
                  ),
                ),
              ));
        } else if (state is UsersLoadedWithError) {
          return Center(
            child: Text(state.message),
          );
        } else {
          return const LoadingSection();
        }
      }),
    );
  }
}

