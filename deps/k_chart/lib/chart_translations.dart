class ChartTranslations {
  final String date;
  final String open;
  final String high;
  final String low;
  final String close;
  final String changeAmount;
  final String change;
  final String amount;

  const ChartTranslations({
    this.date = 'Date',
    this.open = 'Open',
    this.high = 'High',
    this.low = 'Low',
    this.close = 'Close',
    this.changeAmount = 'Change',
    this.change = 'Amplitude',
    this.amount = 'Amount',
  });

  String byIndex(int index) {
    switch (index) {
      case 0:
        return date;
      case 1:
        return open;
      case 2:
        return high;
      case 3:
        return low;
      case 4:
        return close;
      case 5:
        return changeAmount;
      case 6:
        return change;
      case 7:
        return amount;
    }

    throw UnimplementedError();
  }
}

const kChartTranslations = {
  'zh_CN': ChartTranslations(
    date: '时间',
    open: '开',
    high: '高',
    low: '低',
    close: '收',
    changeAmount: '涨跌额',
    change: '振幅',
    amount: '成交额',
  ),

  'el_GR': ChartTranslations(
    date: '時間',
    open: '開',
    high: '高',
    low: '低',
    close: '收',
    changeAmount: '漲跌額',
    change: '振幅',
    amount: '成交額',
  ),

  // 繁体中文
  'zh_HK': ChartTranslations(
    date: '時間',
    open: '開',
    high: '高',
    low: '低',
    close: '收',
    changeAmount: '漲跌額',
    change: '振幅',
    amount: '成交額',
  ),

  // 台湾
  'zh_TW': ChartTranslations(
    date: '時間',
    open: '開',
    high: '高',
    low: '低',
    close: '收',
    changeAmount: '漲跌額',
    change: '振幅',
    amount: '成交額',
  ),

  'en_US': ChartTranslations(
    date: 'Date',
    open: 'Open',
    high: 'High',
    low: 'Low',
    close: 'Close',
    changeAmount: 'Change',
    change: 'Amplitude',
    amount: 'Amount',
  ),

  'ja_JP': ChartTranslations(
    date: '日付',
    open: '開く',
    high: '高い',
    low: '低い',
    close: '閉じる',
    changeAmount: '変更',
    change: '振幅',
    amount: '量',
  ),

  'ko_KR': ChartTranslations(
    date: '날짜',
    open: '열다',
    high: '높은',
    low: '낮은',
    close: '닫다',
    changeAmount: '변경',
    change: '진폭',
    amount: '양',
  ),

  'ru_RU': ChartTranslations(
    date: 'Дата',
    open: 'Открыть',
    high: 'Высокий',
    low: 'Низкий',
    close: 'Закрыть',
    changeAmount: 'Изменение',
    change: 'Амплитуда',
    amount: 'Количество',
  ),

  'vi_VN': ChartTranslations(
    date: 'Ngày',
    open: 'Mở',
    high: 'Cao',
    low: 'Thấp',
    close: 'Đóng',
    changeAmount: 'Thay đổi',
    change: 'Biên độ',
    amount: 'Số lượng',
  ),

  'th_TH': ChartTranslations(
    date: 'วันที่',
    open: 'เปิด',
    high: 'สูง',
    low: 'ต่ำ',
    close: 'ปิด',
    changeAmount: 'เปลี่ยนแปลง',
    change: 'ความยาว',
    amount: 'จำนวน',
  ),

  'ms_MY': ChartTranslations(
    date: 'Tarikh',
    open: 'Buka',
    high: 'Tinggi',
    low: 'Rendah',
    close: 'Tutup',
    changeAmount: 'Perubahan',
    change: 'Amplitud',
    amount: 'Jumlah',
  ),

  'id_ID': ChartTranslations(
    date: 'Tanggal',
    open: 'Buka',
    high: 'Tinggi',
    low: 'Rendah',
    close: 'Tutup',
    changeAmount: 'Perubahan',
    change: 'Amplitudo',
    amount: 'Jumlah',
  ),

  'tr_TR': ChartTranslations(
    date: 'Tarih',
    open: 'Açık',
    high: 'Yüksek',
    low: 'Düşük',
    close: 'Kapat',
    changeAmount: 'Değişim',
    change: 'Genlik',
    amount: 'Miktar',
  ),

  'de_DE': ChartTranslations(
    date: 'Datum',
    open: 'Öffnen',
    high: 'Hoch',
    low: 'Niedrig',
    close: 'Schließen',
    changeAmount: 'Ändern',
    change: 'Amplitude',
    amount: 'Menge',
  ),

  'fr_FR': ChartTranslations(
    date: 'Date',
    open: 'Ouvrir',
    high: 'Haut',
    low: 'Bas',
    close: 'Fermer',
    changeAmount: 'Changement',
    change: 'Amplitude',
    amount: 'Quantité',
  ),

  'es_ES': ChartTranslations(
    date: 'Fecha',
    open: 'Abierto',
    high: 'Alto',
    low: 'Bajo',
    close: 'Cerrar',
    changeAmount: 'Cambio',
    change: 'Amplitud',
    amount: 'Cantidad',
  ),

  'pt_PT': ChartTranslations(
    date: 'Encontro',
    open: 'Aberto',
    high: 'Alto',
    low: 'Baixo',
    close: 'Fechar',
    changeAmount: 'Mudança',
    change: 'Amplitude',
    amount: 'Quantidade',
  ),

  'it_IT': ChartTranslations(
    date: 'Data',
    open: 'Aperto',
    high: 'Alto',
    low: 'Basso',
    close: 'Chiudere',
    changeAmount: 'Modifica',
    change: 'Ampiezza',
    amount: 'Quantità',
  ),

  'hi_IN': ChartTranslations(
    date: 'तारीख',
    open: 'खुला',
    high: 'उच्च',
    low: 'कम',
    close: 'बंद',
    changeAmount: 'परिवर्तन',
    change: 'विस्तार',
    amount: 'मात्रा',
  ),

  'bn_BD': ChartTranslations(
    date: 'তারিখ',
    open: 'খোলা',
    high: 'উচ্চ',
    low: 'নিম্ন',
    close: 'বন্ধ',
    changeAmount: 'পরিবর্তন',
    change: 'প্রসার',
    amount: 'পরিমাণ',
  ),

  'ar_AE': ChartTranslations(
    date: 'تاريخ',
    open: 'افتح',
    high: 'مرتفع',
    low: 'منخفض',
    close: 'اغلق',
    changeAmount: 'تغيير',
    change: 'التوسع',
    amount: 'كمية',
  ),

  'fa_IR': ChartTranslations(
    date: 'تاریخ',
    open: 'باز کردن',
    high: 'بالا',
    low: 'پایین',
    close: 'بستن',
    changeAmount: 'تغییر',
    change: 'دامنه',
    amount: 'مقدار',
  ),

  'he_IL': ChartTranslations(
    date: 'תאריך',
    open: 'פתח',
    high: 'גבוה',
    low: 'נמוך',
    close: 'סגור',
    changeAmount: 'שינוי',
    change: 'מִרְחָב',
    amount: 'כמות',
  ),
};
