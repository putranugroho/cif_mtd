import 'package:flutter/foundation.dart';
import 'package:quiver/core.dart';

import 'index.dart';

@immutable
class InventarisTransaksiModel {
  const InventarisTransaksiModel({
    required this.id,
    required this.kelompokAset,
    required this.golonganAset,
    required this.nomorAset,
    required this.satuan,
    required this.namaAset,
    required this.keterangan,
    required this.noDokumenPembelian,
    required this.tanggalBeli,
    required this.tanggalTerima,
    required this.jenisPenempatan,
    required this.namaKantor,
    required this.lokasi,
    required this.kota,
    required this.nilaiAkhir,
    required this.masaSusut,
    required this.bulanMulaiSusut,
    required this.tanggalValuta,
    required this.noDokumenTransaksi,
    required this.nilaiTransaksi,
    required this.keteranganTransaksi,
    required this.hargaBeli,
    required this.diskon,
    required this.biaya,
    required this.pajak,
    required this.metodePenyusutan,
    required this.kodePt,
    required this.kodeKantor,
    required this.kodeInduk,
    required this.namaPegawai,
    required this.nipPegawai,
    required this.statusRec,
    required this.inpuser,
    required this.inptgljam,
    required this.inpterm,
    required this.chguser,
    required this.chgtgljam,
    required this.chgterm,
    required this.autuser,
    required this.auttgljam,
    required this.autterm,
    required this.persentasePenyusutan,
    required this.totalSusut,
    required this.deluser,
    required this.deltgljam,
    required this.delterm,
    required this.sbbAset,
    required this.sbbPenyusutan,
    required this.tglJual,
    required this.alasan,
    required this.nilaiBuku,
    required this.susutKe,
    required this.susutTerakhir,
    required this.nilaiRevaluasi,
    required this.pihakRevaluasi,
    required this.tglRevaluasi,
  });

  final int id;
  final String kelompokAset;
  final String golonganAset;
  final String nomorAset;
  final String satuan;
  final String namaAset;
  final String keterangan;
  final String noDokumenPembelian;
  final String tanggalBeli;
  final String tanggalTerima;
  final String jenisPenempatan;
  final String namaKantor;
  final String lokasi;
  final String kota;
  final String nilaiAkhir;
  final int masaSusut;
  final String bulanMulaiSusut;
  final String tanggalValuta;
  final String noDokumenTransaksi;
  final String nilaiTransaksi;
  final String keteranganTransaksi;
  final String hargaBeli;
  final String diskon;
  final String biaya;
  final String pajak;
  final String metodePenyusutan;
  final String kodePt;
  final String kodeKantor;
  final String kodeInduk;
  final String namaPegawai;
  final String nipPegawai;
  final String statusRec;
  final String inpuser;
  final String inptgljam;
  final String inpterm;
  final dynamic chguser;
  final dynamic chgtgljam;
  final dynamic chgterm;
  final String autuser;
  final String auttgljam;
  final String autterm;
  final String persentasePenyusutan;
  final String totalSusut;
  final dynamic deluser;
  final dynamic deltgljam;
  final dynamic delterm;
  final String sbbAset;
  final String sbbPenyusutan;
  final String tglJual;
  final String alasan;
  final String nilaiBuku;
  final String susutKe;
  final dynamic susutTerakhir;
  final String nilaiRevaluasi;
  final dynamic pihakRevaluasi;
  final dynamic tglRevaluasi;

