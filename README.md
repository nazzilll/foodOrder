# Food Order App

sebuah aplikasi Flutter yang digunakan untuk memesan makanan dari restoran-restoran tertentu.
## Penjelasan Folder
- Firebase: Folder ini berisi file-file terkait dengan integrasi dan interaksi aplikasi dengan Firebase, seperti pengaturan Firebase, referensi database, atau pengelolaan otentikasi pengguna.
- Model: Folder ini berisi definisi kelas atau model data yang digunakan dalam aplikasi untuk merepresentasikan entitas seperti makanan, kategori, keranjang belanja, dll.
- State: Folder ini berisi file-file terkait dengan manajemen state dalam aplikasi, seperti controller untuk manajemen state keranjang belanja, kategori yang dipilih, restoran yang dipilih, dsb.
- Utils: Folder ini berisi utilitas atau fungsi bantuan yang dapat digunakan secara global dalam aplikasi, seperti konstanta, format angka, atau fungsi-fungsi umum lainnya.
- View_Model: Folder ini berisi definisi view model yang digunakan untuk mengelola logika tampilan (UI) aplikasi, seperti mengambil data dari database atau mengubah state aplikasi.
- Widget: Folder ini berisi komponen-komponen widget yang dapat digunakan kembali dalam berbagai bagian aplikasi, seperti widget untuk menampilkan gambar dari URL, atau widget untuk menampilkan informasi keranjang belanja.
- Screen: Folder ini berisi file-file terkait dengan tampilan (UI) aplikasi, seperti halaman-halaman (screen) yang digunakan dalam navigasi aplikasi seperti halaman keranjang belanja, halaman kategori, halaman detail makanan, dll.

