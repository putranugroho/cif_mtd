import 'package:flutter/foundation.dart';
import 'package:quiver/core.dart';

import 'index.dart';

@immutable
class TransaksiPendModel {

  const TransaksiPendModel({
    required this.id,
    required this.tglTransaksi,
    required this.tglValuta,
    required this.batch,
    required this.trxType,
    required this.trxCode,
    required this.otor,
    required this.kodeTrn,
    required this.dracc,
    required this.namaDr,
    required this.cracc,
    required this.namaCr,
    required this.rrn,
    required this.noDokumen,
    required this.modul,
    required this.keteranganOtor,
    required this.alasan,
    required this.noRef,
    required this.nominal,
    required this.keterangan,
    required this.kodePt,
    required this.kodeKantor,
    required this.kodeInduk,
    required this.stsValidasi,
    required this.kodeAoDr,
    required this.kodeColl,
    required this.kodeAoCr,
    required this.userinput,
    required this.userterm,
    required this.inputtgljam,
    required this.otoruser,
    required this.otorterm,
    required this.otortgljam,
    required this.flagTrn,
    required this.merchant,
    required this.sourceTrx,
    required this.noKontrak,
    required this.noInvoice,
    required this.createddate,
    required this.status,
  });

  final int id;
  final String tglTransaksi;
  final String tglValuta;
  final String batch;
  final String trxType;
  final String trxCode;
  final String otor;
  final String kodeTrn;
  final String dracc;
  final String namaDr;
  final String cracc;
  final String namaCr;
  final String rrn;
  final String noDokumen;
  final String modul;
  final String keteranganOtor;
  final String alasan;
  final String noRef;
  final String nominal;
  final String keterangan;
  final String kodePt;
  final String kodeKantor;
  final String kodeInduk;
  final String stsValidasi;
  final String kodeAoDr;
  final String kodeColl;
  final String kodeAoCr;
  final String userinput;
  final String userterm;
  final String inputtgljam;
  final String otoruser;
  final String otorterm;
  final String otortgljam;
  final String flagTrn;
  final String merchant;
  final String sourceTrx;
  final dynamic noKontrak;
  final dynamic noInvoice;
  final String createddate;
  final String status;

  factory TransaksiPendModel.fromJson(Map<String,dynamic> json) => TransaksiPendModel(
    id: json['id'] as int,
    tglTransaksi: json['tgl_transaksi'].toString(),
    tglValuta: json['tgl_valuta'].toString(),
    batch: json['batch'].toString(),
    trxType: json['trx_type'].toString(),
    trxCode: json['trx_code'].toString(),
    otor: json['otor'].toString(),
    kodeTrn: json['kode_trn'].toString(),
    dracc: json['dracc'].toString(),
    namaDr: json['nama_dr'].toString(),
    cracc: json['cracc'].toString(),
    namaCr: json['nama_cr'].toString(),
    rrn: json['rrn'].toString(),
    noDokumen: json['no_dokumen'].toString(),
    modul: json['modul'].toString(),
    keteranganOtor: json['keterangan_otor'].toString(),
    alasan: json['alasan'].toString(),
    noRef: json['no_ref'].toString(),
    nominal: json['nominal'].toString(),
    keterangan: json['keterangan'].toString(),
    kodePt: json['kode_pt'].toString(),
    kodeKantor: json['kode_kantor'].toString(),
    kodeInduk: json['kode_induk'].toString(),
    stsValidasi: json['sts_validasi'].toString(),
    kodeAoDr: json['kode_ao_dr'].toString(),
    kodeColl: json['kode_coll'].toString(),
    kodeAoCr: json['kode_ao_cr'].toString(),
    userinput: json['userinput'].toString(),
    userterm: json['userterm'].toString(),
    inputtgljam: json['inputtgljam'].toString(),
    otoruser: json['otoruser'].toString(),
    otorterm: json['otorterm'].toString(),
    otortgljam: json['otortgljam'].toString(),
    flagTrn: json['flag_trn'].toString(),
    merchant: json['merchant'].toString(),
    sourceTrx: json['source_trx'].toString(),
    noKontrak: json['no_kontrak'] as dynamic,
    noInvoice: json['no_invoice'] as dynamic,
    createddate: json['createddate'].toString(),
    status: json['status'].toString()
  );
  