  factory InventarisTransaksiModel.fromJson(Map<String, dynamic> json) => InventarisTransaksiModel(id: json['id'] as int, kelompokAset: json['kelompok_aset'].toString(), golonganAset: json['golongan_aset'].toString(), nomorAset: json['nomor_aset'].toString(), satuan: json['satuan'].toString(), namaAset: json['nama_aset'].toString(), keterangan: json['keterangan'].toString(), noDokumenPembelian: json['no_dokumen_pembelian'].toString(), tanggalBeli: json['tanggal_beli'].toString(), tanggalTerima: json['tanggal_terima'].toString(), jenisPenempatan: json['jenis_penempatan'].toString(), namaKantor: json['nama_kantor'].toString(), lokasi: json['lokasi'].toString(), kota: json['kota'].toString(), nilaiAkhir: json['nilai_akhir'].toString(), masaSusut: json['masa_susut'] as int, bulanMulaiSusut: json['bulan_mulai_susut'].toString(), tanggalValuta: json['tanggal_valuta'].toString(), noDokumenTransaksi: json['no_dokumen_transaksi'].toString(), nilaiTransaksi: json['nilai_transaksi'].toString(), keteranganTransaksi: json['keterangan_transaksi'].toString(), hargaBeli: json['harga_beli'].toString(), diskon: json['diskon'].toString(), biaya: json['biaya'].toString(), pajak: json['pajak'].toString(), metodePenyusutan: json['metode_penyusutan'].toString(), kodePt: json['kode_pt'].toString(), kodeKantor: json['kode_kantor'].toString(), kodeInduk: json['kode_induk'].toString(), namaPegawai: json['nama_pegawai'].toString(), nipPegawai: json['nip_pegawai'].toString(), statusRec: json['status_rec'].toString(), inpuser: json['inpuser'].toString(), inptgljam: json['inptgljam'].toString(), inpterm: json['inpterm'].toString(), chguser: json['chguser'] as dynamic, chgtgljam: json['chgtgljam'] as dynamic, chgterm: json['chgterm'] as dynamic, autuser: json['autuser'].toString(), auttgljam: json['auttgljam'].toString(), autterm: json['autterm'].toString(), persentasePenyusutan: json['persentase_penyusutan'].toString(), totalSusut: json['total_susut'].toString(), deluser: json['deluser'] as dynamic, deltgljam: json['deltgljam'] as dynamic, delterm: json['delterm'] as dynamic, sbbAset: json['sbb_aset'].toString(), sbbPenyusutan: json['sbb_penyusutan'].toString(), tglJual: json['tgl_jual'].toString(), alasan: json['alasan'].toString(), nilaiBuku: json['nilai_buku'].toString(), susutKe: json['susut_ke'].toString(), susutTerakhir: json['susut_terakhir'] as dynamic, nilaiRevaluasi: json['nilai_revaluasi'].toString(), pihakRevaluasi: json['pihak_revaluasi'] as dynamic, tglRevaluasi: json['tgl_revaluasi'] as dynamic);

  Map<String, dynamic> toJson() => {
        'id': id,
        'kelompok_aset': kelompokAset,
        'golongan_aset': golonganAset,
        'nomor_aset': nomorAset,
        'satuan': satuan,
        'nama_aset': namaAset,
        'keterangan': keterangan,
        'no_dokumen_pembelian': noDokumenPembelian,
        'tanggal_beli': tanggalBeli,
        'tanggal_terima': tanggalTerima,
        'jenis_penempatan': jenisPenempatan,
        'nama_kantor': namaKantor,
        'lokasi': lokasi,
        'kota': kota,
        'nilai_akhir': nilaiAkhir,
        'masa_susut': masaSusut,
        'bulan_mulai_susut': bulanMulaiSusut,
        'tanggal_valuta': tanggalValuta,
        'no_dokumen_transaksi': noDokumenTransaksi,
        'nilai_transaksi': nilaiTransaksi,
        'keterangan_transaksi': keteranganTransaksi,
        'harga_beli': hargaBeli,
        'diskon': diskon,
        'biaya': biaya,
        'pajak': pajak,
        'metode_penyusutan': metodePenyusutan,
        'kode_pt': kodePt,
        'kode_kantor': kodeKantor,
        'kode_induk': kodeInduk,
        'nama_pegawai': namaPegawai,
        'nip_pegawai': nipPegawai,
        'status_rec': statusRec,
        'inpuser': inpuser,
        'inptgljam': inptgljam,
        'inpterm': inpterm,
        'chguser': chguser,
        'chgtgljam': chgtgljam,
        'chgterm': chgterm,
        'autuser': autuser,
        'auttgljam': auttgljam,
        'autterm': autterm,
        'persentase_penyusutan': persentasePenyusutan,
        'total_susut': totalSusut,
        'deluser': deluser,
        'deltgljam': deltgljam,
        'delterm': delterm,
        'sbb_aset': sbbAset,
        'sbb_penyusutan': sbbPenyusutan,
        'tgl_jual': tglJual,
        'alasan': alasan,
        'nilai_buku': nilaiBuku,
        'susut_ke': susutKe,
        'susut_terakhir': susutTerakhir,
        'nilai_revaluasi': nilaiRevaluasi,
        'pihak_revaluasi': pihakRevaluasi,
        'tgl_revaluasi': tglRevaluasi
      };

