part of 'screens.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final service = ref.watch(searchStateProvider);
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(hintText: 'Search'),
              onTapOutside: (_) {},
              onChanged: (value) async {
                await ref.read(searchStateProvider.notifier).getServices(queryParam: value);
              },
            ),
            if (service is ServiceSuccess)
              if (service.services.isNotEmpty)
                Flexible(
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(vertical: 32),
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 0.2,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: CachedNetworkImage(
                                  imageUrl: service.services[index].serviceImage,
                                  height: 88,
                                  width: 96,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const Gap(8),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    service.services[index].serviceName,
                                    style: theme.textTheme.titleMedium,
                                  ),
                                  Text(
                                    service.services[index].location,
                                    style: theme.textTheme.bodyMedium,
                                  ),
                                  const Gap(4),
                                  Row(
                                    children: [
                                      Text(
                                        service.services[index].rating.toString(),
                                        style: theme.textTheme.bodyMedium,
                                      ),
                                      const Icon(Iconsax.star_15, size: 16),
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const Gap(16);
                    },
                    itemCount: service.services.length,
                  ),
                ),
            if (service is ServiceLoading) ...[
              const Spacer(),
              const Center(
                child: CircularProgressIndicator.adaptive(),
              ),
              const Spacer()
            ],
            if (service is ServiceFailure) ...[
              const Spacer(),
              Center(
                child: Column(
                  children: [
                    SvgPicture.asset('assets/splash.svg'),
                    Text(service.error),
                  ],
                ),
              ),
              const Spacer()
            ]
          ],
        ),
      ),
    );
  }
}
