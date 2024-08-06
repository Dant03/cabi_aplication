// import 'dart:io';
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:provider/provider.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:torneo_baloncesto/screens/location_picker_screen.dart';
// import '../models/championship.dart';
// import '../models/category.dart';
// import '../providers/championship_provider.dart';
// import '../providers/category_provider.dart';

// class CreateChampionshipScreen extends StatefulWidget {
//   final Championship? championship;
//   final String apiKey;

//   CreateChampionshipScreen({this.championship, required this.apiKey});

//   @override
//   _CreateChampionshipScreenState createState() => _CreateChampionshipScreenState();
// }

// class _CreateChampionshipScreenState extends State<CreateChampionshipScreen> {
//   final _formKey = GlobalKey<FormState>();
//   String? _nombre;
//   File? _imagenFile;
//   String? _ubicacion;
//   int? _numeroDeCanchas;
//   DateTime? _fechaInscripciones;
//   DateTime? _fechaInicio;
//   List<String> _diasDeJuego = [];
//   double? _costoCampeonato;
//   double? _costoInscripcion;
//   double? _costoPartido;
//   String? _telefonoContacto;
//   File? _reglamentoFile;
//   List<String> _selectedCategories = [];

//   @override
//   void initState() {
//     super.initState();
//     if (widget.championship != null) {
//       _nombre = widget.championship!.nombre;
//       _ubicacion = widget.championship!.ubicacion;
//       _numeroDeCanchas = widget.championship!.numeroDeCanchas;
//       _fechaInscripciones = widget.championship!.fechaInscripciones;
//       _fechaInicio = widget.championship!.fechaInicio;
//       _diasDeJuego = widget.championship!.diasDeJuego;
//       _costoCampeonato = widget.championship!.costoCampeonato;
//       _costoInscripcion = widget.championship!.costoInscripcion;
//       _costoPartido = widget.championship!.costoPartido;
//       _telefonoContacto = widget.championship!.telefonoContacto;
//     }
//     Provider.of<CategoryProvider>(context, listen: false).fetchCategories();
//   }

//   Future<void> _pickImage() async {
//     final picker = ImagePicker();
//     final pickedFile = await picker.pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       setState(() {
//         _imagenFile = File(pickedFile.path);
//       });
//     }
//   }

//   Future<void> _pickFile() async {
//     final result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);
//     if (result != null) {
//       setState(() {
//         _reglamentoFile = File(result.files.single.path!);
//       });
//     }
//   }

//   Future<void> _selectDate(BuildContext context, Function(DateTime?) onDateSelected) async {
//     final pickedDate = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(2000),
//       lastDate: DateTime(2101),
//     );
//     if (pickedDate != null) {
//       setState(() {
//         onDateSelected(pickedDate);
//       });
//     }
//   }

//   Future<void> _selectLocation(BuildContext context) async {
//     LatLng? selectedLocation;
//     await Navigator.of(context).push(MaterialPageRoute(
//       builder: (context) => Scaffold(
//         appBar: AppBar(
//           title: Text('Seleccionar Ubicación'),
//         ),
//         body: GoogleMap(
//           initialCameraPosition: CameraPosition(
//             target: LatLng(1.3435099, -78.1913017),
//             zoom: 6,
//           ),
//           onTap: (LatLng latLng) {
//             selectedLocation = latLng;
//             Navigator.of(context).pop();
//           },
//         ),
//       ),
//     ));

//     if (selectedLocation != null) {
//       setState(() {
//         _ubicacion = '${selectedLocation!.latitude},${selectedLocation!.longitude}';
//       });
//     }
//   }

//   Future<void> _saveForm() async {
//     if (!_formKey.currentState!.validate() || _selectedCategories.isEmpty || _diasDeJuego.isEmpty) {
//       return;
//     }
//     _formKey.currentState!.save();
//     final championship = Championship(
//       id: widget.championship?.id,
//       nombre: _nombre!,
//       imagen: _imagenFile != null ? _imagenFile!.path : '',
//       ubicacion: _ubicacion ?? '',
//       numeroDeCanchas: _numeroDeCanchas ?? 0,
//       fechaInscripciones: _fechaInscripciones ?? DateTime.now(),
//       fechaInicio: _fechaInicio ?? DateTime.now(),
//       diasDeJuego: _diasDeJuego,
//       costoCampeonato: _costoCampeonato ?? 0.0,
//       costoInscripcion: _costoInscripcion ?? 0.0,
//       costoPartido: _costoPartido ?? 0.0,
//       telefonoContacto: _telefonoContacto ?? '',
//       estado: 'abierto',
//       reglamento: _reglamentoFile != null ? _reglamentoFile!.path : null,
//     );