  InventarisTransaksiModel clone() => InventarisTransaksiModel(id: id, kelompokAset: kelompokAset, golonganAset: golonganAset, nomorAset: nomorAset, satuan: satuan, namaAset: namaAset, keterangan: keterangan, noDokumenPembelian: noDokumenPembelian, tanggalBeli: tanggalBeli, tanggalTerima: tanggalTerima, jenisPenempatan: jenisPenempatan, namaKantor: namaKantor, lokasi: lokasi, kota: kota, nilaiAkhir: nilaiAkhir, masaSusut: masaSusut, bulanMulaiSusut: bulanMulaiSusut, tanggalValuta: tanggalValuta, noDokumenTransaksi: noDokumenTransaksi, nilaiTransaksi: nilaiTransaksi, keteranganTransaksi: keteranganTransaksi, hargaBeli: hargaBeli, diskon: diskon, biaya: biaya, pajak: pajak, metodePenyusutan: metodePenyusutan, kodePt: kodePt, kodeKantor: kodeKantor, kodeInduk: kodeInduk, namaPegawai: namaPegawai, nipPegawai: nipPegawai, statusRec: statusRec, inpuser: inpuser, inptgljam: inptgljam, inpterm: inpterm, chguser: chguser, chgtgljam: chgtgljam, chgterm: chgterm, autuser: autuser, auttgljam: auttgljam, autterm: autterm, persentasePenyusutan: persentasePenyusutan, totalSusut: totalSusut, deluser: deluser, deltgljam: deltgljam, delterm: delterm, sbbAset: sbbAset, sbbPenyusutan: sbbPenyusutan, tglJual: tglJual, alasan: alasan, nilaiBuku: nilaiBuku, susutKe: susutKe, susutTerakhir: susutTerakhir, nilaiRevaluasi: nilaiRevaluasi, pihakRevaluasi: pihakRevaluasi, tglRevaluasi: tglRevaluasi);

