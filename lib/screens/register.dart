part of 'screens.dart';

class SignUpView extends ConsumerStatefulWidget {
  const SignUpView({super.key});

  @override
  ConsumerState createState() => _SignUpViewState();
}

class _SignUpViewState extends ConsumerState<SignUpView> with InputValidationMixin {
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool submitted = false;

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    ref.listen(authenticationStateProvider, (previous, state) {
      if (state is AuthenticationLoading) {
        LoadingScreen.instance().show(context: context, text: 'Creating user...');
      } else {
        LoadingScreen.instance().hide();
      }
      if (state is AuthenticationSuccess) {
        Navigator.of(context).pop();
      }
      if (state is AuthenticationFailure) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(state.error ?? 'Failed to create user!'),
            behavior: SnackBarBehavior.floating,
            backgroundColor: theme.colorScheme.error,
          ),
        );
      }
    });
    return GestureDetector(
      onTapDown: (_) => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: SafeArea(
                child: Form(
                  key: formKey,
                  child: ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
                    children: [
                      Text(
                        'Sign up',
                        style: theme.textTheme.titleLarge,
                      ),
                      Text(
                        'We require a few details to get started',
                        style: theme.textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: name,
                        autovalidateMode: submitted ? AutovalidateMode.onUserInteraction : AutovalidateMode.disabled,
                        validator: (name) {
                          return name!.isNotEmpty ? null : 'Name cannot be empty';
                        },
                        decoration: const InputDecoration(labelText: 'Full name'),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: email,
                        autovalidateMode: submitted ? AutovalidateMode.onUserInteraction : AutovalidateMode.disabled,
                        validator: (email) {
                          return isEmailValid(email: email!) ? null : 'Enter a valid email address';
                        },
                        decoration: const InputDecoration(labelText: 'Email'),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        autovalidateMode: submitted ? AutovalidateMode.onUserInteraction : AutovalidateMode.disabled,
                        validator: (password) {
                          return validPassword(passwordText: password!)
                              ? null
                              : 'Password must contain at least 8 characters';
                        },
                        controller: password,
                        decoration: const InputDecoration(labelText: 'Password'),
                      ),
                      const SizedBox(height: 16),
                      FilledButton(
                        onPressed: () async {
                          setState(() => submitted = true);

                          if (formKey.currentState!.validate()) {
                            formKey.currentState!.save();
                            await ref.read(authenticationStateProvider.notifier).emailRegistration(
                                  data: RegistrationRequestData(
                                    email: email.text,
                                    password: password.text,
                                    fullName: name.text,
                                  ),
                                );
                          }
                        },
                        child: const Text('Sign up'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Already have an account?'),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (_) => const LoginView()),
                        (route) => route.isFirst,
                      );
                    },
                    child: const Text('Sign in'),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
