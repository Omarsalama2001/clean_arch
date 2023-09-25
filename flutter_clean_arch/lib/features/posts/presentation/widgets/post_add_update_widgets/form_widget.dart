import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_arch/features/posts/presentation/widgets/post_add_update_widgets/form_submit_btn.dart';
import 'package:flutter_clean_arch/features/posts/doamin/enttities/post.dart';
import 'package:flutter_clean_arch/features/posts/presentation/bloc/add_update_delete_post/add_update_delete_post_bloc.dart';
import 'package:flutter_clean_arch/features/posts/presentation/widgets/post_add_update_widgets/TextFormWidget.dart';

class FormWidget extends StatefulWidget {
  final bool isUpdate;
  final Post? post;
  const FormWidget({
    Key? key,
    required this.isUpdate,
    this.post,
  }) : super(key: key);

  @override
  State<FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  final _formKey = GlobalKey<FormState>();
  // ignore: prefer_final_fields
  TextEditingController _titleController = TextEditingController();
  // ignore: prefer_final_fields
  TextEditingController _bodyController = TextEditingController();
  @override
  void initState() {
    super.initState();
    if (widget.isUpdate) {
      _titleController.text = widget.post!.title;
      _bodyController.text = widget.post!.body;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormWidget(
              name: "title",
              maxLines: 1,
              controller: _titleController,
            ),
            const SizedBox(
              height: 15,
            ),
            TextFormWidget(
              name: "body",
              maxLines: 6,
              controller: _bodyController,
            ),
            const SizedBox(
              height: 15,
            ),
            FormSubmitBtn(onPressed: _validateAndAddOrUpdatePost, isUpdate: widget.isUpdate)
          ],
        ),
      ),
    );
  }

  void _validateAndAddOrUpdatePost() {
    if (_formKey.currentState!.validate()) {
      final Post post = Post(id: widget.isUpdate ? widget.post!.id : null, body: _bodyController.text, title: _titleController.text);
      if (widget.isUpdate) {
        BlocProvider.of<AddUpdateDeletePostBloc>(context).add(UpdatePostEvent(post: post));
      } else {
        BlocProvider.of<AddUpdateDeletePostBloc>(context).add(AddPostEvent(post: post));
      }
    }
  }
}
