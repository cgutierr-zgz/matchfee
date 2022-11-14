import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matchfee/core/core.dart';
import 'package:matchfee/matches/matches.dart';

class MatchDialog extends StatelessWidget {
  const MatchDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "It's a match!",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            const Text(
              // TODO: Create random set of messages
              'Say hi to your new match!',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            /*
            Image.asset(
              'assets/images/match.png',
              width: 100,
              height: 100,
            ),*/
            Builder(
              builder: (context) {
                final coffee = context.read<MatchesCubit>().state.first;
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.red,
                      radius: 50,
                      child: CircleAvatar(
                        backgroundImage: MemoryImage(coffee.bytes),
                        radius: 48,
                      ),
                    ),
                    GradientIcon(
                      icon: coffee.isSuperLike ? Icons.star : Icons.favorite,
                      size: 40,
                      gradient: coffee.isSuperLike
                          ? const LinearGradient(
                              colors: [
                                Colors.blueAccent,
                                Colors.lightBlue,
                              ],
                            )
                          : const LinearGradient(
                              colors: [
                                Colors.green,
                                Colors.greenAccent,
                              ],
                            ),
                    ),
                    const CircleAvatar(
                      backgroundColor: Colors.red,
                      radius: 50,
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(AppTheme.avatarUrl),
                        radius: 48,
                      ),
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white,
                      side: const BorderSide(color: Colors.white),
                      backgroundColor: Colors.grey,
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 32,
                      ),
                    ),
                    onPressed: () => context
                      ..pop()
                      ..push(const MatchesPage()),
                    icon: const Icon(Icons.mark_chat_unread_sharp),
                    label: const Text('Send a Message'),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white,
                      side: const BorderSide(color: Colors.white),
                      backgroundColor: Colors.grey,
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 32,
                      ),
                    ),
                    onPressed: () => context.pop(),
                    icon: const Icon(Icons.area_chart_rounded),
                    label: const Text('Keep Playing'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
