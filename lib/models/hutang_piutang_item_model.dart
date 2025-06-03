import 'package:flutter/foundation.dart';
import 'package:quiver/core.dart';

import 'index.dart';

@immutable
class HutangPiutangItemModel {

  const HutangPiutangItemModel({
    required this.id,
    required this.custsupp,
    required this.nokontrak,
    required this.ke,
    required this.thn,
    required this.bln,
    required this.tgl,
    required this.os,
    required this.tagPokok,
    required this.tagPpn,
    required this.tagPph,
    required this.byrPokok,
    required this.byrPpn,
    required this.byrPph,
    required this.ststgh,
    required this.tglbyrPokok,
    required this.tglbyrPpn,
    required this.tglbyrPph,
    required this.noinv,
    required this.tgltagihan,
    required this.tglppn,
    required this.tglpph,
    required this.stspokok,
    required this.stsppn,
    required this.stspph,
    required this.kdmkt,
    required this.stsrec,
    required this.inpuser,
    required this.inptgljam,
    required this.inpterm,
    required this.chguser,
    required this.chgtgljam,
    required this.chgterm,
    required this.autuser,
    required this.auttgljam,
    required this.autterm,
    required this.stsacru,
    required this.tglbyrlambat,
    required this.createddate,
    required this.isDeleted,
    required this.userinput,
    required this.userterm,
    required this.kodePt,
    required this.kodeKantor,
    required this.kodeInduk,
    required this.noRef,
    required this.keterangan,
    required this.jenisTransaksi,
    required this.namaSif,
    required this.alamat,
    required this.tglKontrak,
    required this.tipeTransaksi,
    required this.noDok,
  });

  final int id;
  final String custsupp;
  final String nokontrak;
  final String ke;
  final String thn;
  final String bln;
  final String tgl;
  final String os;
  final String tagPokok;
  final String tagPpn;
  final String tagPph;
  final String byrPokok;
  final String byrPpn;
  final String byrPph;
  final String ststgh;
  final String tglbyrPokok;
  final String tglbyrPpn;
  final String tglbyrPph;
  final dynamic noinv;
  final String tgltagihan;
  final String tglppn;
  final String tglpph;
  final String stspokok;
  final String stsppn;
  final String stspph;
  final String kdmkt;
  final String stsrec;
  final String inpuser;
  final String inptgljam;
  final String inpterm;
  final String chguser;
  final String chgtgljam;
  final String chgterm;
  final String autuser;
  final String auttgljam;
  final String autterm;
  final String stsacru;
  final String tglbyrlambat;
  final String createddate;
  final String isDeleted;
  final String userinput;
  final String userterm;
  final String kodePt;
  final String kodeKantor;
  final String kodeInduk;
  final String noRef;
  final String keterangan;
  final String jenisTransaksi;
  final String namaSif;
  final String alamat;
  final String tglKontrak;
  final String tipeTransaksi;
  final dynamic noDok;