//     if (widget.championship == null) {
//       await Provider.of<ChampionshipProvider>(context, listen: false).crearCampeonato(championship, _selectedCategories);
//     } else {
//       await Provider.of<ChampionshipProvider>(context, listen: false).updateChampionship(championship, _selectedCategories);
//     }
//     Navigator.of(context).pop();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final categories = Provider.of<CategoryProvider>(context).categorias;

//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.championship == null ? 'Crear Campeonato' : 'Editar Campeonato'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: ListView(
//             children: [
//               TextFormField(
//                 decoration: InputDecoration(labelText: 'Nombre'),
//                 initialValue: _nombre,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Por favor ingrese un nombre';
//                   }
//                   return null;
//                 },
//                 onSaved: (value) {
//                   _nombre = value;
//                 },
//               ),
//               GestureDetector(
//                 onTap: _pickImage,
//                 child: Container(
//                   height: 150,
//                   decoration: BoxDecoration(
//                     border: Border.all(color: Colors.grey),
//                   ),
//                   child: _imagenFile != null
//                       ? Image.file(_imagenFile!, fit: BoxFit.cover)
//                       : Center(child: Text('Seleccionar Imagen')),
//                 ),
//               ),
//               GestureDetector(
//                 onTap: () => Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => LocationPickerScreen(apiKey: widget.apiKey)),
//                 ),
//                 child: AbsorbPointer(
//                   child: TextFormField(
//                     decoration: InputDecoration(labelText: 'Ubicación'),
//                     initialValue: _ubicacion,
//                     onSaved: (value) {
//                       _ubicacion = value;
//                     },
//                   ),
//                 ),
//               ),
//               TextFormField(
//                 decoration: InputDecoration(labelText: 'Número de Canchas'),
//                 initialValue: _numeroDeCanchas?.toString(),
//                 keyboardType: TextInputType.number,
//                 onSaved: (value) {
//                   _numeroDeCanchas = int.tryParse(value ?? '0');
//                 },
//               ),
//               Row(
//                 children: [
//                   Expanded(
//                     child: TextFormField(
//                       decoration: InputDecoration(labelText: 'Fecha de Inscripciones'),
//                       controller: TextEditingController(
//                         text: _fechaInscripciones != null ? _fechaInscripciones!.toIso8601String().split('T')[0] : '',
//                       ),
//                       readOnly: true,
//                       onTap: () => _selectDate(context, (date) => _fechaInscripciones = date),
//                     ),
//                   ),
//                   IconButton(
//                     icon: Icon(Icons.calendar_today),
//                     onPressed: () => _selectDate(context, (date) => _fechaInscripciones = date),
//                   ),
//                 ],
//               ),
//               Row(
//                 children: [
//                   Expanded(
//                     child: TextFormField(
//                       decoration: InputDecoration(labelText: 'Fecha de Inicio'),
//                       controller: TextEditingController(
//                         text: _fechaInicio != null ? _fechaInicio!.toIso8601String().split('T')[0] : '',
//                       ),
//                       readOnly: true,
//                       onTap: () => _selectDate(context, (date) => _fechaInicio = date),
//                     ),
//                   ),
//                   IconButton(
//                     icon: Icon(Icons.calendar_today),
//                     onPressed: () => _selectDate(context, (date) => _fechaInicio = date),
//                   ),
//                 ],
//               ),
//               DropdownButtonFormField<String>(
//                 decoration: InputDecoration(labelText: 'Días de Juego'),
//                 value: _diasDeJuego.isNotEmpty ? _diasDeJuego[0] : null,
//                 items: _daysOfWeek.values.map((day) {
//                   return DropdownMenuItem<String>(
//                     value: day,
//                     child: Text(day),
//                   );
//                 }).toList(),
//                 onChanged: (value) {
//                   setState(() {
//                     if (value != null && !_diasDeJuego.contains(value)) {
//                       _diasDeJuego.add(value);
//                     }
//                   });
//                 },
//                 validator: (value) {
//                   if (_diasDeJuego.isEmpty) {
//                     return 'Por favor seleccione al menos un día de juego';
//                   }
//                   return null;
//                 },
//               ),
//               Wrap(
//                 spacing: 8.0,
//                 children: _diasDeJuego.map((day) {
//                   return Chip(
//                     label: Text(day),
//                     onDeleted: () {
//                       setState(() {
//                         _diasDeJuego.remove(day);
//                       });
//                     },
//                   );
//                 }).toList(),
//               ),
//               TextFormField(
//                 decoration: InputDecoration(labelText: 'Costo del Campeonato'),
//                 initialValue: _costoCampeonato?.toString(),
//                 keyboardType: TextInputType.number,
//                 onSaved: (value) {
//                   _costoCampeonato = double.tryParse(value ?? '0.0');
//                 },
//               ),
//               TextFormField(
//                 decoration: InputDecoration(labelText: 'Costo de Inscripción'),
//                 initialValue: _costoInscripcion?.toString(),
//                 keyboardType: TextInputType.number,
//                 onSaved: (value) {
//                   _costoInscripcion = double.tryParse(value ?? '0.0');
//                 },
//               ),
//               TextFormField(
//                 decoration: InputDecoration(labelText: 'Costo por Partido'),
//                 initialValue: _costoPartido?.toString(),
//                 keyboardType: TextInputType.number,
//                 onSaved: (value) {
//                   _costoPartido = double.tryParse(value ?? '0.0');
//                 },
//               ),
//               TextFormField(
//                 decoration: InputDecoration(labelText: 'Teléfono de Contacto'),
//                 initialValue: _telefonoContacto,
//                 onSaved: (value) {
//                   _telefonoContacto = value;
//                 },
//               ),
//               GestureDetector(
//                 onTap: _pickFile,
//                 child: Container(
//                   height: 50,
//                   decoration: BoxDecoration(
//                     border: Border.all(color: Colors.grey),
//                   ),
//                   child: _reglamentoFile != null
//                       ? Center(child: Text('Archivo seleccionado: ${_reglamentoFile!.path.split('/').last}'))
//                       : Center(child: Text('Seleccionar Reglamento (PDF)')),
//                 ),
//               ),
//               SizedBox(height: 16.0),
//               Text('Categorías:', style: TextStyle(fontWeight: FontWeight.bold)),
//               Wrap(
//                 spacing: 8.0,
//                 children: categories.map((Category category) {
//                   return ChoiceChip(
//                     label: Text(category.nombre),
//                     selected: _selectedCategories.contains(category.id),
//                     onSelected: (bool selected) {
//                       setState(() {
//                         if (selected) {
//                           _selectedCategories.add(category.id);
//                         } else {
//                           _selectedCategories.remove(category.id);
//                         }
//                       });
//                     },
//                   );
//                 }).toList(),
//               ),
//               SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: _saveForm,
//                 child: Text(widget.championship == null ? 'Crear' : 'Actualizar'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// const Map<String, String> _daysOfWeek = {
//   'Lunes': 'Lunes',
//   'Martes': 'Martes',
//   'Miércoles': 'Miércoles',
//   'Jueves': 'Jueves',
//   'Viernes': 'Viernes',
//   'Sábado': 'Sábado',
//   'Domingo': 'Domingo',
// };

