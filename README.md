# Superstore Data Warehouse Project (UAS)

Proyek ini adalah implementasi **Data Warehouse (DWH)** menggunakan dataset **Retail Superstore** dari Kaggle. Proyek ini dikerjakan sebagai tugas akhir (UAS) untuk mata kuliah Data Warehouse, dengan tujuan mengintegrasikan data operasional ke dalam skema bintang (*star schema*) untuk kebutuhan analisis bisnis.

## Anggota Tim
- **Bimo Abdul Aziz**
- **Abdul Fattah Firdaus**

## Struktur Proyek
Repositori ini disusun dengan struktur berikut:

* **`database/`**: Berisi file SQL untuk pembuatan skema database.
    * `query_olap_superstore.sql`: Skrip DDL untuk membuat tabel dimensi dan fakta.
* **`etl/`**: Berisi file transformasi dan job Pentaho Data Integration (PDI).
    * `dim_customer.ktr`: Transformasi untuk data pelanggan.
    * `dim_location.ktr`: Transformasi untuk data lokasi.
    * `dim_product.ktr`: Transformasi untuk data produk.
    * `dim_time.ktr`: Transformasi untuk data waktu.
    * `fact_sales.ktr`: Transformasi untuk tabel fakta penjualan.
    * `MainJob.kjb`: Job utama untuk menjalankan seluruh proses ETL secara otomatis.
* **`dataset/`**: Folder untuk menyimpan file sumber data (CSV).
* **`assets/`**: Berisi dokumentasi visual seperti ERD dan hasil analisis.

## Arsitektur Data Warehouse
![Schema ERD Proyek](documentations/erd%20superstore%20dwh.png)

Proyek ini menggunakan **Star Schema** yang terdiri dari:

1.  **Tabel Fakta**: `fact_sales` (menyimpan metrik transaksi seperti Sales, Profit, Quantity).
2.  **Tabel Dimensi**:
    * `dim_customer`: Informasi pelanggan.
    * `dim_product`: Detail kategori dan nama produk.
    * `dim_location`: Informasi geografis (City, State, Country).
    * `dim_time`: Detail waktu berdasarkan Order Date.

## Langkah-Langkah Instalasi & Penggunaan

### 1. Persiapan Database
- Pastikan Anda memiliki **PostgreSQL** yang berjalan.
- Buat database baru (misal: `superstore_dwh`).
- Jalankan skrip SQL yang ada di `/database/query_olap_superstore.sql` untuk membuat tabel.

### 2. Konfigurasi ETL (Pentaho)
- Buka **Pentaho Data Integration (Spoon)**.
- Buka file-file `.ktr` di folder `/etl/`.
- Sesuaikan koneksi database (DB Connection) pada setiap file transformasi agar terhubung ke database lokal Anda.
- Letakkan file dataset `Superstore.csv` ke dalam folder yang sesuai atau sesuaikan path pada step *CSV Input*.

### 3. Menjalankan Job
- Buka `MainJob.kjb`.
- Jalankan (*Run*) job tersebut untuk memproses data dari CSV ke Data Warehouse secara otomatis.

## Visualisasi & Hasil
Setelah ETL selesai, data siap dianalisis menggunakan tools seperti Power BI, Tableau, atau SQL kueri untuk mendapatkan insight bisnis mengenai performa penjualan, profitabilitas per kategori, dan tren pasar.

## 📜 Lisensi
Proyek ini dilisensikan di bawah **MIT License**. Lihat file [LICENSE](LICENSE) untuk informasi lebih lanjut.
