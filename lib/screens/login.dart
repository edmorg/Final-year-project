part of 'screens.dart';

class LoginView extends ConsumerStatefulWidget {
  const LoginView({super.key});

  @override
  ConsumerState createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> with InputValidationMixin {
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
        LoadingScreen.instance().show(context: context, text: 'Signing in ...');
      } else {
        LoadingScreen.instance().hide();
      }
      if (state is AuthenticationSuccess) {
        Navigator.of(context).pop();
      }
      if (state is AuthenticationFailure) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(state.error ?? 'Failed to login '),
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
                        'Sign in to continue',
                        style: theme.textTheme.titleLarge,
                      ),
                      const SizedBox(height: 20),
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
                            await ref.read(authenticationStateProvider.notifier).emailSignIn(
                                  data: LoginRequestData(email: email.text, password: password.text),
                                );
                          }
                        },
                        child: const Text('Sign in'),
                      ),
                      // Align(
                      //   alignment: Alignment.centerRight,
                      //   child: TextButton(
                      //     onPressed: () {
                      //       Navigator.of(context).push(MaterialPageRoute(
                      //         builder: (_) => const ForgotPasswordView(),
                      //       ));
                      //     },
                      //     child: const Text('Forgot password?'),
                      //   ),
                      // )
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
                  const Text("Don't have an account?"),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (_) => const SignUpView()),
                        (route) => route.isFirst,
                      );
                    },
                    child: const Text('Sign up'),
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
