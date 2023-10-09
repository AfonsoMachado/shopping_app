import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/models/auth.dart';
import 'package:shopping_app/models/cart.dart';
import 'package:shopping_app/models/order_list.dart';
import 'package:shopping_app/models/product_list.dart';
import 'package:shopping_app/pages/auth_or_home_page.dart';
import 'package:shopping_app/pages/cart_page.dart';
import 'package:shopping_app/pages/orders_page.dart';
import 'package:shopping_app/pages/product_detail_page.dart';
import 'package:shopping_app/pages/product_form_page.dart';
import 'package:shopping_app/pages/products_page.dart';
import 'package:shopping_app/utils/app_routes.dart';

Future<void> main() async {
  await dotenv.load(fileName: '.env');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Auth()),
        // Inserindo o provider de produtos como uma dependência do provider de autenticação
        ChangeNotifierProxyProvider<Auth, ProductList>(
          create: (_) => ProductList(),
          update: (BuildContext context, Auth auth, ProductList? previous) {
            return ProductList(
                auth.token ?? '', auth.userId ?? '', previous?.items ?? []);
          },
        ),
        ChangeNotifierProxyProvider<Auth, OrderList>(
          create: (_) => OrderList(),
          update: (BuildContext context, Auth auth, OrderList? previous) {
            return OrderList(auth.token ?? '', previous?.items ?? []);
          },
        ),
        ChangeNotifierProvider(create: (_) => Cart()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: Colors.purple,
            secondary: Colors.deepOrange,
          ),
          fontFamily: 'Lato',
        ),
        // home: const ProductsOverviewPage(),
        debugShowCheckedModeBanner: false,
        routes: {
          AppRoutes.authOrHome: (ctx) => const AuthOrHomePage(),
          AppRoutes.productDetail: (ctx) => const ProductDetailPage(),
          AppRoutes.cart: (ctx) => const CartPage(),
          AppRoutes.orders: (ctx) => const OrdersPage(),
          AppRoutes.products: (ctx) => const ProductsPage(),
          AppRoutes.productForm: (ctx) => const ProductFormPage(),
        },
      ),
    );
  }
}
