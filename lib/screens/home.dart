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
    final service = ref.watch(serviceStateProvider);
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Good afternoon', style: theme.textTheme.bodySmall),
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
              Text('Recommended', style: theme.textTheme.titleLarge),
            ],
          ),
        ),
        if (service is ServiceSuccess)
          SliverToBoxAdapter(
            child: SizedBox(
              height: 264,
              child: ListView.separated(
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => ServiceScreen(
                            service: service.services[index],
                          ),
                        ),
                      );
                    },
                    child: Card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CachedNetworkImage(
                            imageUrl: service.services[index].serviceImage,
                            height: 186,
                            width: 256,
                            fit: BoxFit.cover,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(service.services[index].serviceName, style: theme.textTheme.titleLarge),
                                Row(
                                  children: List.generate(
                                    service.services[index].categories.length,
                                    (categoryIndex) => Text(
                                      '${service.services[index].categories[categoryIndex]}, ',
                                      style: theme.textTheme.titleMedium,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(width: 12);
                },
                itemCount: service.services.length,
              ),
            ),
          ),
        if (service is ServiceSuccess)
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text('Around me', style: theme.textTheme.titleLarge),
                ),
                SizedBox(
                  height: 264,
                  child: ListView.separated(
                    shrinkWrap: true,
                    reverse: true,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => ServiceScreen(
                                service: service.services[index],
                              ),
                            ),
                          );
                        },
                        child: Card(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CachedNetworkImage(
                                imageUrl: service.services[index].serviceImage,
                                height: 186,
                                width: 256,
                                fit: BoxFit.cover,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(service.services[index].serviceName, style: theme.textTheme.titleLarge),
                                    Row(
                                      children: List.generate(
                                        service.services[index].categories.length,
                                        (categoryIndex) => Text(
                                          '${service.services[index].categories[categoryIndex]}, ',
                                          style: theme.textTheme.titleMedium,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(width: 12);
                    },
                    itemCount: service.services.length,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
