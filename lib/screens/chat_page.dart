part of 'screens.dart';

class ChatPageScreen extends ConsumerStatefulWidget {
  const ChatPageScreen({super.key});

  @override
  ConsumerState createState() => _ChatPageScreenState();
}

class _ChatPageScreenState extends ConsumerState<ChatPageScreen> {
  TextEditingController chatText = TextEditingController();
  ValueNotifier<bool> isLoading = ValueNotifier(false);
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              itemBuilder: (context, index) {
                return index % 2 == 0
                    ? Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 20.0),
                          margin: EdgeInsets.only(bottom: 24.0, left: MediaQuery.of(context).size.width * 0.2),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.primary,
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Text(
                            'chat.message',
                            textAlign: TextAlign.right,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                    : Container(
                        padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 20.0),
                        margin: EdgeInsets.only(bottom: 24.0, right: MediaQuery.of(context).size.width * 0.2),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.tertiaryContainer,
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Text(
                          'chat.message',
                          textAlign: TextAlign.left,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontSize: 16.0,
                          ),
                        ),
                      );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(height: 12);
              },
              itemCount: 5,
            ),
          ),
          Container(
            constraints: const BoxConstraints(minHeight: 132.0, maxHeight: 144),
            padding: const EdgeInsets.fromLTRB(20.0, 28.0, 20.0, 48.0),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20.0),
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF000000).withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, -2),
                ),
              ],
              color: theme.cardColor,
              border: Border.all(
                color: const Color(0xFFF5F5F5),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: TextField(
                    controller: chatText,
                    maxLines: 2,
                    onChanged: (value) {
                      setState(() {
                        // messageText = value;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'Type a message',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const Gap(8.0),
                ValueListenableBuilder(
                    valueListenable: isLoading,
                    builder: (context, loading, _) {
                      return MaterialButton(
                        onPressed: () async {
                          // isLoading.value = true;
                          // await createChat();
                          // isLoading.value = false;
                          // chatText.clear();
                          // setState(() {
                          //   messageText = '';
                          // });
                        },
                        // : () {},
                        padding: const EdgeInsets.all(12.0),
                        shape: const CircleBorder(),
                        color: theme.colorScheme.secondary,

                        // AppColors.kSecondaryColor100,
                        minWidth: 20,
                        child: const Center(
                          child: Icon(
                            Iconsax.send1,
                            color: Colors.white,
                          ),
                        ),
                      );
                    }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
