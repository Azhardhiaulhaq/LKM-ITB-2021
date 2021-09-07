class AppData{
  // static List<Category> categoryList = [
  //   Category(id:1,name:"Semua",isSelected:true,icon:Icons.store),
  //   Category(id:2,name:"Makanan",icon:Icons.fastfood),
  //   Category(id:3,name:"Pakaian",icon:Icons.emoji_people),
  //   Category(id:4,name:"Kesenian",icon:Icons.emoji_nature),
  // ];

  static Map<String,String> mapFaculty = {
    'FITB' : 'Fakultas Ilmu dan Teknologi Kebumian',
    'FMIPA' : 'Fakultas Matematika dan Ilmu Pengetahuan Alam',
    'FTI' : 'Fakultas Teknik Industri',
    'FTMD' : 'Fakultas Teknik Mesin dan Dirgantara',
    'FTTM' : 'Fakultas Teknik Pertambangan dan Perminyakan',
    'FTSL' : 'Fakultas Teknik Sipil dan Lingkungan',
    'FSRD' : 'Fakultas Seni Rupa dan Desain',
    'SAPPK' : 'Sekolah Arsitektur, Perencanaan dan Pengembangan Kebijakan',
    'SBM' : 'Sekolah Bisnis dan Manajemen',
    'SF' : 'Sekolah Farmasi',
    'SITH R' : 'Sekolah Ilmu dan Teknologi Hayati Program Rekayasa',
    'SITH S' : 'Sekolah Ilmu dan Teknologi Hayati Program Sains',
    'STEI' : 'Sekolah Teknik Elektro dan Informatika'
  };

  static Map<String,String> mapOrgType = {
    'HMJ' : 'Himpunan Mahasiswa Jurusan',
    'UKM' : 'Unit Kegiatan Mahasiswa',
    'KM' : 'Keluarga Mahasiswa',
  };

  static Map<String, Map<String,String>> mapOrganization = {
    'HMJ' : {
      'TRITON ITB' : 'Himpunan Mahasiswa Osanografi',
      "HMME 'ATMOSPHAIRA' ITB " : 'Himpunan Mahasiswa Meteorologi',
      'IMG ITB' : 'Ikatan Mahasiswa Geodesi',
      "HMTG 'GEA' ITB" : 'Himpunan Mahasiswa Teknik Geologi',
      'HIMASTRON ITB' : 'Himpunan Mahasiswa Astronomi',
      'HIMAFI ITB' : 'Himpunan Mahasiswa Fisika',
      "HMK 'AMISCA' ITB" : 'Himpunan Mahasiswa Kimia',
      'HIMATIKA ITB' : 'Himpunan Mahasiswa Matematika',
      'HIMATEK ITB' : 'Himpunan Mahasiswa Teknik Kimia',
      'MTI ITB' : 'Keluarga Mahasiswa Teknik Industri',
      'HMFT ITB' : 'Himpunan Mahasiswa Fisika Teknik',
      'HMPG ITB' : 'Himpunan Mahasiswa Teknik Pangan',
      "HMTB 'RINUVA' ITB" :'Himpunan Mahasiswa Teknik Bioenergi dan Kemurgi',
      'HMM ITB' : 'Himpunan Mahasiswa Mesin',
      "KMPN 'OTTO LILIENTHAL' ITB" : 'Keluarga Mahasiswa teknik Penerbangan',
      'MTM ITB' : 'Himpunan Mahasiswa Teknik Material',
      "HIMA TG 'TERRA' ITB" : 'Himpunan Mahasiswa Teknik Geofisika',
      'IMMG ITB' : 'Ikatan Mahasiswa Metalurgi',
      "HMTM 'PATRA' ITB" : "Himpunan Mahasiswa Teknik Perminyakan 'Patra'",
      'HMT ITB' : 'Himpunan Mahasiswa Tambang',
      'HMS ITB' : 'Himpunan Mahasiswa Sipil',
      'HMTL ITB' : 'Himpunan Mahasiswa Teknik Lingkungan',
      'KMKL ITB' : 'Keluarga Mahasiswa Teknik Kelautan',
      'HIMASDA ITB' : 'Himpunan Mahasiswa Sumber Daya Air',
      'KMIL ITB' : 'Keluagra Mahasiswa Infrastruktur Lingkungan',
      'IMDI ITB' : 'Ikatan Mahasiswa Desain Interior',
      'VASA ITB' : 'Visual Art Student Aggregate',
      'INDDES ITB'  : 'Keluarga Mahasiswa Desain Produk',
      'TERIKAT ITB' : 'Himpunan Mahasiswa kriya Tekstil dan Keramik',
      'IPPDIG ITB' : 'Ikatan Pemuda Pemudi Desain Grafis',
      'IMA-G ITB' : 'Ikatan Mahasiswa Arsitektur Gunadharma',
      "HMP 'PANGRIPTA LOKA' ITB" : 'Himpunan Mahasiswa Teknik Perencanaan Wilayah dan Kota',
      'KMM ITB' : 'Keluarga Mahasiswa Manajemen',
      "IMK 'ARTHA' ITB" : 'Ikatan Mahasiswa Kewirausahaan',
      "HMF 'ARS PRAEPARANDI' ITB" : 'Himpunan Mahasiswa Farmasi',
      'HMRH ITB' : 'Himpunan Mahasiswa Rekayasa Hayati',
      "HMH 'SELVA' ITB" : ' Himpunan Mahasiswa Rekayasa Pertanian',
      "HIMAREKTA 'AGRAPANA' ITB" : 'Himpunan Mahasiswa Rekayasa Pertanian',
      "HMPP 'Vadra' ITB" : 'Himpunan Mahasiswa Teknologi Pascapanen',
      "HIMABIO 'NYMPHAEA' ITB" : 'Himpunan Mahasiswa Biologi',
      "HIMAMIKRO 'ARCHAEA' ITB" : 'Himpunan Mahasiswa Mikrobiologi',
      'HME ITB' : 'Himpunan Mahasiswa Elektroteknik',
      'HMIF ITB' : 'Himpunan Mahasiswa Informatika',
      "IMG 'SIGNUM' ITB" : 'Ikatan Mahasiswa Telekomunikasi'
    },
  'UKM' : {
    '8EH ITB' : '8EH Radio',
    'AIESEC ITB' : 'Aiesec in Bandung',
    'AIKIDO ITB' : 'Aikido',
    'AKSANTARA ITB' : 'Aksantara',
    'ARC ITB' : 'Amateur Radio Club',
    'ATLAS ITB' : 'Atletik Ganesha',
    'CAPOERA ITB' : 'Capoeira Brasil',
    'GAJAH NGOMIK ITB' : 'Gajah Ngomik',
    'GIM ITB' : 'Ganesha Interactive Media',
    'GMUN ITB' : 'Ganesha Model United National Club',
    'GLACIEM SKATING ITB' : 'Glaciem Skating',
    'ISH TIBEN ITB' : "Institut Sosial Humaniora 'Tiang Bendera'",
    'INFINITY ITB' : 'ITB Dance and Performance Art Community',
    'ISO ITB' : 'ITB Student Orchestra',
    'ITBJAZZ' : 'ITBJazz',
    'KSEP ITB' : 'Kelompok Studi Ekonomi dan Pasar Modal',
    'KMB ITB' : 'Keluarga Mahasiswa Buddha',
    'KMH ITB' : 'Keluarga Mahasiswa Hindu',
    'GAMAIS ITB' : 'Keluarga Mahasiswa Islam',
    'KAMIL Pascasarjana ITB' : 'Keluarga Mahasiswa Islam Pascasarjana',
    "KMJ 'SIGINJAI' ITB" : 'Keluarga Mahasiswa Jambi',
    'KMK ITB' : 'Keluarga Mahasiswa Katolik',
    'KMPA GANESHA ITB' : 'Keluarga Mahasiswa Pecinta Alam Ganesha',
    'KPA ITB' : 'Keluarga Paduan Angklung',
    'KOKESMA ITB' : 'Koperasi Kesejahteraan Mahasiswa',
    'KCC ITB' : 'Korean Culture Club',
    'KSR PMI UNIT ITB' : 'Korp Sukarela Palang Merah Indonesia',
    'BOULEVARD ITB' : 'Lembaga Pers Mahasiswa Boulevard',
    'LFM ITB' : 'Liga Film Mahasiswa',
    'LS ITB' : 'Lingkar Sastra',
    'LSS ITB' : 'Lingkung Seni Sunda',
    'LOEDROEK ITB' : 'LOEDROEK',
    'MGG ITB' : 'Maha Gotra Ganesha',
    'MUSI ITB' : 'Mahasiswa Bumi Sriwijaya',
    'MAJALAH GANESHA ITB' : 'Majalah Ganesha',
    'MBWG ITB' : 'Marching Band Waditra Ganesha',
    'PSM ITB' : 'Paduan Suara Mahasiswa',
    'PELITA MUDA ITB' : 'Pelita Muda',
    'PSTK ITB' : 'Perkumpulan Seni Tari dan Karawitan Jawa',
    'PSIK ITB' : 'Perkumpulan Studi Ilmu Kemasyarakatan',
    'PERSMA ITB' : 'Pers Mahasiswa',
    'PERCAMA ITB' : 'Persatuan Catur Mahasiswa',
    'PS ITB' : 'Persatuan Sepakbola',
    'PSHT ITB' : 'Persaudaraan Setia Hati Terate',
    'PMK ITB' : 'Persekutuan Mahasiswa Kristen',
    'GENSHIKEN ITB' : 'Pop Culture Enthusiast Club Genshiken',
    'PRAMUKA ITB' : 'Pramuka',
    'RK ITB' : 'Radio Kampus',
    'MENWA ITB' : 'Resimen Mahasiswa Mahwarman Batalyon I/ITB',
    'SKOR HOKI ITB' : 'Satuan kegiatan Olah Raga Hoki',
    'KEMPO ITB' : 'Shorinji Kempo',
    'SOLVE IT ITB' : 'Solve It',
    'SEF ITB' : 'Student English Forum',
    'STEMA ITB' : 'Studi Teater Mahasiswa',
    'TEC ITB' : 'Techno Entrepreneur Club',
    'U-GREEN ITB': 'U-Green',
    'UAB ITB' : 'Unit Aktivitas Bridge',
    'UATM ITB' : 'Unit Aktivitas Tenis Meja',
    'APRES! ITB' : 'Unit Apresiasi Seni Musik',
    'UBG ITB' : 'Unit Basket Ganesha',
    'UBV ITB' : 'Unit Bola Voli',
    'UBALA ITB' : 'Unit Budaya Lampung',
    'UBT ITB' : 'Unit Bulu Tangkis',
    'UFF ITB GT' : 'Unit Flag Football Ganesha Touchdown',
    'KARATE ITB' : 'Unit Karate',
    'UKA ITB' : 'Unit Kebudayaan Aceh',
    'DEBUST ITB' : 'Unit Kebudayaan Banten Debust',
    'UKAWANGI ITB' : 'Unit Kebudayaan Banyuwangi',
    'UKB ITB' : 'Unit Kebudayaan Betawi',
    'UKIR ITB' : 'Unit Kebudayaan Irian',
    'UKJ ITB' : 'Unit Kebudayaan Jepang',
    'UKK ITB' : 'Unit Kebudayaan Kalimantan',
    'UKMR ITB' : 'Unit Kebudayaan Melayu Riau',
    'UKT ITB' : 'Unit Kebudayaan Tionghoa',
    'KENDO ITB' : 'Unit Kendo',
    'UKM ITB' : 'Unit Kesenian Minangkabau',
    'UKSS ITB' : 'Unit Kesenian Sulawesi Selatan',
    'UKSU ITB'  : 'Unit Kesenian Sulawesi Utara',
    'UMP ITB' : 'Unit Merpati Putih',
    'RAKATA ITB' : 'Unit Otomotif Rakata',
    'PASOPATI ITB' : 'Unit Panahan',
    'PD ITB' : 'Unit Perisai Diri',
    'URI ITB' : 'Unit Rebana',
    'URPA ITB' : 'Unit Renang dan Polo Air',
    'URO ITB' : 'Unit Robotika',
    'NAUTIKA ITB' : 'Unit Selam Nautikan',
    'US ITB' : 'Unit Softball',
    'TAEKWONDO ITB' : 'Unit Taekwondo',
    'TD ITB' : 'Unit Tarung Derajat',
    'UT ITB' : 'Unit Tenis' 
   },
   'KM' : {
     'KABINET KM ITB' : 'Kabinet Keluarga Mahasiswa ITB'
   }
  };

  static Map<String, Map<String,String>> mapMajor = {
    'FITB' : {
      'ME' : 'Meteorologi',
      'OS' : 'Oseanografi',
      'GD' : 'Teknik Geodesi dan Geomatika',
      'GL' : 'Teknik Geologi'
    },
    'FMIPA' : {
      'AK' : 'Aktuaria',
      'AS' : 'Astronomi',
      'FI' : 'Fisika',
      'KI' : 'Kimia',
      'MA' : 'Matematika'
    },
    'FSRD' : {
      'DI' : 'Desain Interior',
      'DKV' : 'Desain Komunikasi Visual',
      'DP' : 'Desain Produk',
      'KR' : 'Kriya',
      'SR' : 'Seni Rupa'
    },
    'FTMD' : {
      'AE' : 'Teknik Dirgantara',
      'MT' : 'Teknik Material',
      'MS' : 'Teknik Mesin',
    },
    'FTTM' : {
      'TG' : 'Teknik Geofisika',
      'MG' : 'Teknik Metalurgi',
      'TM' : 'Teknik Perminyakan',
      'TA' : 'Teknik Pertambangan'
    },
    'FTSL' : {
      'IL' : 'Rekayasa Infrastruktur Lingkungan',
      'SA' : 'Teknik dan Pengelolaan Sumber Daya Air',
      'KL' : 'Teknik kelautan',
      'TL' : 'Teknik Lingkungan',
      'SI' : 'Teknik Sipil'
    },
    'FTI' : {
      'MR' : 'Manajemen Rekayasa Industri',
      'TB' : 'Teknik Bioenergi dan Kemurgi',
      'TF' : 'Teknik Fisika',
      'TI' : 'Teknik Industri',
      'TK' : 'Teknik Kimia',
      'PG' : 'Teknik Pangan'
    },
    'SAPPK' : {
      'AR' : 'Arsitektur',
      'PWK' : 'Perencanaan Wilayah dan Kota'
    },
    'SBM' : {
      'MK' : 'Kewirausahaan',
      'MB' : 'Manajemen',
    },
    'SF' : {
      'FKK' : 'Farmasi Klinik dan Komunitas',
      'FA' : 'Sains dan Teknologi Farmasi'
    },
    'SITH S' : {
      'BI' : 'Biologi',
      'BM' : 'Mikrobiologi',
    },
    'SITH R' : {
      'BE' : 'Rekayasa Hayati',
      'BA' : 'Rekayasa Pertanian',
      'BW' : 'Rekayasa Kehutanan',
      'BP' : 'Teknologi Pasapanen'
    },
    'STEI' : {
      'II' : 'Sistem dan Teknologi Informas',
      'EB' : 'Teknik Biomedis',
      'EL' :'Teknik Elektro',
      'IF' : 'Informatika',
      'ET' : 'Teknik Telekomunikasi',
      'EP' : 'Teknik Tenaga Listrik'
    }
  };

}
