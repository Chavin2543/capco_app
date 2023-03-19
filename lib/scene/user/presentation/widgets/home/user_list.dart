import 'package:capco_app/scene/user/presentation/widgets/home/user_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../../../../base/constants/local/local_constants.dart';
import '../../../domain/entities/user/user.dart';
import '../../screens/detail_screen.dart';

class UserList extends StatelessWidget {
  const UserList({required this.users, Key? key}) : super(key: key);

  final List<User> users;

  @override
  Widget build(BuildContext context) {
    return AnimationLimiter(
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(
          horizontal: spacingSixteen,
        ),
        itemCount: users.length,
        itemBuilder: (context, position) =>
            AnimationConfiguration.staggeredList(
          position: position,
          duration: const Duration(milliseconds: 500),
          child: SlideAnimation(
            child: FadeInAnimation(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: spacingEight,
                ),
                child: UserCard(
                  username: users[position].username,
                  email: users[position].email,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => DetailScreen(
                          user: users[position],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
