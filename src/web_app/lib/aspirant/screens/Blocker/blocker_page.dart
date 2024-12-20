import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../extras/components/files.dart';

class BlockerPage extends ConsumerStatefulWidget {
  static const String name = 'blocker';
  static const String route = '/blocker';
  const BlockerPage({super.key});

  @override
  ConsumerState<BlockerPage> createState() => _BlockerPageConsumerState();
}

class _BlockerPageConsumerState extends ConsumerState<BlockerPage> {
  Color tappedTextColor = const Color(0xFFFFFFFF);
  Color unTappedTextColor = const Color(0xFF504D51);
  int currentlyTapped = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(44),
        child: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          elevation: 0.5,
          leading: InkWell(
            onTap: () => context.canPop()
                ? context.canPop()
                : context.pushReplacement(HomeScreen.route),
            child: const Icon(
              Icons.arrow_back,
              color: Colors.black,
              size: 24,
            ),
          ),
          title: Text(
            'Blockers',
            style: GoogleFonts.raleway(
              color: const Color(0xFF423B43),
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.only(
                right: 20,
              ),
              child: InkWell(
                onTap: () => context.push(AddBlocker.route),
                child: SvgPicture.asset(
                  'assets/add_button.svg',
                  height: 20,
                  width: 20,
                ),
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 6,
          ),
          Card(
            child: Container(
              height: 60,
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Row(
                children: [
                  BlockerCards(
                    text: 'All',
                    textColor: currentlyTapped == 0
                        ? tappedTextColor
                        : unTappedTextColor,
                    boxColor: currentlyTapped == 0
                        ? AppTheme.kPurpleColor
                        : const Color(0xFFF2EBF3),
                    border: currentlyTapped == 0
                        ? null
                        : Border.all(
                            color: const Color(0xFFCBADCD),
                          ),
                    onTap: () {
                      setState(() {
                        currentlyTapped = 0;
                      });
                    },
                  ),
                  const SizedBox(
                    width: 32,
                  ),
                  BlockerCards(
                    text: 'Pending',
                    textColor: currentlyTapped == 1
                        ? tappedTextColor
                        : unTappedTextColor,
                    boxColor: currentlyTapped == 1
                        ? AppTheme.kPurpleColor
                        : const Color(0xFFF2EBF3),
                    border: currentlyTapped == 1
                        ? null
                        : Border.all(
                            color: const Color(0xFFCBADCD),
                          ),
                    onTap: () {
                      setState(() {
                        currentlyTapped = 1;
                      });
                    },
                  ),
                  const SizedBox(
                    width: 32,
                  ),
                  BlockerCards(
                    text: 'Resolved',
                    textColor: currentlyTapped == 2
                        ? tappedTextColor
                        : unTappedTextColor,
                    border: currentlyTapped == 2
                        ? null
                        : Border.all(
                            color: const Color(0xFFCBADCD),
                          ),
                    onTap: () {
                      setState(() {
                        currentlyTapped = 2;
                      });
                    },
                    boxColor: currentlyTapped == 2
                        ? AppTheme.kPurpleColor
                        : const Color(0xFFF2EBF3),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 6,
          ),
          Expanded(
            child: currentlyTapped == 0
                ? const AllBlockers()
                : currentlyTapped == 1
                    ? const Pending()
                    : const Resolved(),
          )
        ],
      ),
    );
  }
}
