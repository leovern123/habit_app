# Nama Aplikasi App - Flutter Application

<div align="center">
<url>
  <img src="https://lms.global.ac.id/lms/pluginfile.php/1/theme_klass/footerlogo/1745232397/logo-global-institute-stroke.png" alt="Institut Teknologi dan Bisnis Bina Sarana Global" width="200"/>
  </div>
<div align="center">
Institut Teknologi dan Bisnis Bina Sarana Global <br>
FAKULTAS TEKNOLOGI INFORMASI & KOMUNIKASI 
<br>
https://global.ac.id/
  </div>

  ##  Project UAS
  - Mata Kuliah : Aplikasi Mobile
  - Kelas : TI 23 SE M-SH
  - Semester : GANJIL 
  - Tahun Akademik: 2025 - 2026 
  
  

## About The Project

Habit App adalah aplikasi mobile yang dikembangkan menggunakan Flutter untuk membantu pengguna membuat, melacak, dan mempertahankan kebiasaan sehari-hari. Aplikasi ini menekankan kemudahan penggunaan, sinkronisasi cloud menggunakan Firebase, serta dukungan offline menggunakan SQLite sehingga data tetap tersedia saat tidak ada koneksi internet.

Fitur utama berfokus pada:
- pembuatan habit (kebiasaan),
- pengingat berkala (reminder),
- statistik perkembangan (streaks & analytics),
- sinkronisasi otomatis ke Firebase,

### Key Features

- **Modern UI/UX Design** - Antarmuka yang clean dan user-friendly
- **Buat / Edit / Hapus Habit** - Atur frekuensi, reminder, target harian/mingguan
- **Streaks & Analytics** - Melihat progres harian dan ringkasan mingguan/bulana
- **Push Notifications** - Pengingat kebiasaan sesuai jadwal
- **Cloud Sync** - Sinkronisasi otomatis dengan Firebase

## Screenshots

<div align="center">
  <img src="screenshots/splash_screen.png" alt="Splash Screen" width="200"/>
  <img src="screenshots/login_screen.png" alt="Login" width="200"/>
  <img src="screenshots/home_screen.png" alt="Home" width="200"/>
  <img src="screenshots/profile_screen.png" alt="Profile" width="200"/>
</div>

<div align="center">
  <img src="screenshots/note_detail.png" alt="Note Detail" width="200"/>
  <img src="screenshots/search.png" alt="Search" width="200"/>
  <img src="screenshots/category.png" alt="Category" width="200"/>
  <img src="screenshots/settings.png" alt="Settings" width="200"/>
</div>

## Demo Video

Lihat video demo aplikasi kami untuk melihat semua fitur dalam aksi!

