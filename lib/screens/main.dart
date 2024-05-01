import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_eatit_new/model/change_theme_button_widget.dart';
import 'package:provider/provider.dart';
import 'package:auto_animated/auto_animated.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_eatit_new/model/cart_model.dart';
import 'package:flutter_eatit_new/model/restaurant_model.dart';
import 'package:flutter_eatit_new/screens/login.dart';
import 'package:flutter_eatit_new/screens/restaurant_home.dart';
import 'package:flutter_eatit_new/state/cart_state.dart';
import 'package:flutter_eatit_new/state/main_state.dart';
import 'package:flutter_eatit_new/strings/main_strings.dart';
import 'package:flutter_eatit_new/utils/const.dart';
import 'package:flutter_eatit_new/view_model/main_vm/main_view_model_imp.dart';
import 'package:flutter_eatit_new/widgets/common/common_widgets.dart';
import 'package:flutter_eatit_new/widgets/main/main_widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_eatit_new/provider/theme_mode.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseApp app = await Firebase.initializeApp();
  await GetStorage.init();
  final User? user = FirebaseAuth.instance.currentUser;
  runApp(MyApp(app: app, user: user));

}

class MyApp extends StatelessWidget {
  final FirebaseApp app;
  final User? user;


  MyApp({required this.app, this.user});

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      builder: (context, _) {
        final themeProvider = Provider.of<ThemeProvider>(context);
        return GetMaterialApp(
          title: "",
          themeMode: themeProvider.themeMode,
          theme: MyThemes.lightTheme,
          darkTheme: MyThemes.darkTheme,
          home: Login(app: app),
        );
      });
}

class MyHomePage extends StatefulWidget {
  final FirebaseApp app;
  final viewModel = MainViewModelImp();
  final mainStateController = Get.put(MainStateController());
  final cartStateController = Get.put(CartStateController());
  final box = GetStorage();
  final User user;

  MyHomePage({required this.app, required this.user});

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) async{
      if(widget.box.hasData(MY_CART_KEY))
      {
        var cartSave = await widget.box.read(MY_CART_KEY) as String;
        if(cartSave.length > 0 && cartSave.isNotEmpty)
        {
          final listCart = jsonDecode(cartSave) as List<dynamic>;
          final listCartParsed = listCart.map((e)=>CartModel.fromJson(e)).toList();
          if(listCartParsed.length>0)
            widget.cartStateController.cart.value = listCartParsed;
        }
      }
      else
        widget.cartStateController.cart.value = new List<CartModel>.empty(growable: true);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          restaurantText,
          style: GoogleFonts.jetBrainsMono(
            fontWeight: FontWeight.w900,
            // color: Colors.black,
          ),
        ),
        actions: [
          ChangeThemeButtonWidget(),
        ],
        backgroundColor: Colors.red.shade900,
        elevation: 10,

          ),


      body: FutureBuilder(
        future: widget.viewModel.displayRestaurantList(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            var lst = snapshot.data as List<RestaurantModel>;

            return Container(
              margin: const EdgeInsets.only(top: 10),
              child: LiveList(
                showItemDuration: Duration(milliseconds: 350),
                showItemInterval: Duration(milliseconds: 150),
                reAnimateOnVisibility: true,
                scrollDirection: Axis.vertical,
                itemCount: lst.length,
                itemBuilder: animationItemBuilder((index) => InkWell(
                  onTap: () {
                    MyHomePageState homePageState = context.findAncestorStateOfType<MyHomePageState>()!;
                    homePageState.widget.mainStateController.selectedRestaurant.value = lst[index];
                    Get.to(() => RestaurantHome(app: widget.app,user: widget.user,));
                  },
                  child: Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height / 2.5 * 1.1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RestaurantImageWidget(imageUrl: lst[index].imageUrl),
                        RestaurantInfoWidget(
                          name: lst[index].name,
                          address: lst[index].address,
                        )
                      ],
                    ),
                  ),
                )),
              ),
            );
          }
        },
      )
    );
  }
}
