import 'package:alquilafacil/auth/data/remote/helpers/auth_service_helper.dart';
import 'package:alquilafacil/auth/presentation/providers/ConditionTermsProvider.dart';
import 'package:alquilafacil/auth/presentation/providers/SignUpProvider.dart';
import 'package:alquilafacil/auth/presentation/screens/privacy-policy.dart';
import 'package:alquilafacil/auth/presentation/screens/terms.dart';
import 'package:alquilafacil/contact/presentation/screens/notifications_screen.dart';
import 'package:alquilafacil/management/presentation/screens/monitoring_screen.dart';
import 'package:alquilafacil/notification/data/remote/helpers/notification_service_helper.dart';
import 'package:alquilafacil/notification/presentation/providers/notification_provider.dart';
import 'package:alquilafacil/profile/data/remote/helpers/user_service_helper.dart';
import 'package:alquilafacil/profile/presentation/providers/profile_provider.dart';
import 'package:alquilafacil/profile/presentation/screens/calendar_screen.dart';
import 'package:alquilafacil/profile/presentation/screens/profile_details.dart';
import 'package:alquilafacil/profile/presentation/screens/profile_screen.dart';
import 'package:alquilafacil/public/ui/providers/theme_provider.dart';
import 'package:alquilafacil/public/ui/theme/main_theme.dart';
import 'package:alquilafacil/reservation/data/remote/helpers/reservation_service_helper.dart';
import 'package:alquilafacil/reservation/presentation/providers/reservation_provider.dart';
import 'package:alquilafacil/spaces/presentation/screens/create_report_screen.dart';
import 'package:alquilafacil/reservation/presentation/screens/modify_reservation_screen.dart';
import 'package:alquilafacil/reservation/presentation/screens/reservation_details_screen.dart';
import 'package:alquilafacil/spaces/data/remote/helpers/comment_service_helper.dart';
import 'package:alquilafacil/spaces/data/remote/helpers/local_categories_service_helper.dart';
import 'package:alquilafacil/spaces/data/remote/helpers/report_service_helper.dart';
import 'package:alquilafacil/spaces/data/remote/helpers/space_service_helper.dart';
import 'package:alquilafacil/spaces/presentation/providers/comment_provider.dart';
import 'package:alquilafacil/spaces/presentation/providers/local_categories_provider.dart';
import 'package:alquilafacil/spaces/presentation/providers/report_provider.dart';
import 'package:alquilafacil/spaces/presentation/providers/space_provider.dart';
import 'package:alquilafacil/spaces/presentation/screens/additional_details_screen.dart';
import 'package:alquilafacil/spaces/presentation/screens/comments_screen.dart';
import 'package:alquilafacil/spaces/presentation/screens/create_comment_screen.dart';
import 'package:alquilafacil/spaces/presentation/screens/filter_screen.dart';
import 'package:alquilafacil/spaces/presentation/screens/my_spaces_screen.dart';
import 'package:alquilafacil/spaces/presentation/screens/register_space_steps_screen.dart';
import 'package:alquilafacil/reservation/presentation/screens/space_info.dart';
import 'package:alquilafacil/spaces/presentation/screens/show_reports_screen.dart';
import 'package:alquilafacil/spaces/presentation/screens/spaces_details.dart';
import 'package:alquilafacil/spaces/presentation/screens/filter_spaces_district.dart';
import 'package:alquilafacil/spaces/presentation/screens/search_spaces.dart';
import 'package:alquilafacil/spaces/presentation/widgets/my_space_details.dart';
import 'package:alquilafacil/subscriptions/data/remote/helpers/plan_service_helper.dart';
import 'package:alquilafacil/subscriptions/data/remote/helpers/subscription_service_helper.dart';
import 'package:alquilafacil/subscriptions/presentation/provider/plan_provider.dart';
import 'package:alquilafacil/subscriptions/presentation/provider/subscription_provider.dart';
import 'package:alquilafacil/subscriptions/presentation/screens/subscription_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'auth/presentation/providers/SignInProvider.dart';
import 'auth/presentation/screens/login.dart';
import 'auth/presentation/screens/register.dart';
import 'contact/presentation/screens/faqs_screen.dart';
import 'contact/presentation/screens/support_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await initializeDateFormatting('es_ES');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final authServiceHelper = AuthServiceHelper();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SignInProvider(authServiceHelper)),
        ChangeNotifierProvider(create: (_) => SignUpProvider(authServiceHelper)),
        ChangeNotifierProvider(create: (_) => ConditionTermsProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProxyProvider<SignInProvider,PlanProvider>(
          create: (_) => PlanProvider(PlanServiceHelper(SignInProvider(authServiceHelper))),
          update: (context, signInProvider, previous) =>
              PlanProvider(PlanServiceHelper(signInProvider)),
        ),
        ChangeNotifierProxyProvider<SignInProvider,ReportProvider>(
          create: (_) => ReportProvider(ReportServiceHelper(SignInProvider(authServiceHelper))),
          update: (context, signInProvider, previous) =>
              ReportProvider(ReportServiceHelper(signInProvider)),
        ),
        ChangeNotifierProxyProvider<SignInProvider,SubscriptionProvider>(
          create: (_) => SubscriptionProvider(SubscriptionServiceHelper(SignInProvider(authServiceHelper))),
          update: (context, signInProvider, previous) =>
             SubscriptionProvider(SubscriptionServiceHelper(signInProvider)),
        ),
        ChangeNotifierProxyProvider<SignInProvider, NotificationProvider>(
          create: (_) => NotificationProvider(NotificationServiceHelper(SignInProvider(authServiceHelper))),
          update: (context, signInProvider, previous) =>
              NotificationProvider(NotificationServiceHelper(signInProvider)),
        ),
        ChangeNotifierProxyProvider<SignInProvider, SpaceProvider>(
          create: (_) => SpaceProvider(SpaceServiceHelper(SignInProvider(authServiceHelper))),
          update: (context, signInProvider, previous) =>
              SpaceProvider(SpaceServiceHelper(signInProvider)),
        ),
        ChangeNotifierProxyProvider<SignInProvider, LocalCategoriesProvider>(
          create: (_) => LocalCategoriesProvider(LocalCategoriesServiceHelper(SignInProvider(authServiceHelper))),
          update: (context, signInProvider, previous) =>
              LocalCategoriesProvider(LocalCategoriesServiceHelper(signInProvider)),
        ),
        ChangeNotifierProxyProvider<SignInProvider, ProfileProvider>(
          create: (_) => ProfileProvider(UserServiceHelper(SignInProvider(authServiceHelper))),
          update: (context, signInProvider, previous) =>
              ProfileProvider(UserServiceHelper(signInProvider)),
        ),
        ChangeNotifierProxyProvider<SignInProvider, ReservationProvider>(
          create: (_) => ReservationProvider(ReservationServiceHelper(SignInProvider(authServiceHelper))),
          update: (context, signInProvider, previous) =>
              ReservationProvider(ReservationServiceHelper(signInProvider)),
        ),
        ChangeNotifierProxyProvider<SignInProvider, CommentProvider>(
          create: (_) => CommentProvider(CommentServiceHelper(SignInProvider(authServiceHelper))),
          update: (context, signInProvider, previous) =>
              CommentProvider(CommentServiceHelper(signInProvider)),
        ),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            theme: themeProvider.currentTheme,
            locale: const Locale('es', 'ES'),
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('es', 'ES'),
            ],
            initialRoute: "/",
            routes: {
              "/": (context) => _buildInitialScreen(context.read<SignInProvider>()),
              "/login": (context) => const Login(),
              "/sign-up": (context) => const Register(),
              "/terms": (context) => const TermsScreen(),
              "/privacy-policy": (context) => const PrivacyPolicyScreen(),
              "/search-space": (context) => const SearchSpaces(),
              "/tutorial-space": (context) => const RegisterSpaceStepsScreen(),
              "/filter-spaces": (context) => const FilterSpacesDistrict(),
              "/spaces-details": (context) => const SpacesDetails(),
              "/filter-screen": (context) => const FilterScreen(),
              "/notifications": (context) => const NotificationsScreen(),
              "/calendar": (context) => const CalendarScreen(),
              "/profile": (context) => const ProfileScreen(),
              "/space-info": (context) => const SpaceInfo(),
              "/comments": (context) => const CommentsScreen(),
              "/profile-details": (context) => const ProfileDetails(),
              "/my-spaces": (context) => const MySpacesScreen(),
              "/reservation-details": (context) => const ReservationDetailsScreen(),
              '/my-space-info': (context) => const MySpaceDetails(),
              "/create-comments" : (context) => const CreateCommentScreen(),
              "/space-features": (context) => const AdditionalDetailsScreen(),
              "/subscription" : (context) => const SubscriptionScreen(),
              "/create-report": (context) => const CreateReportScreen(),
              "/show-reports": (context) => const ShowReportsScreen(),
              "/support": (context) => const SupportScreen(),
              "/faqs": (context) => const FaqsScreen(),
              "/modify-reservation": (context) => const ModifyReservationScreen(),
              "/monitoring": (context) => const MonitoringScreen()
            },
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }

  Widget _buildInitialScreen(SignInProvider signInProvider) {
    return FutureBuilder<bool>(
      future: signInProvider.onSessionActive(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError || snapshot.data == null || !snapshot.data!) {
          return const Login();
        }

        return const SearchSpaces();
      },
    );
  }

}
