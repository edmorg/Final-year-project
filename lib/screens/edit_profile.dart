part of 'screens.dart';

class EditProfileView extends ConsumerStatefulWidget {
  const EditProfileView({super.key});

  @override
  ConsumerState createState() => _EditProfileViewState();
}

class _EditProfileViewState extends ConsumerState<EditProfileView> {
  late final TextEditingController emailController;
  late final TextEditingController fullName;
  final ValueNotifier<bool> emailNotifier = ValueNotifier(true);
  final ValueNotifier<bool> nameNotifier = ValueNotifier(true);

  final ValueNotifier<XFile?> profileImage = ValueNotifier(null);

  @override
  void dispose() {
    fullName.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final user = ref.watch(userStateProvider);
    if (user is UserSuccess) {
      fullName.text = user.user.fullName ?? '';
      emailController.text = user.user.email ?? '';
    }
    ref.listen(userStateProvider, (previous, state) {
      if (state is UserLoading) {
        LoadingScreen.instance().show(context: context, text: 'Updating user details...');
      } else if (state is UserSuccess) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('User details updated successfully'),
          ),
        );
        LoadingScreen.instance().hide();

        Navigator.of(context).pop();
      } else if (state is UserFailure) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: theme.colorScheme.error,
            content: Text(state.error ?? "Couldn't update user details"),
          ),
        );
        LoadingScreen.instance().hide();
      }
    });
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(title: Text('Edit profile')),
          if (user is UserSuccess)
            SliverList.list(children: [
              AuthenticationTextField(
                labelText: 'Full name',
                controller: fullName,
                validator: nameNotifier,
                hintText: 'Eg. John',
                keyboardType: TextInputType.streetAddress,
                textInputAction: TextInputAction.next,
                onChanged: (String value) {
                  // validateForm();
                  Future.delayed(const Duration(seconds: 3), () {
                    nameNotifier.value = value.length > 1;
                  });
                },
                errorText: 'Enter a valid name',
                theme: theme,
              ).paddingOnly(bottom: 16),
              AuthenticationTextField(
                labelText: 'Email',
                controller: emailController,
                validator: emailNotifier,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                hintText: 'Eg. doejohn@mail.com',
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                    RegExp(InputValidationClass.emailInputPattern),
                  ),
                ],
                onChanged: (String value) {
                  if (InputValidationClass.isEmailValid(email: emailController.text)) {
                    emailNotifier.value = InputValidationClass.isEmailValid(email: emailController.text);
                  } else {
                    Future.delayed(const Duration(seconds: 5), () {
                      emailNotifier.value = InputValidationClass.isEmailValid(email: emailController.text);
                    });
                  }
                },
                errorText: 'Enter a valid email address',
                theme: theme,
                prefixIcon: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                  child: Icon(Icons.mail_outline_rounded),
                ),
              ).paddingOnly(bottom: 16),
              FilledButton(
                onPressed: () async {
                  await ref.read(userStateProvider.notifier).updateUser(
                        user: user.user.copyWith(
                          email: emailController.text,
                          userId: user.user.userId,
                        ),
                        profileImage: profileImage.value,
                      );
                },
                child: const Text('Update'),
              ),
            ]).sliverPaddingSymmetric(horizontal: 20),
        ],
      ),
    ).dismissFocus();
  }
}