  Map<String, dynamic> toJson() => {
    'id': id,
    'tgl_transaksi': tglTransaksi,
    'tgl_valuta': tglValuta,
    'batch': batch,
    'trx_type': trxType,
    'trx_code': trxCode,
    'otor': otor,
    'kode_trn': kodeTrn,
    'dracc': dracc,
    'nama_dr': namaDr,
    'cracc': cracc,
    'nama_cr': namaCr,
    'rrn': rrn,
    'no_dokumen': noDokumen,
    'modul': modul,
    'keterangan_otor': keteranganOtor,
    'alasan': alasan,
    'no_ref': noRef,
    'nominal': nominal,
    'keterangan': keterangan,
    'kode_pt': kodePt,
    'kode_kantor': kodeKantor,
    'kode_induk': kodeInduk,
    'sts_validasi': stsValidasi,
    'kode_ao_dr': kodeAoDr,
    'kode_coll': kodeColl,
    'kode_ao_cr': kodeAoCr,
    'userinput': userinput,
    'userterm': userterm,
    'inputtgljam': inputtgljam,
    'otoruser': otoruser,
    'otorterm': otorterm,
    'otortgljam': otortgljam,
    'flag_trn': flagTrn,
    'merchant': merchant,
    'source_trx': sourceTrx,
    'no_kontrak': noKontrak,
    'no_invoice': noInvoice,
    'createddate': createddate,
    'status': status
  };

  TransaksiPendModel clone() => TransaksiPendModel(
    id: id,
    tglTransaksi: tglTransaksi,
    tglValuta: tglValuta,
    batch: batch,
    trxType: trxType,
    trxCode: trxCode,
    otor: otor,
    kodeTrn: kodeTrn,
    dracc: dracc,
    namaDr: namaDr,
    cracc: cracc,
    namaCr: namaCr,
    rrn: rrn,
    noDokumen: noDokumen,
    modul: modul,
    keteranganOtor: keteranganOtor,
    alasan: alasan,
    noRef: noRef,
    nominal: nominal,
    keterangan: keterangan,
    kodePt: kodePt,
    kodeKantor: kodeKantor,
    kodeInduk: kodeInduk,
    stsValidasi: stsValidasi,
    kodeAoDr: kodeAoDr,
    kodeColl: kodeColl,
    kodeAoCr: kodeAoCr,
    userinput: userinput,
    userterm: userterm,
    inputtgljam: inputtgljam,
    otoruser: otoruser,
    otorterm: otorterm,
    otortgljam: otortgljam,
    flagTrn: flagTrn,
    merchant: merchant,
    sourceTrx: sourceTrx,
    noKontrak: noKontrak,
    noInvoice: noInvoice,
    createddate: createddate,
    status: status
  );