  factory HutangPiutangItemModel.fromJson(Map<String,dynamic> json) => HutangPiutangItemModel(
    id: json['id'] as int,
    custsupp: json['custsupp'].toString(),
    nokontrak: json['nokontrak'].toString(),
    ke: json['ke'].toString(),
    thn: json['thn'].toString(),
    bln: json['bln'].toString(),
    tgl: json['tgl'].toString(),
    os: json['os'].toString(),
    tagPokok: json['tag_pokok'].toString(),
    tagPpn: json['tag_ppn'].toString(),
    tagPph: json['tag_pph'].toString(),
    byrPokok: json['byr_pokok'].toString(),
    byrPpn: json['byr_ppn'].toString(),
    byrPph: json['byr_pph'].toString(),
    ststgh: json['ststgh'].toString(),
    tglbyrPokok: json['tglbyr_pokok'].toString(),
    tglbyrPpn: json['tglbyr_ppn'].toString(),
    tglbyrPph: json['tglbyr_pph'].toString(),
    noinv: json['noinv'] as dynamic,
    tgltagihan: json['tgltagihan'].toString(),
    tglppn: json['tglppn'].toString(),
    tglpph: json['tglpph'].toString(),
    stspokok: json['stspokok'].toString(),
    stsppn: json['stsppn'].toString(),
    stspph: json['stspph'].toString(),
    kdmkt: json['kdmkt'].toString(),
    stsrec: json['stsrec'].toString(),
    inpuser: json['inpuser'].toString(),
    inptgljam: json['inptgljam'].toString(),
    inpterm: json['inpterm'].toString(),
    chguser: json['chguser'].toString(),
    chgtgljam: json['chgtgljam'].toString(),
    chgterm: json['chgterm'].toString(),
    autuser: json['autuser'].toString(),
    auttgljam: json['auttgljam'].toString(),
    autterm: json['autterm'].toString(),
    stsacru: json['stsacru'].toString(),
    tglbyrlambat: json['tglbyrlambat'].toString(),
    createddate: json['createddate'].toString(),
    isDeleted: json['is_deleted'].toString(),
    userinput: json['userinput'].toString(),
    userterm: json['userterm'].toString(),
    kodePt: json['kode_pt'].toString(),
    kodeKantor: json['kode_kantor'].toString(),
    kodeInduk: json['kode_induk'].toString(),
    noRef: json['no_ref'].toString(),
    keterangan: json['keterangan'].toString(),
    jenisTransaksi: json['jenis_transaksi'].toString(),
    namaSif: json['nama_sif'].toString(),
    alamat: json['alamat'].toString(),
    tglKontrak: json['tgl_kontrak'].toString(),
    tipeTransaksi: json['tipe_transaksi'].toString(),
    noDok: json['no_dok'] as dynamic
  );
  
  Map<String, dynamic> toJson() => {
    'id': id,
    'custsupp': custsupp,
    'nokontrak': nokontrak,
    'ke': ke,
    'thn': thn,
    'bln': bln,
    'tgl': tgl,
    'os': os,
    'tag_pokok': tagPokok,
    'tag_ppn': tagPpn,
    'tag_pph': tagPph,
    'byr_pokok': byrPokok,
    'byr_ppn': byrPpn,
    'byr_pph': byrPph,
    'ststgh': ststgh,
    'tglbyr_pokok': tglbyrPokok,
    'tglbyr_ppn': tglbyrPpn,
    'tglbyr_pph': tglbyrPph,
    'noinv': noinv,
    'tgltagihan': tgltagihan,
    'tglppn': tglppn,
    'tglpph': tglpph,
    'stspokok': stspokok,
    'stsppn': stsppn,
    'stspph': stspph,
    'kdmkt': kdmkt,
    'stsrec': stsrec,
    'inpuser': inpuser,
    'inptgljam': inptgljam,
    'inpterm': inpterm,
    'chguser': chguser,
    'chgtgljam': chgtgljam,
    'chgterm': chgterm,
    'autuser': autuser,
    'auttgljam': auttgljam,
    'autterm': autterm,
    'stsacru': stsacru,
    'tglbyrlambat': tglbyrlambat,
    'createddate': createddate,
    'is_deleted': isDeleted,
    'userinput': userinput,
    'userterm': userterm,
    'kode_pt': kodePt,
    'kode_kantor': kodeKantor,
    'kode_induk': kodeInduk,
    'no_ref': noRef,
    'keterangan': keterangan,
    'jenis_transaksi': jenisTransaksi,
    'nama_sif': namaSif,
    'alamat': alamat,
    'tgl_kontrak': tglKontrak,
    'tipe_transaksi': tipeTransaksi,
    'no_dok': noDok
  };

  HutangPiutangItemModel clone() => HutangPiutangItemModel(
    id: id,
    custsupp: custsupp,
    nokontrak: nokontrak,
    ke: ke,
    thn: thn,
    bln: bln,
    tgl: tgl,
    os: os,
    tagPokok: tagPokok,
    tagPpn: tagPpn,
    tagPph: tagPph,
    byrPokok: byrPokok,
    byrPpn: byrPpn,
    byrPph: byrPph,
    ststgh: ststgh,
    tglbyrPokok: tglbyrPokok,
    tglbyrPpn: tglbyrPpn,
    tglbyrPph: tglbyrPph,
    noinv: noinv,
    tgltagihan: tgltagihan,
    tglppn: tglppn,
    tglpph: tglpph,
    stspokok: stspokok,
    stsppn: stsppn,
    stspph: stspph,
    kdmkt: kdmkt,
    stsrec: stsrec,
    inpuser: inpuser,
    inptgljam: inptgljam,
    inpterm: inpterm,
    chguser: chguser,
    chgtgljam: chgtgljam,
    chgterm: chgterm,
    autuser: autuser,
    auttgljam: auttgljam,
    autterm: autterm,
    stsacru: stsacru,
    tglbyrlambat: tglbyrlambat,
    createddate: createddate,
    isDeleted: isDeleted,
    userinput: userinput,
    userterm: userterm,
    kodePt: kodePt,
    kodeKantor: kodeKantor,
    kodeInduk: kodeInduk,
    noRef: noRef,
    keterangan: keterangan,
    jenisTransaksi: jenisTransaksi,
    namaSif: namaSif,
    alamat: alamat,
    tglKontrak: tglKontrak,
    tipeTransaksi: tipeTransaksi,
    noDok: noDok
  );


