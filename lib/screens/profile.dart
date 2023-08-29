part of 'screens.dart';

///
class ProfileView extends ConsumerStatefulWidget {
  /// profile view controller
  const ProfileView({super.key});

  @override
  ConsumerState createState() => _ProfileViewState();
}

class _ProfileViewState extends ConsumerState<ProfileView> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).padding;

    ref.listen(authenticationStateProvider, (previous, state) {
      if (state is AuthenticationLoading) {
        LoadingScreen.instance().show(context: context, text: 'Signing out, please wait!');
      } else {
        LoadingScreen.instance().hide();
      }
    });
    final userState = ref.watch(userStateProvider);
    return RefreshIndicator.adaptive(
      onRefresh: () async {
        await ref.read(userStateProvider.notifier).getUserInfo();
      },
      child: CustomScrollView(
        slivers: [
          if (userState is UserSuccess)
            SliverList.list(children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: theme.primaryColor,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10000),
                      child: Text(
                        userState.user.fullName?.substring(0, 1) ?? '',
                        style: theme.textTheme.displayLarge?.copyWith(
                          color: theme.colorScheme.onPrimary,
                        ),
                      ),
                    ),
                  ).paddingOnly(right: 24),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userState.user.fullName ?? '',
                        style: theme.textTheme.titleMedium,
                      ),
                      Text(
                        userState.user.email ?? '',
                        style: theme.textTheme.bodyMedium,
                      ),
                      TextButton(
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.only(right: 24),
                            visualDensity: const VisualDensity(horizontal: VisualDensity.minimumDensity),
                          ),
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => const EditProfileView(),
                              ),
                            );
                          },
                          child: Text(
                            'Edit',
                            style: theme.textTheme.bodyLarge?.copyWith(
                              decoration: TextDecoration.underline,
                              decorationThickness: 2,
                            ),
                          ))
                    ],
                  )
                ],
              ).paddingOnly(bottom: 32, top: 24),
              Text('Settings', style: theme.textTheme.titleSmall),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: const Color(0xFFDFE6E9),
                  ),
                ),
                child: Column(
                  children: [
                    ListTile(
                      title: Text(
                        'Notifications',
                        style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500),
                      ),
                      trailing: const Icon(Iconsax.arrow_right_2),
                    ),
                    ListTile(
                      title: Text(
                        'Security',
                        style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500),
                      ),
                      trailing: const Icon(Iconsax.arrow_right_2),
                    ),
                    ListTile(
                      title: Text(
                        'Theme',
                        style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500),
                      ),
                      trailing: const Icon(Iconsax.arrow_right_2),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: const Color(0xFFDFE6E9),
                  ),
                ),
                child: Column(
                  children: [
                    ListTile(
                      title: Text(
                        'Send feedback',
                        style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500),
                      ),
                      trailing: const Icon(Iconsax.arrow_right_2),
                    ),
                    ListTile(
                      title: Text(
                        'Rate the app',
                        style: theme.textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      trailing: const Icon(Iconsax.arrow_right_2),
                    ),
                    ListTile(
                      title: Text(
                        'About',
                        style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500),
                      ),
                      trailing: const Icon(Iconsax.arrow_right_2),
                    ),
                    ListTile(
                      title: Text(
                        'Terms and conditions',
                        style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500),
                      ),
                      trailing: const Icon(Iconsax.arrow_right_2),
                    ),
                    ListTile(
                      title: Text(
                        'Privacy policy',
                        style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500),
                      ),
                      trailing: const Icon(Iconsax.arrow_right_2),
                    ),
                    ListTile(
                      title: Text(
                        'Software licenses',
                        style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500),
                      ),
                      trailing: const Icon(Iconsax.arrow_right_2),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: theme.colorScheme.error),
                ),
                child: Column(
                  children: [
                    ListTile(
                      onTap: () async {
                        await ref.read(authenticationStateProvider.notifier).signOut();
                      },
                      title: Text(
                        'Sign out',
                        style: theme.textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: theme.colorScheme.error,
                        ),
                      ),
                      trailing: Icon(Iconsax.logout, color: theme.colorScheme.error),
                    ),
                  ],
                ),
              ),
            ]).sliverPaddingSymmetric(horizontal: 24, vertical: size.top)
          else if (userState is UserLoading)
            const SliverFillRemaining(
              child: Center(
                child: CircularProgressIndicator.adaptive(),
              ),
            )
          else if (userState is UserFailure)
            const SliverFillRemaining()
        ],
      ),

      // ListView(
      //   padding: EdgeInsets.symmetric(horizontal: 24, vertical: size.top),
      //   children:
      // ),
    );
  }
}
