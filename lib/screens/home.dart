part of 'screens.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final userState = ref.watch(userStateProvider);
    final theme = Theme.of(context);

    return CustomScrollView(
      slivers: [
        if (userState is UserSuccess)
          SliverAppBar(
            title: Row(
              children: [
                const CircleAvatar(),
                const Gap(12),
                Column(
                  children: [
                    Text(
                      'Good afternoon',
                      style: theme.textTheme.bodySmall,
                    ),
                    Text(userState.user.fullName ?? ''),
                  ],
                ),
              ],
            ),
          ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          sliver: SliverList.list(
            children: [
              TextField(
                readOnly: true,
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const SearchScreen(),
                    ),
                  );
                },
                decoration: const InputDecoration(hintText: 'Search'),
              ),
              const Gap(20),
              const Text('Recommended'),
            ],
          ),
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: 264,
            child: ListView.separated(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Card(
                  child: Column(
                    children: [
                      CachedNetworkImage(
                        imageUrl:
                            'https://images.pexels.com/photos/4239091/pexels-photo-4239091.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
                        height: 186,
                        width: 256,
                        fit: BoxFit.cover,
                      ),
                      Text('Squeaky clean'),
                      Text('Cleaning service'),
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(width: 12);
              },
              itemCount: 2,
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: const Text('Categories'),
              ),
              SizedBox(
                height: 80,
                child: ListView.separated(
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Card(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Text(
                              'Painting',
                              style: theme.textTheme.titleLarge,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(width: 12);
                  },
                  itemCount: 2,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