## Penerapan Asynchronous Programming
### 1. Firebase Operations:
![Screenshot 2024-05-01 215238](https://github.com/nazzilll/foodOrder/assets/153486062/09679aed-bc90-4626-8ae0-303c22d515b1)
### 2. Data Loading:
![image](https://github.com/nazzilll/foodOrder/assets/153486062/bf9f2a2e-f448-444e-b0d5-870cd40fc6db)
### 3. UI Update:
![image](https://github.com/nazzilll/foodOrder/assets/153486062/4b0e1ed8-3f19-47ee-bab4-431d586f268e)
### 4. Progress Indicator:
![image](https://github.com/nazzilll/foodOrder/assets/153486062/7143ef2a-f476-4f8b-a5cd-b6b4edf61105)
### 5. Navigasi:
![image](https://github.com/nazzilll/foodOrder/assets/153486062/2f7eabc6-526f-4e36-9fbb-fb66d5c15724)
### 6. File Operations:
![image](https://github.com/nazzilll/foodOrder/assets/153486062/a4f48cf2-ae46-459f-8189-27ddedd1be53)

Dalam contoh-contoh di atas, asynchronous programming digunakan dengan menggunakan kata kunci async dan await untuk menunggu hasil operasi yang memerlukan waktu, seperti pengambilan data dari server atau operasi file. Hal ini membantu menjaga responsivitas aplikasi dan menghindari pembekuan UI selama operasi berlangsung.

## Penerapan Theme Mode:
### Light Mode
![image](https://github.com/nazzilll/foodOrder/assets/153486062/1a874e86-560f-473b-92ec-a7510d820db9)
### Dark Mode
![image](https://github.com/nazzilll/foodOrder/assets/153486062/8ad9c8d1-d232-4e74-b12a-8f0f329d976c)

Dengan menggunakan SharedPreferences untuk menyimpan tema, skema tema yang tersimpan akan disesuaikan dengan kode yang Anda telah berikan. Berikut adalah penjelasan tentang bagaimana skema tema disimpan dan diterapkan saat aplikasi ditutup dan dibuka kembali:

1. Penyimpanan Tema:
- Saat aplikasi dimulai, kelas ThemeProvider akan memuat tema yang tersimpan dari SharedPreferences melalui metode _loadTheme().
- Jika tidak ada tema yang tersimpan sebelumnya, maka tema default yang akan digunakan adalah tema light.
- Jika ada tema yang tersimpan dan memiliki nilai 'dark', maka tema gelap akan diterapkan. Jika nilainya 'light' atau nilai yang tidak valid, maka tema terang akan diterapkan.
- Metode _loadTheme() dipanggil dalam konstruktor ThemeProvider untuk memastikan tema yang tepat diterapkan saat aplikasi dimulai.
2. Pengubahan Tema:
- Ketika pengguna mengubah tema melalui tombol yang disediakan oleh ChangeThemeButtonWidget, tema yang dipilih akan disimpan dalam SharedPreferences dengan metode toggleTheme(bool isOn).
- Metode ini mengubah themeMode sesuai dengan pilihan pengguna dan menyimpan nilai tema yang dipilih (gelap atau terang) ke SharedPreferences.
3. Penerapan Tema:
- Tema yang dipilih akan diterapkan dalam kelas MyApp di dalam widget MaterialApp.
- Pada saat membangun MaterialApp, ThemeProvider disediakan ke ChangeNotifierProvider agar bisa diakses oleh seluruh widget dalam pohon widget.
- ThemeProvider digunakan untuk menentukan themeMode yang akan diterapkan pada MaterialApp, yang kemudian akan menentukan tema yang akan digunakan (light atau dark) berdasarkan pilihan pengguna atau tema yang disimpan sebelumnya.
Dengan cara ini, skema tema yang dipilih akan disimpan menggunakan SharedPreferences, sehingga tema yang dipilih akan diingat dan diterapkan kembali saat pengguna menutup dan membuka kembali aplikasi.

## Bookmark/Favourite:
Karena tema aplikasi kami adalah pemesanan, maka kami menerapkan pada keranjang/cart. Kami menggunakan dependencies GetStorage.
// cart_state.dart

import 'dart:convert';

import 'package:flutter_eatit_new/model/cart_model.dart';
import 'package:flutter_eatit_new/model/food_model.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../strings/cart_string.dart';
import '../utils/const.dart';

class CartStateController extends GetxController {
  var cart = List<CartModel>.empty(growable: true).obs;
  final box = GetStorage();

  // ...

  Future<void> addToCart(FoodModel foodModel, String restaurantId,
      {int quantity = 1}) async {
    try {
      // Buat objek CartModel dari FoodModel
      var cartItem = CartModel(
        id: foodModel.id,
        name: foodModel.name,
        description: foodModel.description,
        image: foodModel.image,
        price: foodModel.price,
        addon: foodModel.addon,
        size: foodModel.size,
        quantity: quantity,
        restaurantId: restaurantId,
      );
      if (isExists(cartItem, restaurantId)) {
        // Jika item sudah ada dalam keranjang, update jumlahnya
        var foodNeedToUpdate =
            cart.firstWhere((element) => element.id == cartItem.id);
        foodNeedToUpdate.quantity += quantity;
      } else {
        // Jika item belum ada dalam keranjang, tambahkan ke keranjang
        cart.add(cartItem);
      }
      // Encode cart menjadi JSON
      var jsonDBEncode = jsonEncode(cart);
      // Simpan ke Get Storage
      await box.write(MY_CART_KEY, jsonDBEncode);
      cart.refresh(); // Refresh keranjang
      Get.snackbar(successTitle, successMessage); // Tampilkan snackbar
    } catch (e) {
      Get.snackbar(errorTitle, e.toString());
    }
  }

  // ...

  bool isExists(CartModel cartItem, String restaurantId) =>
      cart.any((e) => e.id == cartItem.id && e.restaurantId == restaurantId);

  // ...
}

Dalam kode di atas, saat pengguna menambahkan item ke keranjang, fungsi addToCart akan dijalankan. Objek CartModel dibuat berdasarkan FoodModel, kemudian dicek apakah item sudah ada dalam keranjang atau belum. Jika sudah ada, jumlahnya akan diupdate; jika belum, item akan ditambahkan ke keranjang. Setelah itu, keranjang diencode menjadi JSON dan disimpan ke Get Storage.


## Screen
![image](https://github.com/nazzilll/foodOrder/assets/153486062/e6bfbe90-fbe0-42f9-b09b-c2a09fdb7e2c)
![image](https://github.com/nazzilll/foodOrder/assets/153486062/4ba53b49-b31b-48be-9b8f-3982bbb74a18)
![image](https://github.com/nazzilll/foodOrder/assets/153486062/10ae3f66-9fd0-426d-b53c-e27b6b99323b)
![image](https://github.com/nazzilll/foodOrder/assets/153486062/8a1728b3-af01-4561-ba05-9ec7d307235b)
![image](https://github.com/nazzilll/foodOrder/assets/153486062/5ba125b0-529d-4b58-b498-403d4bbceb3a)
![image](https://github.com/nazzilll/foodOrder/assets/153486062/7667d97c-296e-43db-a176-edca89c7d2c7)
![image](https://github.com/nazzilll/foodOrder/assets/153486062/552be820-445c-4a1b-8f9d-ed94daeaffc7)
![image](https://github.com/nazzilll/foodOrder/assets/153486062/7eee446b-f58a-43ec-b938-ae2e46595606)
![image](https://github.com/nazzilll/foodOrder/assets/153486062/d339e049-4a71-4818-8af5-2458496f4685)



