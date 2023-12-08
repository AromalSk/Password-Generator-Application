import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:password_generator/features/home/bloc/password_bloc.dart';

class PasswordStoring extends StatefulWidget {
  const PasswordStoring({super.key});

  @override
  State<PasswordStoring> createState() => _PasswordStoringState();
}

class _PasswordStoringState extends State<PasswordStoring> {
  @override
  void initState() {
    context.read<PasswordBloc>().add(PasswordInitialEvent());
    super.initState();
  }

  Widget build(BuildContext context) {
    return BlocConsumer<PasswordBloc, PasswordState>(
      listener: (context, state) {},
      builder: (context, state) {
        switch (state.runtimeType) {
          case PasswordLoadingState:
            return Scaffold(
                body: Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  Color(0xfffbd3e9),
                  Color(0xffbb377d),
                ], stops: [
                  0.3,
                  0.99
                ], begin: Alignment.topLeft, end: Alignment.bottomRight),
              ),
              child: Center(
                  child: CircularProgressIndicator(
                color: Color(0xffbb377d),
              )),
            ));
          case PasswordSuccessState:
            state as PasswordSuccessState;
            return Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                leading: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      color: Color(0xffbb377d),
                    )),
                backgroundColor: Color(0xfffbd3e9),
                title: Text(
                  "Stored Password",
                  style: GoogleFonts.poppins(color: Color(0xffbb377d)),
                ),
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
                  child: ListView.builder(
                    itemCount: state.listOfPassword.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Color(0xffbb377d)),
                              color: Colors.white),
                          child: ListTile(
                            title: Text(
                              state.listOfPassword[index].password,
                              style:
                                  GoogleFonts.poppins(color: Color(0xffbb377d)),
                            ),
                            trailing: IconButton(
                                onPressed: () {
                                  context.read<PasswordBloc>().add(
                                      DeletePasswordEvent(
                                          id: state.listOfPassword[index].id!));
                                  // deletePassword(snapshot.data![index].id!);
                                },
                                icon: Icon(
                                  Icons.delete,
                                  color: Color(0xffbb377d),
                                )),
                          ),
                        ),
                      );
                    },
                  )),
            );

          default:
            return Container(
              height: double.infinity,
              width: double.infinity,
              color: Color(0xffbb377d),
            );
        }
      },
    );
  }
}
