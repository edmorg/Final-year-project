part of 'screens.dart';

class ServiceScreen extends ConsumerStatefulWidget {
  const ServiceScreen({super.key, required this.service});
  final ServiceModel service;
  @override
  ConsumerState createState() => _ServiceScreenState();
}

class _ServiceScreenState extends ConsumerState<ServiceScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.only(bottom: 32),
                shrinkWrap: true,
                children: [
                  Stack(
                    children: [
                      CachedNetworkImage(
                        imageUrl: widget.service.serviceImage,
                        width: 428,
                        height: 298,
                        fit: BoxFit.cover,
                      ),
                      Positioned(
                        left: 8.0,
                        child: SafeArea(
                          child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 6.0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(Icons.arrow_back),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.service.serviceName,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                fontFamily: 'Outfit',
                                fontSize: 26,
                                fontWeight: FontWeight.w500,
                                height: 1.2,
                              ),
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.bookmark_border_rounded,
                                size: 30,
                              ),
                              onPressed: () {},
                            ),
                          ],
                        ),
                        Wrap(
                          spacing: 12,
                          runSpacing: 12,
                          children: List.generate(
                            widget.service.categories.length,
                            (index) => Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(18),
                                border: Border.all(),
                              ),
                              child: Text(
                                widget.service.categories[index],
                                textAlign: TextAlign.center,
                                style: theme.textTheme.bodyMedium,
                              ),
                            ),
                          ),
                        ),
                        const Gap(12),
                        Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(right: 4),
                              child: Icon(
                                Icons.star_outlined,
                                color: Color(0xFFFFD233),
                                size: 24,
                              ),
                            ),
                            Text('${widget.service.rating} (2) Reviews', style: theme.textTheme.bodyMedium),
                          ],
                        ),
                        Divider(thickness: 1, color: Colors.black.withOpacity(0.13)),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(0, 28, 0, 0),
                          child: Text(
                            'About ',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                          child: Text(widget.service.description, style: theme.textTheme.bodyMedium),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
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
                    child: OutlinedButton.icon(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const ChatPageScreen(),
                          ),
                        );
                      },
                      icon: const Icon(Iconsax.message, size: 18),
                      label: const Text('chat'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: FilledButton.icon(
                      onPressed: () {
                        launchUrl(
                          Uri(path: 'tel:+233${widget.service.phoneNumber}'),
                        );
                      },
                      icon: const Icon(Iconsax.call, size: 18),
                      label: const Text('Call'),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