  HutangPiutangItemModel copyWith({
    int? id,
    String? custsupp,
    String? nokontrak,
    String? ke,
    String? thn,
    String? bln,
    String? tgl,
    String? os,
    String? tagPokok,
    String? tagPpn,
    String? tagPph,
    String? byrPokok,
    String? byrPpn,
    String? byrPph,
    String? ststgh,
    String? tglbyrPokok,
    String? tglbyrPpn,
    String? tglbyrPph,
    dynamic? noinv,
    String? tgltagihan,
    String? tglppn,
    String? tglpph,
    String? stspokok,
    String? stsppn,
    String? stspph,
    String? kdmkt,
    String? stsrec,
    String? inpuser,
    String? inptgljam,
    String? inpterm,
    String? chguser,
    String? chgtgljam,
    String? chgterm,
    String? autuser,
    String? auttgljam,
    String? autterm,
    String? stsacru,
    String? tglbyrlambat,
    String? createddate,
    String? isDeleted,
    String? userinput,
    String? userterm,
    String? kodePt,
    String? kodeKantor,
    String? kodeInduk,
    String? noRef,
    String? keterangan,
    String? jenisTransaksi,
    String? namaSif,
    String? alamat,
    String? tglKontrak,
    String? tipeTransaksi,
    dynamic? noDok
  }) => HutangPiutangItemModel(
    id: id ?? this.id,
    custsupp: custsupp ?? this.custsupp,
    nokontrak: nokontrak ?? this.nokontrak,
    ke: ke ?? this.ke,
    thn: thn ?? this.thn,
    bln: bln ?? this.bln,
    tgl: tgl ?? this.tgl,
    os: os ?? this.os,
    tagPokok: tagPokok ?? this.tagPokok,
    tagPpn: tagPpn ?? this.tagPpn,
    tagPph: tagPph ?? this.tagPph,
    byrPokok: byrPokok ?? this.byrPokok,
    byrPpn: byrPpn ?? this.byrPpn,
    byrPph: byrPph ?? this.byrPph,
    ststgh: ststgh ?? this.ststgh,
    tglbyrPokok: tglbyrPokok ?? this.tglbyrPokok,
    tglbyrPpn: tglbyrPpn ?? this.tglbyrPpn,
    tglbyrPph: tglbyrPph ?? this.tglbyrPph,
    noinv: noinv ?? this.noinv,
    tgltagihan: tgltagihan ?? this.tgltagihan,
    tglppn: tglppn ?? this.tglppn,
    tglpph: tglpph ?? this.tglpph,
    stspokok: stspokok ?? this.stspokok,
    stsppn: stsppn ?? this.stsppn,
    stspph: stspph ?? this.stspph,
    kdmkt: kdmkt ?? this.kdmkt,
    stsrec: stsrec ?? this.stsrec,
    inpuser: inpuser ?? this.inpuser,
    inptgljam: inptgljam ?? this.inptgljam,
    inpterm: inpterm ?? this.inpterm,
    chguser: chguser ?? this.chguser,
    chgtgljam: chgtgljam ?? this.chgtgljam,
    chgterm: chgterm ?? this.chgterm,
    autuser: autuser ?? this.autuser,
    auttgljam: auttgljam ?? this.auttgljam,
    autterm: autterm ?? this.autterm,
    stsacru: stsacru ?? this.stsacru,
    tglbyrlambat: tglbyrlambat ?? this.tglbyrlambat,
    createddate: createddate ?? this.createddate,
    isDeleted: isDeleted ?? this.isDeleted,
    userinput: userinput ?? this.userinput,
    userterm: userterm ?? this.userterm,
    kodePt: kodePt ?? this.kodePt,
    kodeKantor: kodeKantor ?? this.kodeKantor,
    kodeInduk: kodeInduk ?? this.kodeInduk,
    noRef: noRef ?? this.noRef,
    keterangan: keterangan ?? this.keterangan,
    jenisTransaksi: jenisTransaksi ?? this.jenisTransaksi,
    namaSif: namaSif ?? this.namaSif,
    alamat: alamat ?? this.alamat,
    tglKontrak: tglKontrak ?? this.tglKontrak,
    tipeTransaksi: tipeTransaksi ?? this.tipeTransaksi,
    noDok: noDok ?? this.noDok,
  );

