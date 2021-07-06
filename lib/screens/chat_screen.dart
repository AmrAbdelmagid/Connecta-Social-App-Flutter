import 'package:connecta_social_app/cubits/social_cubit/social_cubit.dart';
import 'package:connecta_social_app/cubits/social_cubit/social_states.dart';
import 'package:connecta_social_app/models/user_model.dart';
import 'package:connecta_social_app/utils/styles/icon_broken.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatScreen extends StatelessWidget {
  final UserModel receiver;

  ChatScreen(this.receiver);

  @override
  Widget build(BuildContext context) {
    var messageController = TextEditingController();
    return Builder(
      builder: (context) {
        SocialCubit.get(context).getMessages(receiver.uid!);
        return BlocConsumer<SocialCubit, SocialStates>(
          listener: (context, state) {},
          builder: (context, state) {
            var messagesList = SocialCubit.get(context).messages;
            return GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(new FocusNode());
              },
              child: Scaffold(
                appBar: AppBar(
                  titleSpacing: 0.0,
                  title: Row(
                    children: [
                      Stack(
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage('${receiver.image}'),
                            radius: 22.0,
                          ),
                          Positioned(
                              top: 30.0,
                              left: 30.0,
                              child: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 8.0,
                                  child: CircleAvatar(
                                    radius: 6.0,
                                    backgroundColor:
                                        Colors.lightGreenAccent.shade700,
                                  )))
                        ],
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Text(
                        '${receiver.name}',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2!
                            .copyWith(fontSize: 24.0),
                      ),
                    ],
                  ),
                ),
                body: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 12.0,
                      ),
                      Expanded(
                        child: ListView.separated(
                          physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index) => Align(
                                  alignment: (messagesList[index].senderId ==
                                          SocialCubit.get(context)
                                              .userModel!
                                              .uid)
                                      ? Alignment.topRight
                                      : Alignment.topLeft,
                                  child: Container(
                                    padding: EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                        color: (messagesList[index].senderId ==
                                                SocialCubit.get(context)
                                                    .userModel!
                                                    .uid)
                                            ? Theme.of(context)
                                                .accentColor
                                                .withOpacity(.4)
                                            : Colors.grey.shade200,
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(8.0),
                                          bottomRight:
                                              (messagesList[index].senderId ==
                                                      SocialCubit.get(context)
                                                          .userModel!
                                                          .uid)
                                                  ? Radius.circular(0.0)
                                                  : Radius.circular(8.0),
                                          topLeft: Radius.circular(8.0),
                                          bottomLeft:
                                              (messagesList[index].senderId ==
                                                      SocialCubit.get(context)
                                                          .userModel!
                                                          .uid)
                                                  ? Radius.circular(8.0)
                                                  : Radius.circular(0.0),
                                        )),
                                    child:
                                        Text(messagesList[index].messageText!),
                                  ),
                                ),
                            separatorBuilder: (context, index) => SizedBox(
                                  height: 10.0,
                                ),
                            itemCount: messagesList.length),
                      ),
                      Container(
                        height: 40.0,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        decoration: BoxDecoration(
                            border: Border.all(
                              color:
                                  Theme.of(context).accentColor.withOpacity(.5),
                            ),
                            borderRadius: BorderRadius.circular(8.0)),
                        child: Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextField(
                                  controller: messageController,
                                  textAlignVertical: TextAlignVertical.center,
                                  style: Theme.of(context).textTheme.bodyText2,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    hintText: 'Type your message here...',
                                    contentPadding: EdgeInsets.only(bottom: 15),
                                    hintStyle:
                                        Theme.of(context).textTheme.caption!,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                                height: 40.0,
                                color: Theme.of(context).primaryColor,
                                child: MaterialButton(
                                  minWidth: 1.0,
                                  onPressed: () {
                                    SocialCubit.get(context).sendMessage(
                                        messageController.text,
                                        DateTime.now().toString(),
                                        SocialCubit.get(context)
                                            .userModel!
                                            .uid!,
                                        receiver.uid!);
                                    messageController.clear();
                                  },
                                  child: Icon(
                                    IconBroken.Send,
                                    color: Colors.white,
                                  ),
                                ))
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

// // Align(
// //   alignment: Alignment.topRight,
// //   child: Container(
// //     padding: EdgeInsets.all(8.0),
// //     decoration: BoxDecoration(
// //         color: Theme.of(context).accentColor.withOpacity(.4),
// //         borderRadius: BorderRadius.only(
// //           topRight: Radius.circular(12.0),
// //           bottomRight: Radius.circular(0.0),
// //           topLeft: Radius.circular(12.0),
// //           bottomLeft: Radius.circular(12.0),
// //         )),
// //     child: Text('Hello from lol'),
// //   ),
// // ),
// Spacer(),
