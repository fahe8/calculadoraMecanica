import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:advance_pdf_viewer2/advance_pdf_viewer.dart';

class LectorPdf extends StatefulWidget {
final String selectedPdfKey;
const LectorPdf({ Key? key, required this.selectedPdfKey }) : super(key: key);

  @override
  State<LectorPdf> createState() => _LectorPdfState();
}

class _LectorPdfState extends State<LectorPdf> {
   late PDFDocument _pdfDocument;
  bool _isLoading = true;
final Map<String, String> pdfUrls = {
    'propiedades': 'assets/pdf/propiedades.pdf',
    'fHidraulica': 'assets/pdf/formulas_hidraulicas.pdf',
    'fBombas': 'assets/pdf/formulas_bombas.pdf',
  };


  @override
  void initState() {
    super.initState();
    _loadPDF();
  } 
  
  Future<void> _loadPDF() async {
    // Cambia "assets/tu_archivo.pdf" al path correcto de tu archivo PDF en assets
    final pdfAsset = await loadAsset(pdfUrls[widget.selectedPdfKey]!);

    setState(() {
      _pdfDocument = pdfAsset;
      _isLoading = false;
    });
  }

  Future<PDFDocument> loadAsset(String path) async {
    return await PDFDocument.fromAsset(path);
  }

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lector de PDF desde Assets'),
      ),
      body: Center(
        child: _isLoading
            ? CircularProgressIndicator()
            : PDFViewer(
                document: _pdfDocument,
                zoomSteps: 1,
              ),
      ),
    );
  }
}