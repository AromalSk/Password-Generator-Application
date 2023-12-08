import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:password_generator/data/functions.dart';
import 'package:password_generator/features/home/bloc/password_bloc.dart';
import 'package:password_generator/features/password_store/models/password_model.dart';
import 'package:password_generator/features/password_store/ui/password_store.dart';

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    getAllData();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Password Generator',
          style: GoogleFonts.poppins(
            color: Color(0xffbb377d),
            fontSize: 23,
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: Color(0xfffbd3e9),
        centerTitle: true,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Color(0xfffbd3e9),
            Color(0xffbb377d),
          ], stops: [
            0.3,
            0.99
          ], begin: Alignment.topLeft, end: Alignment.bottomRight),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 100,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Card(
                  color: Color.fromARGB(255, 255, 255, 255),
                  elevation: 10,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        height: 300,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Random Password Generator",
                                style: GoogleFonts.poppins(
                                    fontSize: 20,
                                    color: Color(0xffbb377d),
                                    fontWeight: FontWeight.w500)),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              textAlign: TextAlign.center,
                              controller: passwordController,
                              readOnly: true,
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(40),
                                      borderSide: BorderSide.none),
                                  suffixIcon: Padding(
                                    padding: const EdgeInsets.only(right: 20),
                                    child: IconButton(
                                      icon: Icon(
                                        Icons.copy,
                                        color: Color(0xffbb377d),
                                      ),
                                      onPressed: () {
                                        final data = ClipboardData(
                                            text: passwordController.text);
                                        Clipboard.setData(data);

                                        final snackbar = SnackBar(
                                            backgroundColor: Color(0xffbb377d),
                                            content: Text(
                                              'Password Copied',
                                              style: GoogleFonts.poppins(
                                                color: Colors.white,
                                              ),
                                            ));
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snackbar);
                                      },
                                    ),
                                  )),
                              style:
                                  GoogleFonts.poppins(color: Color(0xffbb377d)),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            clickButton()
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: ElevatedButton(
                        onPressed: () {
                          if (passwordController.text.isNotEmpty) {
                            context.read<PasswordBloc>().add(AddPasswordEvent(
                                passwordModel: PasswordModel(
                                    password: passwordController.text)));
                            // addPassword(PasswordModel(
                            //     password: passwordController.text));
                            passwordController.clear();
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) {
                                return PasswordStoring();
                              },
                            ));
                          } else {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) {
                                return PasswordStoring();
                              },
                            ));
                          }
                        },
                        child: Icon(
                          Icons.save,
                          color: Color(0xffbb377d),
                        )),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  ElevatedButton clickButton() {
    final backgroundcolor = MaterialStateColor.resolveWith((states) =>
        states.contains(MaterialState.pressed)
            ? Colors.grey
            : Color(0xffbb377d));
    return ElevatedButton(
        style: ButtonStyle(backgroundColor: backgroundcolor),
        onPressed: () {
          passwordController.text = generatePassword();
        },
        child: Text(
          'Generate Password',
          style: GoogleFonts.poppins(color: Colors.white),
        ));
  }
}
