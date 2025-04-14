import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'features/auth/presentation/pages/login_page.dart';
import 'features/order/presentation/pages/sales_clerk_dashboard.dart';
import 'features/auth/presentation/pages/user_management.dart';
import 'features/product/presentation/pages/admin_dashboard.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(360, 690), // Set your design size here
      builder: (context, child) {
        return MaterialApp.router(
          routerDelegate: _router.routerDelegate,
          routeInformationParser: _router.routeInformationParser,
          title: 'Clean Architecture Flutter',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
        );
      },
    );
  }

  final GoRouter _router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => LoginPage(),
      ),
      GoRoute(
        path: '/dashboard',
        builder: (context, state) => AdminDashboard(),
      ),
      GoRoute(
        path: '/sales-clerk',
        builder: (context, state) => SalesClerkDashboard(),
      ),
      GoRoute(
        path: '/user-management',
        builder: (context, state) => UserManagement(),
      ),
    ],
  );
}