// import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/intl.dart';
import '/providers/tournament_provider.dart';
import '/routes/app_routes.dart';
import '/models/tournament.dart';
import '/widgets/custom_input_text.dart';
import 'package:cabi_app/widgets/drawer_widgets.dart';

class CreateTournamentScreen extends ConsumerStatefulWidget {
  final String? tournamentId;
  const CreateTournamentScreen({super.key, this.tournamentId});

  @override
  _CreateTournamentScreenState createState() => _CreateTournamentScreenState();
}

class _CreateTournamentScreenState extends ConsumerState<CreateTournamentScreen> {
  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController locationCtrl = TextEditingController();
  final TextEditingController numCourtsCtrl = TextEditingController();
  final TextEditingController registrationDateCtrl = TextEditingController();
  final TextEditingController startDateCtrl = TextEditingController();
  final TextEditingController gameDaysCtrl = TextEditingController();
  final TextEditingController registrationValueCtrl = TextEditingController();
  final TextEditingController warrantyValueCtrl = TextEditingController();
  final TextEditingController matchValueCtrl = TextEditingController();
  final TextEditingController rulesCtrl = TextEditingController();
  final TextEditingController phoneCtrl = TextEditingController();
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController statusCtrl = TextEditingController();
  final TextEditingController categoriesCtrl = TextEditingController();