  InventarisTransaksiModel copyWith({int? id, String? kelompokAset, String? golonganAset, String? nomorAset, String? satuan, String? namaAset, String? keterangan, String? noDokumenPembelian, String? tanggalBeli, String? tanggalTerima, String? jenisPenempatan, String? namaKantor, String? lokasi, String? kota, String? nilaiAkhir, int? masaSusut, String? bulanMulaiSusut, String? tanggalValuta, String? noDokumenTransaksi, String? nilaiTransaksi, String? keteranganTransaksi, String? hargaBeli, String? diskon, String? biaya, String? pajak, String? metodePenyusutan, String? kodePt, String? kodeKantor, String? kodeInduk, String? namaPegawai, String? nipPegawai, String? statusRec, String? inpuser, String? inptgljam, String? inpterm, dynamic chguser, dynamic chgtgljam, dynamic chgterm, String? autuser, String? auttgljam, String? autterm, String? persentasePenyusutan, String? totalSusut, dynamic deluser, dynamic deltgljam, dynamic delterm, String? sbbAset, String? sbbPenyusutan, String? tglJual, String? alasan, String? nilaiBuku, String? susutKe, dynamic susutTerakhir, String? nilaiRevaluasi, dynamic pihakRevaluasi, dynamic tglRevaluasi}) => InventarisTransaksiModel(
        id: id ?? this.id,
        kelompokAset: kelompokAset ?? this.kelompokAset,
        golonganAset: golonganAset ?? this.golonganAset,
        nomorAset: nomorAset ?? this.nomorAset,
        satuan: satuan ?? this.satuan,
        namaAset: namaAset ?? this.namaAset,
        keterangan: keterangan ?? this.keterangan,
        noDokumenPembelian: noDokumenPembelian ?? this.noDokumenPembelian,
        tanggalBeli: tanggalBeli ?? this.tanggalBeli,
        tanggalTerima: tanggalTerima ?? this.tanggalTerima,
        jenisPenempatan: jenisPenempatan ?? this.jenisPenempatan,
        namaKantor: namaKantor ?? this.namaKantor,
        lokasi: lokasi ?? this.lokasi,
        kota: kota ?? this.kota,
        nilaiAkhir: nilaiAkhir ?? this.nilaiAkhir,
        masaSusut: masaSusut ?? this.masaSusut,
        bulanMulaiSusut: bulanMulaiSusut ?? this.bulanMulaiSusut,
        tanggalValuta: tanggalValuta ?? this.tanggalValuta,
        noDokumenTransaksi: noDokumenTransaksi ?? this.noDokumenTransaksi,
        nilaiTransaksi: nilaiTransaksi ?? this.nilaiTransaksi,
        keteranganTransaksi: keteranganTransaksi ?? this.keteranganTransaksi,
        hargaBeli: hargaBeli ?? this.hargaBeli,
        diskon: diskon ?? this.diskon,
        biaya: biaya ?? this.biaya,
        pajak: pajak ?? this.pajak,
        metodePenyusutan: metodePenyusutan ?? this.metodePenyusutan,
        kodePt: kodePt ?? this.kodePt,
        kodeKantor: kodeKantor ?? this.kodeKantor,
        kodeInduk: kodeInduk ?? this.kodeInduk,
        namaPegawai: namaPegawai ?? this.namaPegawai,
        nipPegawai: nipPegawai ?? this.nipPegawai,
        statusRec: statusRec ?? this.statusRec,
        inpuser: inpuser ?? this.inpuser,
        inptgljam: inptgljam ?? this.inptgljam,
        inpterm: inpterm ?? this.inpterm,
        chguser: chguser ?? this.chguser,
        chgtgljam: chgtgljam ?? this.chgtgljam,
        chgterm: chgterm ?? this.chgterm,
        autuser: autuser ?? this.autuser,
        auttgljam: auttgljam ?? this.auttgljam,
        autterm: autterm ?? this.autterm,
        persentasePenyusutan: persentasePenyusutan ?? this.persentasePenyusutan,
        totalSusut: totalSusut ?? this.totalSusut,
        deluser: deluser ?? this.deluser,
        deltgljam: deltgljam ?? this.deltgljam,
        delterm: delterm ?? this.delterm,
        sbbAset: sbbAset ?? this.sbbAset,
        sbbPenyusutan: sbbPenyusutan ?? this.sbbPenyusutan,
        tglJual: tglJual ?? this.tglJual,
        alasan: alasan ?? this.alasan,
        nilaiBuku: nilaiBuku ?? this.nilaiBuku,
        susutKe: susutKe ?? this.susutKe,
        susutTerakhir: susutTerakhir ?? this.susutTerakhir,
        nilaiRevaluasi: nilaiRevaluasi ?? this.nilaiRevaluasi,
        pihakRevaluasi: pihakRevaluasi ?? this.pihakRevaluasi,
        tglRevaluasi: tglRevaluasi ?? this.tglRevaluasi,
      );

