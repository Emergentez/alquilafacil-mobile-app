import 'package:alquilafacil/auth/presentation/providers/SignInProvider.dart';
import 'package:alquilafacil/public/presentation/widgets/screen_bottom_app_bar.dart';
import 'package:alquilafacil/spaces/presentation/providers/space_provider.dart';
import 'package:alquilafacil/subscriptions/presentation/provider/plan_provider.dart';
import 'package:alquilafacil/subscriptions/presentation/screens/payment_finish_screen.dart';
import 'package:alquilafacil/subscriptions/presentation/screens/subscription_screen.dart';
import 'package:alquilafacil/subscriptions/presentation/screens/subscriptions_management_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:alquilafacil/spaces/presentation/widgets/card.dart';

import '../../../public/ui/providers/theme_provider.dart';
import '../../../public/ui/theme/main_theme.dart';
import '../../../shared/providers/locale_provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final spaceProvider = Provider.of<SpaceProvider>(context);
    final signInProvider = context.watch<SignInProvider>();
    final themeProvider = Provider.of<ThemeProvider>(context);
    final planProvider = context.watch<PlanProvider>();
    final localeProvider = Provider.of<LocaleProvider>(context);
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: MainTheme.background(context),
      appBar: AppBar(
        backgroundColor: themeProvider.isDarkTheme ? MainTheme.primary(context) : MainTheme.background(context),
        title: Text(
          l10n.profile,
          style: TextStyle(color: MainTheme.contrast(context)),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.popAndPushNamed(context, '/search-space');
          },
        ),
      ),
      bottomNavigationBar: const ScreenBottomAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              margin: const EdgeInsets.all(16.0),
              elevation: 10.0,
              child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 32.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    l10n.darkTheme,
                    style: TextStyle(
                      color: MainTheme.contrast(context),
                      fontSize: 14.0,
                    ),
                  ),
                  Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.wb_sunny, color: Colors.amber, size: 24),
                    const SizedBox(width: 8),
                    Switch.adaptive(
                      value: themeProvider.isDarkTheme,
                      onChanged: (value) {
                        themeProvider.toggleTheme();
                      },
                      activeColor: MainTheme.background(context),
                      activeTrackColor: const Color(0xFFD13333),
                      inactiveThumbColor: Colors.amber,
                      inactiveTrackColor: Colors.amberAccent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                    ),
                    const SizedBox(width: 8),
                    const Icon(Icons.nightlight_round, color: Colors.indigo, size: 24),
                  ],
                ),
               ]
              ),
            ),
            ),
            Card(
              margin: const EdgeInsets.all(16.0),
              elevation: 10.0,
              child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 32.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    l10n.language,
                    style: TextStyle(
                      color: MainTheme.contrast(context),
                      fontSize: 14.0,
                    ),
                  ),
                  Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'ES',
                      style: TextStyle(
                        color: MainTheme.contrast(context),
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Switch.adaptive(
                      value: localeProvider.locale.languageCode == 'en',
                      onChanged: (value) {
                        if (value) {
                          localeProvider.setEnglish();
                        } else {
                          localeProvider.setSpanish();
                        }
                      },
                      activeColor: MainTheme.background(context),
                      activeTrackColor: const Color(0xFFD13333),
                      inactiveThumbColor: MainTheme.background(context),
                      inactiveTrackColor: const Color(0xFFD13333),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'EN',
                      style: TextStyle(
                        color: MainTheme.contrast(context),
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
               ]
              ),
            ),
            ),
            Card(
              margin: const EdgeInsets.all(16.0),
              elevation: 10.0,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    NavigationRow(
                      title: l10n.myProfile,
                      routeName: '/profile-details',
                    ),
                    const Divider(),
                    NavigationRow(
                      title: l10n.mySubscription,
                      routeName: '/subscription',
                      onTap: () async{
                        try{
                          await planProvider.fetchPlansAvailable();
                          Navigator.push(context, MaterialPageRoute(builder: (_) => const SubscriptionScreen()));
                        } catch (e){
                          Logger().e("Error while trying to fecth plans available: $e");
                        }
                      },
                    ),
                    const Divider(),
                    NavigationRow(
                      title: l10n.mySpaces,
                      routeName: '/my-spaces',
                    ),
                    const Divider(),
                    NavigationRow(
                      title: l10n.favorites,
                      routeName: '/favorites',
                      onTap: () async {
                        await spaceProvider.loadFavorites();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const FavoritesScreen(),
                          ),
                        );
                      },
                    ),
                    const Divider(),
                  ...[
                  if (signInProvider.userId == 1) ...[
                      NavigationRow(
                        title: l10n.subscription,
                        routeName: '/subscriptions-management',
                        onTap: () async {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SubscriptionsManagementScreen(),
                            ),
                          );
                        },
                      ),
                      const Divider(),
                    ],
                    NavigationRow(
                      title: l10n.support,
                      routeName: '/faqs',
                    ),
                    const Divider(),
                    NavigationRow(
                      title: l10n.reports,
                      routeName: '/show-reports',
                    ),
                    const Divider(),
                    NavigationRow(
                      title: l10n.logout,
                      routeName: '/login',
                      onTap: () async {
                        try {
                          await signInProvider.onLogOutRequest();
                        } finally {
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            "/login",
                                (Route<dynamic> route) => false,
                          );
                        }
                      },
                    )

                  ],
          ]       ),

              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final spaceProvider = Provider.of<SpaceProvider>(context);
    final favoriteSpaces = spaceProvider.favoriteSpaces;
    final themeProvider = Provider.of<ThemeProvider>(context);
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeProvider.isDarkTheme ? MainTheme.primary(context) : MainTheme.background(context),
        title: Text(
          l10n.favorites,
          style: TextStyle(color: MainTheme.contrast(context)),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.popAndPushNamed(context, '/search-space');
          },
        ),
      ),
      body: favoriteSpaces.isEmpty
          ? Center(child: Text(l10n.noFavorites))
          : ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              itemCount: favoriteSpaces.length,
              itemBuilder: (context, index) {
                final space = favoriteSpaces[index];
                return SpaceCard(
                  address: space.address,
                  price: space.price.toString(),
                  imageUrl: space.photoUrls[0],
                  id: space.id,
                  userId: space.userId!,
                );
              },
            ),
    );
  }
}

class NavigationRow extends StatelessWidget {
  final String title;
  final String routeName;
  final VoidCallback? onTap;

  const NavigationRow({
    super.key,
    required this.title,
    required this.routeName,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap ?? () => Navigator.pushNamed(context, routeName),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        margin: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                color: MainTheme.contrast(context),
              ),
            ),
             Icon(
              Icons.arrow_forward_ios,
              color: MainTheme.contrast(context),
            ),
          ],
        ),
      ),
    );
  }
}
