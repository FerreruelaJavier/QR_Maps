import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';
import 'package:qr_scan/models/scan_model.dart';
import 'package:qr_scan/providers/db_provider.dart';
import 'package:qr_scan/providers/scan_list_provider.dart';

class ScanButton extends StatelessWidget {
  const ScanButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 0,
      child: Icon(
        Icons.filter_center_focus,
      ),
      onPressed: () async{
        //String barcodeScanRes = 'geo:39.597806,2.9229589';
        //String barcodeScanRes = 'https://paucasesnovescifp.cat/';
        String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
                                                    '#FF5733', 
                                                    'Cancelar', 
                                                    false, 
                                                    ScanMode.QR);
        final scanListProvider = Provider.of<ScanListProvider>(context, listen: false);
        scanListProvider.nouScan(barcodeScanRes);
      },
    );
  }
}
