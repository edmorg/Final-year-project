part of 'screens.dart';

class ChatScreen extends ConsumerStatefulWidget {
  const ChatScreen({super.key});

  @override
  ConsumerState createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return CustomScrollView(
      slivers: [
        const SliverAppBar(
          title: Text('Chats'),
        ),
        SliverList.separated(
          itemBuilder: (context, index) {
            return ListTile(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const ChatPageScreen(),
                  ),
                );
              },
              contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
              leading: const CircleAvatar(radius: 32),
              title: Text(
                'Edwin Morgan',
                style: theme.textTheme.titleMedium,
              ),
              subtitle: Text(
                DateFormat.yMMMMEEEEd().format(DateTime.now()),
                style: theme.textTheme.bodySmall,
              ),
            );
          },
          separatorBuilder: (context, index) {
            return const Divider(height: 0);
          },
          itemCount: 1,
        )
      ],
    );
  }
}
