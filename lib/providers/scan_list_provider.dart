import 'package:flutter/cupertino.dart';
import 'package:qr_scan/models/scan_model.dart';
import 'package:qr_scan/providers/db_provider.dart';

class ScanListProvider extends ChangeNotifier{
  List<ScanModel> scans = [];
  String tipusSeleccionat = 'http';

  Future<ScanModel> nouScan(String valor) async{
    final nouScan = ScanModel(valor: valor);
    final id = await DBProvider.db.insertScan(nouScan);
    nouScan.id = id;

    if(nouScan.tipus == tipusSeleccionat){
      this.scans.add(nouScan);
      notifyListeners();
    }
    return nouScan;
  }

  carregaScans() async{
    final scans = await DBProvider.db.getAllScans();
    this.scans = [...scans];
    notifyListeners();
  }

  carregaScansByType(String tipus) async{
    final scans = await DBProvider.db.getScanType(tipus);
    this.scans = [...scans!];
    this.tipusSeleccionat = tipus;
    notifyListeners();
  }

  esborraTots() async{
    final scans = await DBProvider.db.deleteAllScans();
    if(scans > 0){
      this.scans.clear();
    }
    notifyListeners();
  }

  esborraById(int id) async{
    final scans = await DBProvider.db.deleteScan(id);
    if(scans > 0){
      this.scans.removeWhere((element) => element.id == id);
    }
    notifyListeners();
  }
}