  TransaksiPendModel copyWith({
    int? id,
    String? tglTransaksi,
    String? tglValuta,
    String? batch,
    String? trxType,
    String? trxCode,
    String? otor,
    String? kodeTrn,
    String? dracc,
    String? namaDr,
    String? cracc,
    String? namaCr,
    String? rrn,
    String? noDokumen,
    String? modul,
    String? keteranganOtor,
    String? alasan,
    String? noRef,
    String? nominal,
    String? keterangan,
    String? kodePt,
    String? kodeKantor,
    String? kodeInduk,
    String? stsValidasi,
    String? kodeAoDr,
    String? kodeColl,
    String? kodeAoCr,
    String? userinput,
    String? userterm,
    String? inputtgljam,
    String? otoruser,
    String? otorterm,
    String? otortgljam,
    String? flagTrn,
    String? merchant,
    String? sourceTrx,
    dynamic? noKontrak,
    dynamic? noInvoice,
    String? createddate,
    String? status
  }) => TransaksiPendModel(
    id: id ?? this.id,
    tglTransaksi: tglTransaksi ?? this.tglTransaksi,
    tglValuta: tglValuta ?? this.tglValuta,
    batch: batch ?? this.batch,
    trxType: trxType ?? this.trxType,
    trxCode: trxCode ?? this.trxCode,
    otor: otor ?? this.otor,
    kodeTrn: kodeTrn ?? this.kodeTrn,
    dracc: dracc ?? this.dracc,
    namaDr: namaDr ?? this.namaDr,
    cracc: cracc ?? this.cracc,
    namaCr: namaCr ?? this.namaCr,
    rrn: rrn ?? this.rrn,
    noDokumen: noDokumen ?? this.noDokumen,
    modul: modul ?? this.modul,
    keteranganOtor: keteranganOtor ?? this.keteranganOtor,
    alasan: alasan ?? this.alasan,
    noRef: noRef ?? this.noRef,
    nominal: nominal ?? this.nominal,
    keterangan: keterangan ?? this.keterangan,
    kodePt: kodePt ?? this.kodePt,
    kodeKantor: kodeKantor ?? this.kodeKantor,
    kodeInduk: kodeInduk ?? this.kodeInduk,
    stsValidasi: stsValidasi ?? this.stsValidasi,
    kodeAoDr: kodeAoDr ?? this.kodeAoDr,
    kodeColl: kodeColl ?? this.kodeColl,
    kodeAoCr: kodeAoCr ?? this.kodeAoCr,
    userinput: userinput ?? this.userinput,
    userterm: userterm ?? this.userterm,
    inputtgljam: inputtgljam ?? this.inputtgljam,
    otoruser: otoruser ?? this.otoruser,
    otorterm: otorterm ?? this.otorterm,
    otortgljam: otortgljam ?? this.otortgljam,
    flagTrn: flagTrn ?? this.flagTrn,
    merchant: merchant ?? this.merchant,
    sourceTrx: sourceTrx ?? this.sourceTrx,
    noKontrak: noKontrak ?? this.noKontrak,
    noInvoice: noInvoice ?? this.noInvoice,
    createddate: createddate ?? this.createddate,
    status: status ?? this.status,
  );

  @override
  bool operator ==(Object other) => identical(this, other)
    || other is TransaksiPendModel && id == other.id && tglTransaksi == other.tglTransaksi && tglValuta == other.tglValuta && batch == other.batch && trxType == other.trxType && trxCode == other.trxCode && otor == other.otor && kodeTrn == other.kodeTrn && dracc == other.dracc && namaDr == other.namaDr && cracc == other.cracc && namaCr == other.namaCr && rrn == other.rrn && noDokumen == other.noDokumen && modul == other.modul && keteranganOtor == other.keteranganOtor && alasan == other.alasan && noRef == other.noRef && nominal == other.nominal && keterangan == other.keterangan && kodePt == other.kodePt && kodeKantor == other.kodeKantor && kodeInduk == other.kodeInduk && stsValidasi == other.stsValidasi && kodeAoDr == other.kodeAoDr && kodeColl == other.kodeColl && kodeAoCr == other.kodeAoCr && userinput == other.userinput && userterm == other.userterm && inputtgljam == other.inputtgljam && otoruser == other.otoruser && otorterm == other.otorterm && otortgljam == other.otortgljam && flagTrn == other.flagTrn && merchant == other.merchant && sourceTrx == other.sourceTrx && noKontrak == other.noKontrak && noInvoice == other.noInvoice && createddate == other.createddate && status == other.status;

  @override
  int get hashCode => id.hashCode ^ tglTransaksi.hashCode ^ tglValuta.hashCode ^ batch.hashCode ^ trxType.hashCode ^ trxCode.hashCode ^ otor.hashCode ^ kodeTrn.hashCode ^ dracc.hashCode ^ namaDr.hashCode ^ cracc.hashCode ^ namaCr.hashCode ^ rrn.hashCode ^ noDokumen.hashCode ^ modul.hashCode ^ keteranganOtor.hashCode ^ alasan.hashCode ^ noRef.hashCode ^ nominal.hashCode ^ keterangan.hashCode ^ kodePt.hashCode ^ kodeKantor.hashCode ^ kodeInduk.hashCode ^ stsValidasi.hashCode ^ kodeAoDr.hashCode ^ kodeColl.hashCode ^ kodeAoCr.hashCode ^ userinput.hashCode ^ userterm.hashCode ^ inputtgljam.hashCode ^ otoruser.hashCode ^ otorterm.hashCode ^ otortgljam.hashCode ^ flagTrn.hashCode ^ merchant.hashCode ^ sourceTrx.hashCode ^ noKontrak.hashCode ^ noInvoice.hashCode ^ createddate.hashCode ^ status.hashCode;
}
