import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:mokhatat/constants/strings.dart';
import 'package:mokhatat/logic/cubit/dates_to_remember/dates_to_remember_cubit.dart';

class AddDatesToRemember extends StatefulWidget {
  const AddDatesToRemember({Key? key}) : super(key: key);

  @override
  State<AddDatesToRemember> createState() => _AddDatesToRemember();
}

class _AddDatesToRemember extends State<AddDatesToRemember> {
  List<Widget> eventsListWidget = [];
  List<String> events = [];
  DateTime date = DateTime.now();
  bool _isLoading = false;
  String current = '';
  void _addEventWidget() {
    if (eventsListWidget.length < 5) {
      setState(() {
        eventsListWidget.add(_myTextField());
      });
    } else {
      null;
    }
  }

  void _addEventList(value) {
    if (eventsListWidget.length < 6 && value!= null) {
      setState(() {
        events.add(value);
      });
    }
  }

  Future<void> uploadEvent()async{
    if(events.isNotEmpty){
      try{
       _isLoading = true;
        await  BlocProvider.of<DatesToRememberCubit>(context).datesToRememeberUpload(events , date);
      }catch(error){
        rethrow;
      }
      _isLoading = false;
    }else{
      return;
    }
  }


  Widget createsTextField() {
    return eventsListWidget.isNotEmpty
        ? Column(
            children: [
              SizedBox(
                height: 90.0 * eventsListWidget.length,
                child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: eventsListWidget.length,
                    itemBuilder: (context, i) {
                      return eventsListWidget[i];
                    }),
              ),
              eventsListWidget.length < 5
                  ? Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: MaterialButton(
                        onPressed: _addEventWidget,
                        color: const Color(0xFFD18B81),
                        height: 50,
                        minWidth: 100,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        elevation: 1,
                        hoverColor: const Color(0xFFD18B81),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 20,
                              ),
                              Text(
                                "Add another important event",
                                style: TextStyle(
                                    fontFamily: 'ubuntu',
                                    color: Colors.white,
                                    fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : const SizedBox(),
            ],
          ) :  Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: MaterialButton(
                        onPressed: _addEventWidget,
                        color: const Color(0xFFD18B81),
                        height: 50,
                        minWidth: 100,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        elevation: 1,
                        hoverColor: const Color(0xFFD18B81),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 20,
                              ),
                              Text(
                                "Add another important event",
                                style: TextStyle(
                                    fontFamily: 'ubuntu',
                                    color: Colors.white,
                                    fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
  }

  Widget _myTextField() {
    return Focus(
      onFocusChange: (hasFocus){
           hasFocus == true ? null :  _addEventList(current);
          },
      child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Container(
          decoration: const BoxDecoration(
              border: Border(
            bottom: BorderSide(width: 0.5, color: Colors.grey),
          )),
          width: MediaQuery.of(context).size.width,
          child: TextField(
            textInputAction: TextInputAction.next,
            enableInteractiveSelection: true,
            cursorColor: const Color(0xFFD18B81),
            keyboardType: TextInputType.text,
            onChanged: (input) {
            setState(() {
              current = input;
            });
            },
            decoration: const InputDecoration(
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFD18B81))),
                border: OutlineInputBorder(borderSide: BorderSide()),
                hintText: "Enter an event to remember",
                hintStyle: TextStyle(
                    color: Colors.grey, fontSize: 15.0, fontFamily: 'ubuntu')),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<DatesToRememberCubit, DatesToRememberState>(
      listener: (context, state) {
        if(state is DatesUploaded){
          Navigator.pushNamed(context, datesToRemember);
        }
      },
      child: Scaffold(
           resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0.0,
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Color(0xFFD18B81),
              size: 20,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text(
            'Add an important date',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFFD18B81),
                fontFamily: 'ubuntu',
                fontSize: 20),
          ),
        ),
          body: Padding(
            padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
            child: ListView(
              children: [
                const Text(
            'by pressing this button you can add up to 5 dates to remember on a selected date',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFFD18B81),
                fontFamily: 'ubuntu',
                fontSize: 15),
                textAlign: TextAlign.center,
          ),
                createsTextField(),
                 Padding(
                    padding: const EdgeInsets.only(
                        top: 20, bottom: 20, left: 10, right: 10),
                    child: Row(
                      children: [
                        InkWell(
                          child: Container(
                            height: 45,
                            width: 45,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 3,
                                blurRadius: 10,
                                offset: Offset(0, 3), // changes position of shadow
                              ),
                            ], borderRadius: BorderRadius.circular(10)),
                            child: const Icon(
                              Icons.date_range,
                              size: 30,
                              color: Color(0xFFDF7861),
                            ),
                          ),
                          onTap: () async {
                            DateTime? newDate = await showDatePicker(
                                builder: (context, child) {
          return Theme(
            child: child!,
            data: Theme.of(context).copyWith(
              colorScheme: const ColorScheme.light(
                primary: Color(0xFFD18B81),
                onPrimary: Colors.white,
                onSurface: Colors.grey,
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  primary: const Color(0xFFD18B81), // button text color
                ),
              ),
            ),)}
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2025));
                            if (newDate == null) return;
                            setState(() => date = newDate);
                          },
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          DateFormat('EEEE dd,MMMM yyy').format(date),
                          style: const TextStyle(
                              fontFamily: 'ubuntu',
                              color: Colors.black,
                              fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30,),
                   SizedBox(
                width: MediaQuery.of(context).size.width - 50,
                child: MaterialButton(
                  onPressed: _isLoading ? null :(){
                    setState(() {
                     uploadEvent();
                    });
                  },
                  color: const Color(0xFFD18B81),
                  height: 60,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  elevation: 1,
                  hoverColor: const Color(0xFFD18B81),
                  child: _isLoading ? const SpinKitCircle(color: Colors.white, size: 20,): Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.create,
                        color: Colors.white,
                        size: 20,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Create the event",
                        style: TextStyle(
                            fontFamily: 'ubuntu',
                            color: Colors.white,
                            fontSize: 18),
                      ),
                    ],
                  ),
                ),
              )
              ],
            ),
          ),
        ),
    );
  }
}
