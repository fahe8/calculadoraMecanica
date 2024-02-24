import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pdfx/pdfx.dart';

class LectorPdf extends StatefulWidget {
  final String selectedPdfKey;

  const LectorPdf({Key? key, required this.selectedPdfKey}) : super(key: key);

  @override
  State<LectorPdf> createState() => _LectorPdfState();
}

class _LectorPdfState extends State<LectorPdf> {
  late PdfControllerPinch pdfControllerPinch;
  bool _isLoading = true;

  final Map<String, String> pdfUrls = {
    'propiedades': 'assets/pdf/propiedades.pdf',
    'Hidraulica': 'assets/pdf/formulas_hidraulicas.pdf',
    'Bombas': 'assets/pdf/formulas_bombas.pdf',
  };

  @override
  void initState() {
    super.initState();
    pdfControllerPinch = PdfControllerPinch(document: PdfDocument.openAsset(pdfUrls[widget.selectedPdfKey]!));

  }

  



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.selectedPdfKey),
      ),
      body: _buildUiI(),
       
    );
  }

  Widget _buildUiI(){
    return Column(children: [_pdfView()], );
  }

  Widget _pdfView(){
    return  Expanded(child: PdfViewPinch(controller: pdfControllerPinch,));
  }
}