**[Watch Full Demo on YouTube](https://youtube.com/watch?v=dQw4w9WgXcQ)**

Alternative link: **[Google Drive Demo](https://drive.google.com/file/d/1234567890/view)**

## Download APK

Download versi terbaru aplikasi Notes App:

### Latest Release v1.0.0
- [**Download APK (15.2 MB)**](https://github.com/yourusername/notes-app/releases/download/v1.0.0/notes-app-v1.0.0.apk)


**Minimum Requirements:**
- Android 6.0 (API level 23) or higher
- ~20MB free storage space

## Built With

- **[Flutter](https://flutter.dev/)** - UI Framework
- **[Dart](https://dart.dev/)** - Programming Language
- **[Firebase](https://firebase.google.com/)** - Backend & Authentication
- **[SQLite](https://www.sqlite.org/)** - Local Database
- **[Provider](https://pub.dev/packages/provider)** - State Management


## Getting Started

### Prerequisites

Pastikan Anda sudah menginstall:
- Flutter SDK (3.16.0 or higher)
- Dart SDK (3.2.0 or higher)
- Android Studio / VS Code
- Git

### Installation

1. Clone repository
```bash
git clone git clone https://github.com/leovern123/habit_app.git
cd habit_app
```

2. Install dependencies
```bash
flutter pub get
```

3. Setup Firebase
```bash
# Download google-services.json dari Firebase Console
# Place in android/app/
cp path/to/google-services.json android/app/
```

4. Run aplikasi
```bash
flutter run
```

### Build APK

```bash
# Debug APK
flutter build apk --debug

# Release APK
flutter build apk --release

# Split APK by ABI
flutter build apk --split-per-abi
```

## 📁 Project Structure

```
lib/
├── core/
│   └── utils/
│       ├── date_helper.dart
│       ├── statistic_helper.dart
│       └── supabase_client.dart
├── features/
│   ├── auth/
│   │   ├── data/
│   │   │   └── auth_service.dart
│   │   └── presentation/
│   │       ├── login_page.dart
│   │       └── register_page.dart
│   ├── habit/
│   │   ├── data/
│   │   │   └── habit_service.dart
│   │   ├── model/
│   │   │   ├── habit_log_model.dart
│   │   │   └── habit_model.dart
│   │   └── presentation/
│   │       ├── habit_home/
│   │       │   ├── widgets/
│   │       │   │   ├── add_habit_bottom_sheet.dart
│   │       │   │   ├── habit_home_header.dart
│   │       │   │   ├── habit_today_item.dart
│   │       │   │   ├── habit_today_list.dart
│   │       │   │   └── habit_home_page.dart
│   │       ├── habit_list/
│   │       │   ├── widgets/
│   │       │   │   ├── confirm_delete_dialog.dart
│   │       │   │   ├── edit_habit_bottom_sheet.dart
│   │       │   │   ├── habit_list_empty.dart
│   │       │   │   ├── habit_list_filter.dart
│   │       │   │   ├── habit_list_header.dart
│   │       │   │   ├── habit_list_item.dart
│   │       │   │   └── habit_list_page.dart
│   │       └── habit_statistic/
│   │           ├── widgets/
│   │           │   ├── statistic_calendar_picker.dart
│   │           │   ├── statistic_date_filter.dart
│   │           │   ├── statistic_habit_list.dart
│   │           │   ├── statistic_summary.dart
│   │           │   └── statistic_weekly_grid.dart
│   │           └── habit_statistic_page.dart
│   ├── navigation/
│   │   └── main_navigation.dart
│   ├── profile/
│   │   ├── data/
│   │   │   ├── profile_service.dart
│   │   │   └── supabase_storage_service.dart
│   │   └── presentation/
│   │       ├── member_detail/
│   │       │   ├── profil_page_bagus.dart
│   │       │   ├── profil_page_faras.dart
│   │       │   ├── profil_page_haikal.dart
│   │       │   ├── profil_page_umar.dart
│   │       │   └── profil_page_zaqi.dart
│   │       └── widgets/
│   │           ├── about_team_page.dart
│   │           ├── edit_profile_page.dart
│   │           └── profile_page.dart
│   └── splash/
│       └── presentation/
│           ├── splash_screen_1.dart
│           ├── splash_screen_2.dart
│           ├── splash_screen_3.dart
│           ├── splash_screen_4.dart
│           └── splash_screen_5.dart
├── service/
│   ├── firebase_options.dart
└── main.dart
```

## Authentication Flow

```
1. Splash Screen (Auto-login check)
   ↓
2. Login Screen / Register Screen
   ↓
3. Home Screen (Dashboard)
   ↓
4. Profile & Settings
```

## 🗄️ Database Schema

### Notes Table
```sql
CREATE TABLE tableABC (
  id TEXT PRIMARY KEY,
  user_id TEXT NOT NULL,
  title TEXT NOT NULL,
  content TEXT,
  category_id TEXT,
  created_at INTEGER,
  updated_at INTEGER,
  is_synced INTEGER DEFAULT 0
);
```


## 📝 API Documentation

### Authentication Endpoints
- `POST /api/auth/register` - Register user baru
- `POST /api/auth/login` - Login user
- `POST /api/auth/logout` - Logout user
- `GET /api/auth/verify` - Verify token

### Development Workflow

1. Fork repository
2. Create feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to branch (`git push origin feature/AmazingFeature`)
5. Open Pull Request

## Team Members & Contributions

### Development Team

| Name | Role | Contributions |
|------|------|---------------|
| **Umar** | Project Lead & Backend Developer | - Spalash screen<br>- Authentication system<br>- Firebase integration<br>- API development<br>- Database design|
| **Zaqi** | Flutter Developer & Frontend Developer | - Spalash screen<br>- UI/UX Design<br>- Home screen implementation<br>- Profile screen<br>- State management<br>- Register screen |
| **Faras** | Frontend Developer | - Spalash screen<br>- Profile member screen |
| **Bagus** | Mobile Developer | - Spalash screen<br>- Push notifications (FCM)<br>- Notification system  |
| **Haikal** | Cyber Scurity | - Spalash screen<br>- Login Screen<br>- Testing  |


## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.



## Acknowledgments

- [Flutter Community](https://flutter.dev/community) - For amazing packages
- [Firebase](https://firebase.google.com/) - For backend services
- [Flaticon](https://www.flaticon.com/) - For app icons
- [Unsplash](https://unsplash.com/) - For placeholder images



---

<div align="center">
  <p>Made with by .... Team</p>
  <p>© 2026 Notes App. All rights reserved.</p>
</div>