  @override
  bool operator ==(Object other) => identical(this, other)
    || other is HutangPiutangItemModel && id == other.id && custsupp == other.custsupp && nokontrak == other.nokontrak && ke == other.ke && thn == other.thn && bln == other.bln && tgl == other.tgl && os == other.os && tagPokok == other.tagPokok && tagPpn == other.tagPpn && tagPph == other.tagPph && byrPokok == other.byrPokok && byrPpn == other.byrPpn && byrPph == other.byrPph && ststgh == other.ststgh && tglbyrPokok == other.tglbyrPokok && tglbyrPpn == other.tglbyrPpn && tglbyrPph == other.tglbyrPph && noinv == other.noinv && tgltagihan == other.tgltagihan && tglppn == other.tglppn && tglpph == other.tglpph && stspokok == other.stspokok && stsppn == other.stsppn && stspph == other.stspph && kdmkt == other.kdmkt && stsrec == other.stsrec && inpuser == other.inpuser && inptgljam == other.inptgljam && inpterm == other.inpterm && chguser == other.chguser && chgtgljam == other.chgtgljam && chgterm == other.chgterm && autuser == other.autuser && auttgljam == other.auttgljam && autterm == other.autterm && stsacru == other.stsacru && tglbyrlambat == other.tglbyrlambat && createddate == other.createddate && isDeleted == other.isDeleted && userinput == other.userinput && userterm == other.userterm && kodePt == other.kodePt && kodeKantor == other.kodeKantor && kodeInduk == other.kodeInduk && noRef == other.noRef && keterangan == other.keterangan && jenisTransaksi == other.jenisTransaksi && namaSif == other.namaSif && alamat == other.alamat && tglKontrak == other.tglKontrak && tipeTransaksi == other.tipeTransaksi && noDok == other.noDok;

  @override
  int get hashCode => id.hashCode ^ custsupp.hashCode ^ nokontrak.hashCode ^ ke.hashCode ^ thn.hashCode ^ bln.hashCode ^ tgl.hashCode ^ os.hashCode ^ tagPokok.hashCode ^ tagPpn.hashCode ^ tagPph.hashCode ^ byrPokok.hashCode ^ byrPpn.hashCode ^ byrPph.hashCode ^ ststgh.hashCode ^ tglbyrPokok.hashCode ^ tglbyrPpn.hashCode ^ tglbyrPph.hashCode ^ noinv.hashCode ^ tgltagihan.hashCode ^ tglppn.hashCode ^ tglpph.hashCode ^ stspokok.hashCode ^ stsppn.hashCode ^ stspph.hashCode ^ kdmkt.hashCode ^ stsrec.hashCode ^ inpuser.hashCode ^ inptgljam.hashCode ^ inpterm.hashCode ^ chguser.hashCode ^ chgtgljam.hashCode ^ chgterm.hashCode ^ autuser.hashCode ^ auttgljam.hashCode ^ autterm.hashCode ^ stsacru.hashCode ^ tglbyrlambat.hashCode ^ createddate.hashCode ^ isDeleted.hashCode ^ userinput.hashCode ^ userterm.hashCode ^ kodePt.hashCode ^ kodeKantor.hashCode ^ kodeInduk.hashCode ^ noRef.hashCode ^ keterangan.hashCode ^ jenisTransaksi.hashCode ^ namaSif.hashCode ^ alamat.hashCode ^ tglKontrak.hashCode ^ tipeTransaksi.hashCode ^ noDok.hashCode;
}
