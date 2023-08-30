part of 'screens.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SvgPicture.asset('assets/splash.svg'),
                Text(
                  'Welcome to TalentPlatform',
                  style: theme.textTheme.titleLarge,
                ),

                const SizedBox(height: 8),
                Text(
                  'Discover Artisans and Professionals to cater your needs',
                  style: theme.textTheme.titleMedium,
                ),
              ],
            ),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16),
              ),
              border: Border.all(width: 1, color: theme.colorScheme.primary.withOpacity(0.2)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (_) => const SignUpView(),
                        ),
                        (route) => route.isFirst,
                      );
                    },
                    child: const Text('Register'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: FilledButton(
                    onPressed: () {
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (_) => const LoginView(),
                        ),
                        (route) => route.isFirst,
                      );
                    },
                    child: const Text('Login'),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }




}
