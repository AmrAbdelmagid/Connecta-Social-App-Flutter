import 'package:connecta_social_app/components/post_item.dart';
import 'package:connecta_social_app/cubits/social_cubit/social_cubit.dart';
import 'package:connecta_social_app/cubits/social_cubit/social_states.dart';
import 'package:connecta_social_app/models/post_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FeedsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        return SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: cubit.posts.length > 0 ? ListView.separated(shrinkWrap: true,physics: NeverScrollableScrollPhysics(),itemBuilder: (context,index) {
            return PostItem(index);
          }, separatorBuilder: (context,index) => SizedBox(height: 10.0), itemCount: cubit.posts.length) : Center(child: Text('No Posts Yet!'),)
        );
      },
    );
  }
}
