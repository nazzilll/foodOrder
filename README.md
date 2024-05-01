# Food Order App

sebuah aplikasi Flutter yang digunakan untuk memesan makanan dari restoran-restoran tertentu.

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

## Bookmark/Favourite:
Karena tema aplikasi kami adalah pemesanan, maka kami menerapkan pada keranjang/cart. Kami menggunakan dependencies GetStorage.
![image](https://github.com/nazzilll/foodOrder/assets/153486062/7b887f2a-d13c-417d-b2c4-aca646dd362d)

Pada bagian badgeContent, kita menggunakan fungsi cartStateController.getQuantity(mainStateController.selectedRestaurant.value.restaurantId) untuk mendapatkan jumlah item di keranjang dari CartStateController. Jumlah ini kemudian ditampilkan di atas ikon keranjang belanja sebagai badge.

Ketika aplikasi ditutup dan dibuka kembali, nilai di badge akan tetap konsisten dengan jumlah item di keranjang yang disimpan dalam GetStorage, karena nilai tersebut dipulihkan saat aplikasi dibuka kembali.

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