  File? _imageFile;
  // DateTime? _selectedRegistrationDate;
  // DateTime? _selectedStartDate;

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _imageFile = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future<String?> _uploadImageToCloudinary(File imageFile) async {
  try {
    final dio = Dio();
    final cloudName = dotenv.env['CLOUDINARY_CLOUD_NAME'];
    final uploadPreset = dotenv.env['CLOUDINARY_UPLOAD_PRESET'];
    

    if (cloudName == null || uploadPreset == null) {
      throw Exception('Cloudinary environment variables not set');
    }
    final sanitizedTournamentName = nameCtrl.text.replaceAll(RegExp(r'[^\w\s-]'), '').replaceAll(' ', '_').toLowerCase();

    final formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(imageFile.path),
      'upload_preset': uploadPreset,
      'public_id': '$sanitizedTournamentName.png',
    });

    final response = await dio.post(
      'https://api.cloudinary.com/v1_1/$cloudName/image/upload',
      data: formData,
    );

    if (response.statusCode == 200) {
      return response.data['secure_url'];
    } else {
      print('Failed to upload image: ${response.statusMessage}');
      return null;
    }
  } catch (e) {
    print('Exception caught: $e');
    return null;
  }
}

  Future<void> _selectDate(BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null) {
      setState(() {
        controller.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final tournamentIdProv = widget.tournamentId == null
        ? ref.watch(tournamentEmptyProvider)
        : ref.watch(tournamentByIdProvider(widget.tournamentId!));

    return Scaffold(
      appBar: AppBar(
        title: widget.tournamentId == null
            ? const Text("Crear Torneo")
            : const Text("Actualizar Torneo"),
      ),
      drawer: const DrawerWidget(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Form(
                child: Column(
                  children: [
                    tournamentIdProv.when(
                      data: (tournament) {
                        if (widget.tournamentId != null) {
                          // Update inputs controllers
                          nameCtrl.text = tournament.name ?? '';
                          locationCtrl.text = tournament.location ?? '';
                          numCourtsCtrl.text = tournament.numCourts.toString();
                          registrationDateCtrl.text =
                              tournament.registrationDate ?? '';
                          startDateCtrl.text = tournament.startDate ?? '';
                          gameDaysCtrl.text = tournament.gameDays == null
                              ? ''
                              : tournament.gameDays!.join(', ');
                          registrationValueCtrl.text =
                              tournament.registrationValue.toString();
                          warrantyValueCtrl.text =
                              tournament.warrantyValue.toString();
                          matchValueCtrl.text =
                              tournament.matchValue.toString();
                          rulesCtrl.text = tournament.rules ?? '';
                          phoneCtrl.text = tournament.phone ?? '';
                          emailCtrl.text = tournament.email ?? '';
                          statusCtrl.text = tournament.status ?? '';
                          categoriesCtrl.text = tournament.categories == null
                              ? ''
                              : tournament.categories!.join(', ');
                        }
                        return Column(
                          children: [
                            const Text("Nombre Torneo"),
                            CustomInputText(
                              label: 'Nombre Torneo',
                              hintText: 'Indique un nombre general',
                              controller: nameCtrl,
                            ),
                            const Text("Imagen"),
                            _imageFile != null
                                ? Image.file(_imageFile!)
                                : Container(
                                    height: 150,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                    ),
                                    child: Center(
                                      child: Text('No image selected'),
                                    ),
                                  ),
                            ElevatedButton(
                              onPressed: _pickImage,
                              child: const Text('Select Image'),
                            ),
                            const Text("Ubicación"),
                            CustomInputText(
                              label: 'Ubicación',
                              hintText: 'Ubicación del torneo',
                              controller: locationCtrl,
                            ),
                            const Text("Número de Canchas"),
                            CustomInputText(
                              label: 'Número de Canchas',
                              hintText: 'Número de canchas',
                              controller: numCourtsCtrl,
                              keyboardType: TextInputType.number,
                            ),
                            const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: CustomInputText(
                            label: 'Fecha de Registro',
                            hintText: 'Fecha de registro',
                            controller: registrationDateCtrl,                
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: CustomInputText(
                            label: 'Fecha de Inicio',
                            hintText: 'Fecha de inicio',
                            controller: startDateCtrl,                       
                          ),
                        ),
                      ],
                    ),
                            const Text("Fecha de Registro"),
                            CustomInputText(
                              label: 'Fecha de Registro',
                              hintText: 'YYYY-MM-DD',
                              controller: registrationDateCtrl,
                            ),
                            const Text("Fecha de Inicio"),
                            CustomInputText(
                              label: 'Fecha de Inicio',
                              hintText: 'YYYY-MM-DD',
                              controller: startDateCtrl,
                            ),
                            const Text("Días de Juego"),
                            CustomInputText(
                              label: 'Días de Juego',
                              hintText: 'Días de juego',
                              controller: gameDaysCtrl,
                            ),
                            const Text("Valor de Inscripción"),
                            CustomInputText(
                              label: 'Valor de Inscripción',
                              hintText: 'Valor de inscripción',
                              controller: registrationValueCtrl,
                              keyboardType: TextInputType.number,
                            ),
                            const Text("Valor de Garantía"),
                            CustomInputText(
                              label: 'Valor de Garantía',
                              hintText: 'Valor de garantía',
                              controller: warrantyValueCtrl,
                              keyboardType: TextInputType.number,
                            ),
                            const Text("Valor por Partido"),
                            CustomInputText(
                              label: 'Valor por Partido',
                              hintText: 'Valor por partido',
                              controller: matchValueCtrl,
                              keyboardType: TextInputType.number,
                            ),
                            const Text("Reglas"),
                            CustomInputText(
                              label: 'Reglas',
                              hintText: 'Reglas del torneo',
                              controller: rulesCtrl,
                            ),
                            const Text("Teléfono"),
                            CustomInputText(
                              label: 'Teléfono',
                              hintText: 'Número de teléfono',
                              controller: phoneCtrl,
                              keyboardType: TextInputType.phone,
                            ),
                            const Text("Email"),
                            CustomInputText(
                              label: 'Email',
                              hintText: 'Correo electrónico',
                              controller: emailCtrl,
                              keyboardType: TextInputType.emailAddress,
                            ),
                            const Text("Categorías"),
                            CustomInputText(
                              label: 'Categorías',
                              hintText: 'Categorías del torneo',
                              controller: categoriesCtrl,
                            ),
                          ],
                        );
                      },
                      error: (err, trc) {
                        return Column(
                          children: [Text('$err'), Text('$trc')],
                        );
                      },
                      loading: () => const CircularProgressIndicator(),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 20),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.blue),
                        ),
                        onPressed: () async {
                          // Sube la imagen a Cloudinary antes de enviar el formulario
                          String? imageUrl;
                          if (_imageFile != null) {
                            imageUrl = await _uploadImageToCloudinary(_imageFile!);
                          }

                          final Tournament tournamentSubmit = Tournament(
                            tournamentId: widget.tournamentId == null
                                ? 0
                                : int.parse(widget.tournamentId!),
                            name: nameCtrl.text,
                            image: imageUrl ?? '',
                            location: locationCtrl.text,
                            numCourts: int.tryParse(numCourtsCtrl.text) ?? 0,
                            registrationDate: registrationDateCtrl.text,
                            startDate: startDateCtrl.text,
                            gameDays: gameDaysCtrl.text
                                .split(',')
                                .map((e) => e.trim())
                                .toList(),
                            registrationValue:
                                int.tryParse(registrationValueCtrl.text) ?? 0,
                            warrantyValue:
                                int.tryParse(warrantyValueCtrl.text) ?? 0,
                            matchValue: int.tryParse(matchValueCtrl.text) ?? 0,
                            rules: rulesCtrl.text,
                            phone: phoneCtrl.text,
                            email: emailCtrl.text,
                            categories: categoriesCtrl.text
                                .split(',')
                                .map((e) => e.trim())
                                .toList(),
                          );

                          print(tournamentSubmit.toJson());
                          if (widget.tournamentId == null) {
                            // Crear
                            ref.read(
                                createTournamentProvider(tournamentSubmit));
                          } else {
                            // Actualizar
                            ref.read(
                                updateTournamentProvider(tournamentSubmit));
                          }

                          context.push(AppRoutes.tournamentsScreen);
                          ref.invalidate(getTournamentsProvider);
                        },
                        child: Text(
                          widget.tournamentId == null ? 'Crear' : 'Actualizar',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