  @override
  bool operator ==(Object other) => identical(this, other) || other is InventarisTransaksiModel && id == other.id && kelompokAset == other.kelompokAset && golonganAset == other.golonganAset && nomorAset == other.nomorAset && satuan == other.satuan && namaAset == other.namaAset && keterangan == other.keterangan && noDokumenPembelian == other.noDokumenPembelian && tanggalBeli == other.tanggalBeli && tanggalTerima == other.tanggalTerima && jenisPenempatan == other.jenisPenempatan && namaKantor == other.namaKantor && lokasi == other.lokasi && kota == other.kota && nilaiAkhir == other.nilaiAkhir && masaSusut == other.masaSusut && bulanMulaiSusut == other.bulanMulaiSusut && tanggalValuta == other.tanggalValuta && noDokumenTransaksi == other.noDokumenTransaksi && nilaiTransaksi == other.nilaiTransaksi && keteranganTransaksi == other.keteranganTransaksi && hargaBeli == other.hargaBeli && diskon == other.diskon && biaya == other.biaya && pajak == other.pajak && metodePenyusutan == other.metodePenyusutan && kodePt == other.kodePt && kodeKantor == other.kodeKantor && kodeInduk == other.kodeInduk && namaPegawai == other.namaPegawai && nipPegawai == other.nipPegawai && statusRec == other.statusRec && inpuser == other.inpuser && inptgljam == other.inptgljam && inpterm == other.inpterm && chguser == other.chguser && chgtgljam == other.chgtgljam && chgterm == other.chgterm && autuser == other.autuser && auttgljam == other.auttgljam && autterm == other.autterm && persentasePenyusutan == other.persentasePenyusutan && totalSusut == other.totalSusut && deluser == other.deluser && deltgljam == other.deltgljam && delterm == other.delterm && sbbAset == other.sbbAset && sbbPenyusutan == other.sbbPenyusutan && tglJual == other.tglJual && alasan == other.alasan && nilaiBuku == other.nilaiBuku && susutKe == other.susutKe && susutTerakhir == other.susutTerakhir && nilaiRevaluasi == other.nilaiRevaluasi && pihakRevaluasi == other.pihakRevaluasi && tglRevaluasi == other.tglRevaluasi;

  @override
  int get hashCode => id.hashCode ^ kelompokAset.hashCode ^ golonganAset.hashCode ^ nomorAset.hashCode ^ satuan.hashCode ^ namaAset.hashCode ^ keterangan.hashCode ^ noDokumenPembelian.hashCode ^ tanggalBeli.hashCode ^ tanggalTerima.hashCode ^ jenisPenempatan.hashCode ^ namaKantor.hashCode ^ lokasi.hashCode ^ kota.hashCode ^ nilaiAkhir.hashCode ^ masaSusut.hashCode ^ bulanMulaiSusut.hashCode ^ tanggalValuta.hashCode ^ noDokumenTransaksi.hashCode ^ nilaiTransaksi.hashCode ^ keteranganTransaksi.hashCode ^ hargaBeli.hashCode ^ diskon.hashCode ^ biaya.hashCode ^ pajak.hashCode ^ metodePenyusutan.hashCode ^ kodePt.hashCode ^ kodeKantor.hashCode ^ kodeInduk.hashCode ^ namaPegawai.hashCode ^ nipPegawai.hashCode ^ statusRec.hashCode ^ inpuser.hashCode ^ inptgljam.hashCode ^ inpterm.hashCode ^ chguser.hashCode ^ chgtgljam.hashCode ^ chgterm.hashCode ^ autuser.hashCode ^ auttgljam.hashCode ^ autterm.hashCode ^ persentasePenyusutan.hashCode ^ totalSusut.hashCode ^ deluser.hashCode ^ deltgljam.hashCode ^ delterm.hashCode ^ sbbAset.hashCode ^ sbbPenyusutan.hashCode ^ tglJual.hashCode ^ alasan.hashCode ^ nilaiBuku.hashCode ^ susutKe.hashCode ^ susutTerakhir.hashCode ^ nilaiRevaluasi.hashCode ^ pihakRevaluasi.hashCode ^ tglRevaluasi.hashCode;
}
