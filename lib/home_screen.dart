import 'dart:convert';
import 'dart:io';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:flutter/material.dart';
import 'package:suezcanal/Api/staff.dart';
import 'package:suezcanal/Model/model_staff.dart';
import 'package:suezcanal/add_screen.dart';
import 'package:suezcanal/widget/custom_button.dart';
import 'package:suezcanal/widget/update_screen.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  void filterSearch(String query) {
    List<Staff> dummyData = _allStaffList!;
    if (query.isNotEmpty) {
      List<Staff> resultSearchProduct = [];
      for (int x = 0; x < dummyData.length; x++) {
        if (dummyData[x].name.toLowerCase().contains(query.toLowerCase())) {
          resultSearchProduct.add(dummyData[x]);
        } else if (dummyData[x].phone.toLowerCase().contains(query.toLowerCase())) {
          resultSearchProduct.add(dummyData[x]);
        } else if (dummyData[x].generalSpecialty.toString().toLowerCase().contains(query.toLowerCase())) {
          resultSearchProduct.add(dummyData[x]);
        } else if (dummyData[x].specialization.toString().toLowerCase().contains(query.toLowerCase())) {
          resultSearchProduct.add(dummyData[x]);
        }
      }
      setState(() {
        _allStaffList2=resultSearchProduct;
      });
      return;
    } else {
      setState(() {
        _allStaffList2 = [];
        _allStaffList2= _allStaffList;
      });
    }
  }

  TextEditingController controllerSearch = TextEditingController();

  List<Staff>? _allStaffList , _allStaffList2;

  bool? isLoading ;

  @override
  void initState() {
    setState(() {
      isLoading = false;
      _allStaffList = [];
      _allStaffList2 = [];
    });
    _allStaffList = [];
    StaffData().getStaff().then((value) {
      setState(() {
        isLoading = true;
        _allStaffList = value!.staff;
        _allStaffList2 = value.staff;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AddScreen()),
              ).then((value) {
                initState();
              });
            },
          ),
          title: const Text('قاعده البينات'),
        ),
        body: isLoading== null ? Container() :
        isLoading! ? SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      child: CustomButton(
                        text: const Text('تحميل'),
                        onPress: () {
                        //  _createPDF();
                        },
                        width: 150,
                        icon: const Icon(Icons.download),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: TextFormField(
                        controller: controllerSearch,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.search),
                            border: OutlineInputBorder(),
                            labelText:  'البحث'
                        ),
                        onChanged: (value) {filterSearch(value);},
                      ),
                    ),
                    _allStaffList2!.isEmpty
                        ? const Center(
                            child: Text('لم يتم إضافة أي موظف'),
                          )
                        : SizedBox(
                            height: MediaQuery.of(context).size.height * 0.5,
                            child: ListView.builder(
                                itemCount: _allStaffList2!.isEmpty
                                    ? 0
                                    : _allStaffList2!.length,
                                itemBuilder: (context, index) => item(staff: _allStaffList2![index])),
                          )
                  ],
                ),
              )
            : const Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }

  Widget item({required Staff staff}) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Material(
          elevation: 10,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    child: Image.memory(base64Decode(staff.image)),
                    radius: 40,
                    backgroundColor: Colors.white,
                  ),
                  Column(
                    children: [
                      Text(
                        staff.name,
                        style: const TextStyle(fontSize: 20),
                      ),
                      Text(
                        staff.generalSpecialty,
                        style: const TextStyle(color: Colors.grey),
                      )
                    ],
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UpdateScreen(staff: staff)),
                      ).then((value) {
                        initState();
                      });
                    },
                    icon: const Icon(Icons.edit),
                    color: Colors.green,
                  ),
                  IconButton(
                      onPressed: () {
                        StaffData()
                            .deleteStaff(id: '${staff.id}')
                            .then((value) => initState());
                      },
                      icon: const Icon(
                        Icons.remove_circle,
                        color: Colors.red,
                      ))
                ],
              ),
            ),
          ),
        ),
      );

  /*
  //to Create pdf and save to phone
  Future<void> _createPDF() async {

    //Create a PDF document.
    final PdfDocument document = PdfDocument();
    //Add page to the PDF
    final PdfPage page = document.pages.add();
    //Get page client size
    final Size pageSize = page.getClientSize();
    //Draw rectangle
    page.graphics.drawRectangle(
        bounds: Rect.fromLTWH(0, 0, pageSize.width, pageSize.height),
        pen: PdfPen(PdfColor(142, 170, 219, 255)));
    //Generate PDF grid.
    final PdfGrid grid = getGrid();
    //Draw the header section by creating text element
    final PdfLayoutResult? result = drawHeader(page, pageSize, grid);

   // drawGrid(page, grid, result!);
    //Add invoice footer
    drawFooter(page, pageSize);
    //Save and launch the document
    final List<int> bytes = document.save();
    //Dispose the document.
    document.dispose();
    //Save and launch file.
    savedAndLaunchFile(bytes, 'قاعدة بيانات.pdf');
  }

  //to draw Header on pdf
  PdfLayoutResult? drawHeader(PdfPage page, Size pageSize, PdfGrid grid) {
    var billId = 'widget.bill';
    var name = 'widget.name';
    var phone = 'widget.phone1';
    var phone2 = 'widget.phone2';
    //Draw rectangle
    final PdfFont contentFont2 =
    PdfStandardFont(PdfFontFamily.symbol, 18, style: PdfFontStyle.bold);
    final PdfFont contentFont =
    PdfStandardFont(PdfFontFamily.symbol, 12, style: PdfFontStyle.bold);

    page.graphics.drawRectangle(
        brush: PdfSolidBrush(PdfColor(91, 126, 215, 255)),
        bounds: Rect.fromLTWH(0, 0, pageSize.width - 115, 90));
    //Draw string
    page.graphics.drawString('UGOOD',
        PdfStandardFont(PdfFontFamily.symbol, 30, style: PdfFontStyle.bold),
        brush: PdfBrushes.white,
        bounds: Rect.fromLTWH(25, 0, pageSize.width - 115, 90),
        format: PdfStringFormat(lineAlignment: PdfVerticalAlignment.middle));

    page.graphics.drawRectangle(
        bounds: Rect.fromLTWH(400, 0, pageSize.width - 400, 90),
        brush: PdfSolidBrush(PdfColor(65, 104, 205)));

    page.graphics.drawString('billId',
        PdfStandardFont(PdfFontFamily.symbol, 15, style: PdfFontStyle.bold),
        bounds: Rect.fromLTWH(400, 0, pageSize.width - 400, 100),
        brush: PdfBrushes.white,
        format: PdfStringFormat(
            alignment: PdfTextAlignment.center,
            lineAlignment: PdfVerticalAlignment.middle));

    page.graphics.drawString('Invoice No.', contentFont2,
        brush: PdfBrushes.white,
        bounds: Rect.fromLTWH(
          400,
          0,
          pageSize.width - 400,
          33,
        ),
        format: PdfStringFormat(
            alignment: PdfTextAlignment.center,
            lineAlignment: PdfVerticalAlignment.bottom));

    //Create data format and convert it to text.
    final String invoiceNumber = 'Customer Information';
    final Size contentSize = contentFont.measureString(invoiceNumber);
    String address =
        '\n\nNAME : name \nEMAIL : email\nPHONE : phone - phone2\n';



    PdfTextElement(
      text: '\nInvoice Information\n',
      font: PdfStandardFont(PdfFontFamily.symbol, 15,
          style: PdfFontStyle.bold),
      brush: PdfBrushes.darkBlue,
    ).draw(
        page: page,
        bounds: Rect.fromLTWH(200, 180,
            pageSize.width - (contentSize.width + 30), pageSize.height - 120));

    return PdfTextElement(text: address, font: PdfStandardFont(PdfFontFamily.symbol, 10,style: PdfFontStyle.bold )).draw(
        page: page,
        bounds: Rect.fromLTWH(30, 120,
            pageSize.width - (contentSize.width + 30), pageSize.height - 120));
  }

  //Create PDF Table and return
  PdfGrid getGrid() {
    //Create a PDF grid
    final PdfGrid grid = PdfGrid();
    //Secify the columns count to the grid.
    grid.columns.add(count: 8);
    //Create the header row of the grid.
    final PdfGridRow headerRow = grid.headers.add(1)[0];
    //Set style
    headerRow.style.backgroundBrush = PdfSolidBrush(PdfColor(68, 114, 196));
    headerRow.style.textBrush = PdfBrushes.white;
    headerRow.cells[0].value = 'المسلسل';
    headerRow.cells[0].stringFormat.alignment = PdfTextAlignment.center;
    headerRow.cells[1].value = 'الاسم';
    headerRow.cells[2].value = 'رقم الهاتف';
    headerRow.cells[3].value = 'التخصص الدقيق';
    headerRow.cells[4].value = 'التخصص العام';
    headerRow.cells[5].value = 'اسم الجامعه';
    headerRow.cells[6].value = 'تاريخ درجه الماجستير';
    headerRow.cells[7].value = 'تاريخ درجه الدكتوراه';
    for (int x = 0; x < _allStaffList!.length; x++) {
      var item = _allStaffList![x];

      _addProducts(
          item,
          grid);
    }
    //Apply the grid built-in style.
    grid.applyBuiltInStyle(PdfGridBuiltInStyle.listTable4Accent5);
    grid.columns[1].width = 200;
    for (int i = 0; i < headerRow.cells.count; i++) {
      headerRow.cells[i].style.cellPadding =
          PdfPaddings(bottom: 5, left: 5, right: 5, top: 5);
    }
    for (int i = 0; i < grid.rows.count; i++) {
      final PdfGridRow row = grid.rows[i];
      for (int j = 0; j < row.cells.count; j++) {
        final PdfGridCell cell = row.cells[j];
        if (j == 0) {
          cell.stringFormat.alignment = PdfTextAlignment.center;
        }
        cell.style.cellPadding =
            PdfPaddings(bottom: 5, left: 5, right: 5, top: 5);
      }
    }
    return grid;
  }

  void drawGrid(PdfPage page, PdfGrid grid, PdfLayoutResult result) {
    Rect? totalPriceCellBounds;
    Rect? quantityCellBounds;
    //Invoke the beginCellLayout event.
    grid.beginCellLayout = (Object sender, PdfGridBeginCellLayoutArgs args) {
      final PdfGrid grid = sender as PdfGrid;
      if (args.cellIndex == grid.columns.count - 1) {
        totalPriceCellBounds = args.bounds;
      } else if (args.cellIndex == grid.columns.count - 2) {
        quantityCellBounds = args.bounds;
      }
    };
    //Draw the PDF grid and get the result.
    result = grid.draw(
        page: page, bounds: Rect.fromLTRB(0, result.bounds.bottom + 40, 0, 0))!;


  }

//Create row for the Table.
  void _addProducts(Staff staff,PdfGrid grid) {
    PdfGridRow row = grid.rows.add();
    row.cells[0].value = staff.id;
    row.cells[1].value = staff.name;
    row.cells[2].value = staff.phone;
    row.cells[3].value = staff.specialization;
    row.cells[4].value = staff.generalSpecialty;
    row.cells[5].value = staff.universityName;
    row.cells[6].value = staff.masterDHistory;
    row.cells[7].value = staff.phDHistory;
  }
//create footer on pdf
  void drawFooter(PdfPage page, Size pageSize) {
    final PdfPen linePen =
    PdfPen(PdfColor(142, 170, 219, 255), dashStyle: PdfDashStyle.custom);
    linePen.dashPattern = <double>[3, 3];
    //Draw line
    page.graphics.drawLine(linePen, Offset(0, pageSize.height - 100),
        Offset(pageSize.width, pageSize.height - 100));

    const String footerContent = 'UGOOD wishes you a good healthy';

    //Added 30 as a margin for the layout.
    page.graphics.drawString(footerContent,
        PdfStandardFont(PdfFontFamily.helvetica, 15, style: PdfFontStyle.bold),
        brush: PdfBrushes.darkBlue,
        format: PdfStringFormat(alignment: PdfTextAlignment.center),
        bounds:
        Rect.fromLTWH(pageSize.width - 270, pageSize.height - 60, 0, 0));
  }

  Future<void> savedAndLaunchFile(List<int> bytes , String fileName) async{
    final path = (await getExternalStorageDirectory())!.path;
    final file = File('$path/$fileName');
    await file.writeAsBytes(bytes , flush: true);
    OpenFile.open('$path/$fileName');
  }

   */
}
