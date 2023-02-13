import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:random_user_08_00/app_fonts.dart';
import 'package:random_user_08_00/bloc/random_user_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 20, 23, 22),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Center(
          child: BlocBuilder<RandomUserBloc, RandomUserState>(
            builder: (context, state) {
              if (state is RandomUserSucces) {
                return Body(
                  lat:
                      state.model.results?[0].location?.coordinates?.latitude ??
                          '',
                  lng: state
                          .model.results?[0].location?.coordinates?.longitude ??
                      '',
                  image: state.model.results?[0].picture?.medium ?? '',
                  titleName: state.model.results?[0].name?.title ?? '',
                  firstName: state.model.results?[0].name?.first ?? '',
                  lastName: state.model.results?[0].name?.last ?? '',
                );
              }
              return const Body(
                lat: '1',
                lng: '1',
                image:
                    'https://upload.wikimedia.org/wikipedia/commons/thumb/5/59/User-avatar.svg/2048px-User-avatar.svg.png',
                titleName: 'mr',
                firstName: 'firstName',
                lastName: 'lastName',
              );
            },
          ),
        ),
      ),
    );
  }
}

class ToogleButtonsBody extends StatelessWidget {
  const ToogleButtonsBody({super.key, required this.title});

  final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 50,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
      ),
      child: Center(
        child: Text(
          title,
          style: AppFonts.wBolds25,
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.icon,
    required this.onPressed,
  });

  final IconData icon;
  final Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 75,
      width: 150,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          elevation: 0,
          side: const BorderSide(
            color: Colors.grey,
          ),
        ),
        onPressed: onPressed,
        child: Icon(icon),
      ),
    );
  }
}

class Body extends StatefulWidget {
  const Body({
    super.key,
    required this.image,
    required this.titleName,
    required this.firstName,
    required this.lastName,
    required this.lat,
    required this.lng,
  });

  final String image;
  final String titleName;
  final String firstName;
  final String lastName;
  final String lat;
  final String lng;

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List<bool> isSelectedList = [false, true, false];

  String? gender;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 100,
          backgroundColor: Colors.black,
          child: CircleAvatar(
            radius: 90,
            backgroundImage: NetworkImage(widget.image),
          ),
        ),
        const SizedBox(height: 25),
        Text(
          '${widget.titleName} ${widget.firstName} ${widget.lastName}',
          style: const TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 25),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomButton(
              icon: Icons.mail,
              onPressed: () {
                _sendEmail('tekimbaev@gmail.com');
              },
            ),
            CustomButton(
              icon: Icons.location_on,
              onPressed: () {
                _launchUrl(
                    'https://maps.google.com/?q=${widget.lat},${widget.lng}');
              },
            ),
          ],
        ),
        const SizedBox(height: 25),
        ToggleButtons(
          onPressed: (index) {
            setState(
              () {
                for (int i = 0; i < isSelectedList.length; i++) {
                  isSelectedList[i] = i == index;
                }
              },
            );

            switch (index) {
              case 0:
                gender = 'male';
                break;
              case 1:
                gender = null;
                break;
              case 2:
                gender = 'female';
                break;
            }
          },
          selectedColor: Colors.grey,
          isSelected: isSelectedList,
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            const ToogleButtonsBody(title: 'Men'),
            const ToogleButtonsBody(title: 'Both'),
            const ToogleButtonsBody(title: 'Women'),
          ],
        ),
        const SizedBox(height: 25),
        SizedBox(
          height: 70,
          width: 300,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            onPressed: () {
              BlocProvider.of<RandomUserBloc>(context).add(
                UpdateUser(gender: gender),
              );
            },
            child: const Icon(Icons.refresh),
          ),
        ),
      ],
    );
  }

  Future<void> _launchUrl(String url) async {
    final Uri _url = Uri.parse(url);

    if (!await launchUrl(_url)) {
      throw Exception('Could not launch');
    }
  }

  Future<void> _sendEmail(String email) async {
    String? encodeQueryParameters(Map<String, String> params) {
      return params.entries
          .map((MapEntry<String, String> e) =>
              '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
          .join('&');
    }

// ···
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: email,
      query: encodeQueryParameters(
        <String, String>{
          'subject': 'Example Subject & Symbols are allowed!',
        },
      ),
    );
    if (!await launchUrl(emailLaunchUri)) {
      throw Exception('Could not launch');
    }
  }
}
