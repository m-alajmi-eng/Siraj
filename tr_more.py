import json

more = {
'ar': {'more_title':'المزيد','more_search':'البحث الموحد','more_settings':'الإعدادات','more_calendar':'التقويم الإسلامي','more_qibla':'اتجاه القبلة','more_stats':'إحصائياتي','more_shareCards':'بطاقات المشاركة','more_fullMode':'الوضع الكامل','more_radio':'راديو القرآن','more_mosques':'المساجد القريبة'},
'en': {'more_title':'More','more_search':'Unified Search','more_settings':'Settings','more_calendar':'Islamic Calendar','more_qibla':'Qibla Direction','more_stats':'My Stats','more_shareCards':'Share Cards','more_fullMode':'Full Mode','more_radio':'Quran Radio','more_mosques':'Nearby Mosques'},
'ur': {'more_title':'مزید','more_search':'متحدہ تلاش','more_settings':'ترتیبات','more_calendar':'اسلامی کیلنڈر','more_qibla':'سمت قبلہ','more_stats':'میرے اعداد و شمار','more_shareCards':'شیئرنگ کارڈز','more_fullMode':'مکمل موڈ','more_radio':'قرآن ریڈیو','more_mosques':'قریبی مساجد'},
'fa': {'more_title':'بیشتر','more_search':'جستجوی یکپارچه','more_settings':'تنظیمات','more_calendar':'تقویم اسلامی','more_qibla':'جهت قبله','more_stats':'آمار من','more_shareCards':'کارت‌های اشتراک','more_fullMode':'حالت کامل','more_radio':'رادیو قرآن','more_mosques':'مساجد نزدیک'},
'id': {'more_title':'Lainnya','more_search':'Pencarian Terpadu','more_settings':'Pengaturan','more_calendar':'Kalender Islam','more_qibla':'Arah Kiblat','more_stats':'Statistik Saya','more_shareCards':'Kartu Berbagi','more_fullMode':'Mode Penuh','more_radio':'Radio Quran','more_mosques':'Masjid Terdekat'},
'tr': {'more_title':'Daha Fazla','more_search':'Birleşik Arama','more_settings':'Ayarlar','more_calendar':'İslami Takvim','more_qibla':'Kıble Yönü','more_stats':'İstatistiklerim','more_shareCards':'Paylaşım Kartları','more_fullMode':'Tam Mod','more_radio':'Kuran Radyo','more_mosques':'Yakındaki Camiler'},
'fr': {'more_title':'Plus','more_search':'Recherche unifiée','more_settings':'Paramètres','more_calendar':'Calendrier islamique','more_qibla':'Direction de la Qibla','more_stats':'Mes statistiques','more_shareCards':'Cartes de partage','more_fullMode':'Mode complet','more_radio':'Radio Coran','more_mosques':'Mosquées à proximité'},
'bn': {'more_title':'আরও','more_search':'একীভূত অনুসন্ধান','more_settings':'সেটিংস','more_calendar':'ইসলামি ক্যালেন্র','more_qibla':'কিবলার দিক','more_stats':'আমার পরিসংখ্যান','more_shareCards':'শেয়ার কার্ড','more_fullMode':'পূর্ণ মোড','more_radio':'কুরআন রেডিও','more_mosques':'নিকটবর্তী মসজিদ'},
'ms': {'more_title':'Lagi','more_search':'Carian Bersepadu','more_settings':'Tetapan','more_calendar':'Kalendar Islam','more_qibla':'Arah Kiblat','more_stats':'Statistik Saya','more_shareCards':'Kad Perkongsian','more_fullMode':'Mod Penuh','more_radio':'Radio Quran','more_mosques':'Masjid Berdekatan'},
'ha': {'more_title':'Ƙari','more_search':'Bincike Haɗaɗɗe','more_settings':'Saituna','more_calendar':'Kalandar Musulunci','more_qibla':'Alkiblar','more_stats':'Ƙididdigata','more_shareCards':'Katunan Rabawa','more_fullMode':'Cikakken Yanayi','more_radio':'Rediyon Alkur\'ani','more_mosques':'Masallatai Kusa'},
'sw': {'more_title':'Zaidi','more_search':'Utafutaji wa Pamoja','more_settings':'Mipangilio','more_calendar':'Kalenda ya Kiislamu','more_qibla':'Mwelekeo wa Kibla','more_stats':'Takwimu Zangu','more_shareCards':'Kadi za Kushiriki','more_fullMode':'Hali Kamili','more_radio':'Redio ya Qurani','more_mosques':'Misikiti ya Karibu'},
'de': {'more_title':'Mehr','more_search':'Einheitliche Suche','more_settings':'Einstellungen','more_calendar':'Islamischer Kalender','more_qibla':'Qibla-Richtung','more_stats':'Meine Statistiken','more_shareCards':'Teilen-Karten','more_fullMode':'Vollmodus','more_radio':'Koran-Radio','more_mosques':'Moscheen in der Nähe'},
'ru': {'more_title':'Ещё','more_search':'Единый поиск','more_settings':'Настройки','more_calendar':'Исламский календарь','more_qibla':'Направление киблы','more_stats':'Моя статистика','more_shareCards':'Карточки обмена','more_fullMode':'Полный режим','more_radio':'Радио Корана','more_mosques':'Мечети поблизости'},
'zh': {'more_title':'更多','more_search':'统一搜索','more_settings':'设置','more_calendar':'伊斯兰历','more_qibla':'朝向','more_stats':'我的统计','more_shareCards':'分享卡片','more_fullMode':'完整模式','more_radio':'古兰经电台','more_mosques':'附近的清真寺'},
}

for lang, keys in more.items():
    path = f'lib/l10n/app_{lang}.arb'
    data = json.load(open(path))
    added = 0
    for k, v in keys.items():
        if k not in data:
            data[k] = v; added += 1
    json.dump(data, open(path, 'w', encoding='utf-8'), ensure_ascii=False, indent=2)
    print(f"{lang}: +{added}")
