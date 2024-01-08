import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:itse_validador/api/gsheets..dart';
//import 'package:itse_validador/components/certificado_dialog.dart';
import 'package:rive/rive.dart';
//test

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  //RIVE CONTROLLER
  StateMachineController? controller;
  SMIInput<bool>? isActive;

  FocusNode expFocusNode = FocusNode();
  final TextEditingController controllerExp = TextEditingController();

  String dropdownValue = '${DateTime.now().year}';

  final List<String> years = [
    '${DateTime.now().year - 2}',
    '${DateTime.now().year - 1}',
    '${DateTime.now().year}',
    '${DateTime.now().year + 1}',
    '${DateTime.now().year + 2}',
  ];

  final testlist = [Company('45', 'name'), Company('id', 'nam222e')];

  @override
  void initState() {
    expFocusNode.addListener(expFocus);
    super.initState();
  }

  @override
  void dispose() {
    expFocusNode.removeListener(expFocus);
    super.dispose();
  }

  void expFocus() {
    isActive?.change(expFocusNode.hasFocus);
  }

  @override
  Widget build(BuildContext context) {
    //final TextEditingController controllerYear = TextEditingController();
    void displayMessage(String message) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(message),
        ),
      );
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color.fromRGBO(220, 220, 220, 1),
      appBar: AppBar(
          toolbarHeight: 80,
          backgroundColor: Colors.grey.shade900,
          elevation: 3,
          shape: const RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.only(bottomRight: Radius.circular(50))),
          title: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text('Consultar Certificado',
                style: TextStyle(color: Colors.white)),
          ),
          centerTitle: true),
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SizedBox(
              height: 200,
              width: 100,
              //color: Colors.amber.withOpacity(0.5),
              child: RiveAnimation.asset(
                "lib/images/DOGGOSEARCH.riv",
                fit: BoxFit.fitHeight,
                stateMachines: const ["State Machine 1"],
                onInit: (artboard) {
                  controller = StateMachineController.fromArtboard(
                    artboard,

                    /// from rive, you can see it in rive editor
                    "State Machine 1",
                  );
                  if (controller == null) return;

                  artboard.addController(controller!);
                  isActive = controller?.findSMI('searchHover');
                  /*isChecking = controller?.findInput("isChecking");
                      numLook = controller?.findInput("numLook");
                      isHandsUp = controller?.findInput("isHandsUp");
                      trigSuccess = controller?.findInput("trigSuccess");
                      trigFail = controller?.findInput("trigFail");*/
                },
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(children: [
                const SizedBox(height: 85),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 250,
                      child: TextField(
                          controller: controllerExp,
                          focusNode: expFocusNode,
                          maxLength: 4,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              hintText: "Numero de expediente",
                              filled: true,
                              prefixIcon: const Icon(Icons.chevron_right_sharp),
                              fillColor: Colors.transparent,
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.transparent),
                                  borderRadius: BorderRadius.circular(35)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors
                                        .transparent, /*color: Theme.of(context).colorScheme.secondary*/
                                  ),
                                  borderRadius: BorderRadius.circular(35)),
                              counter:
                                  const Offstage(), //Elimimnar max lenght indicator
                              hintStyle: TextStyle(color: Colors.grey[400]))),
                    ),
                    //const SizedBox(width: 10),
                  ],
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 15,
                          offset:
                              const Offset(0, 8), // changes position of shadow
                        ),
                      ],
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(25)),
                  child: DropdownButton(
                    value: dropdownValue,
                    dropdownColor: Colors.blue.shade100,
                    underline: Container(
                      height: 2,
                    ),
                    onChanged: (value) {
                      setState(() {
                        if (value is String) {
                          dropdownValue = value;
                          if (years[0]==value) {
                            print(value);
                          }
                          //print(value);
                          //print(dropdownValue);
                        }
                      });
                    },
                    items: years
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                  ),
                ),
                const SizedBox(height: 20),
                //BUTTON

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(150, 50),
                      backgroundColor: Colors.grey[900],
                      foregroundColor: Colors.white,
                      elevation: 5),
                  onPressed: () async {
                    if (controllerExp.text.isNotEmpty) {
                      //FocusScope.of(context).unfocus();
                      //expFocusNode.unfocus();
                      await Gsheets().getDataList(
                          controllerExp.text.toString().trim(),
                          dropdownValue.toString().trim(),
                          context);
                      /*List lista = await Gsheets().getDataList(
                          controllerExp.text.toString().trim(),
                          dropdownValue.toString().trim(),
                          context);
                      certificadoDialog(context,
                          onCLosed: (_) {}, dataList: lista, exp: '16');*/
                      controllerExp.clear();
                    } else {
                      //FocusScope.of(context).unfocus();
                      //expFocusNode.unfocus();
                      /*setState(() {
                        isActive = isActive;
                      });*/
                      controllerExp.clear();
                      displayMessage("EL CAMPO ESTA VACIO");
                    }
                  },
                  child: const Text(
                    'Ingresar',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ]),

              //logo alcalde
              Column(
                children: [
                  const Divider(height: 5, thickness: 2, color: Colors.black),
                  Text(
                    'GERENCIA DE DESARROLLO TERRITORIAL',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                  Text(
                    'SUBGERENCIA DE GESTION DEL RIESGO\nDESASTRES',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 14),
                  ),
                  const Divider(height: 5, thickness: 2, color: Colors.black),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //logo muni
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 15),
                        child: Image.asset(
                          "lib/images/LOGO.png",
                          color: Colors.black,
                          height: 85,
                        ),
                      ),

                      //logo alcalde
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        child: Image.asset(
                          "lib/images/ALCALDEPN.png",
                          color: Colors.black,
                          height: 40,
                        ),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}

class Company {
  String id;
  String name;

  Company(this.id, this.name);
}
