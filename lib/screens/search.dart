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
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(hintText: 'Search'),
              onTapOutside: (_) {},
              onChanged: (value) {},
            ),
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
                            child: Image.asset('assets/splash.png', height: 88, width: 100, fit: BoxFit.cover),
                          ),
                          Gap(8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Dery laundary',
                                style: theme.textTheme.titleMedium,
                              ),
                              Text(
                                'Oyarifa',
                                style: theme.textTheme.bodyMedium,
                              ),Gap(4),
                              Row(
                                children: [
                                  Text(
                                    '4.5',
                                    style: theme.textTheme.bodyMedium,
                                  ),
                                  Icon(
                                    Iconsax.star_15,
                                    size: 16
                                  ),
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
                itemCount: 4,
              ),
            )
          ],
        ),
      ),
    );
  }
}
