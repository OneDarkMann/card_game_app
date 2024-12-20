import 'package:flutter/material.dart';
import 'package:flutter_rpg/model/character.dart';
import 'package:flutter_rpg/model/vocation.dart';
import 'package:flutter_rpg/screens/create/vocation_card.dart';
import 'package:flutter_rpg/screens/home/home.dart';
import 'package:flutter_rpg/services/character_store.dart';
import 'package:flutter_rpg/shared/styled_button.dart';
import 'package:flutter_rpg/shared/styled_text.dart';
import 'package:flutter_rpg/theme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

var uuid = const Uuid();

class CreateScreen extends StatefulWidget {
  const CreateScreen({super.key});

  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  //controllers
  final _nameController = TextEditingController();
  final _sloganController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _sloganController.dispose();
    super.dispose();
  }

  //handling vocation selection
  Vocation selectedVocation = Vocation.junkie;

  void updateVocation(Vocation vocation) {
    setState(() {
      selectedVocation = vocation;
    });
  }

  // submit handler
  void handleSubmit() {
    if (_nameController.text.trim().isEmpty) {
      //show error

      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const StyledHeadline('Misssing Character Name'),
            content: const StyledText(
                'Every good RPG character needs a great name...'),
            actions: [
              StyledButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const StyledHeadline('close'))
            ],
            actionsAlignment: MainAxisAlignment.center,
          );
        },
      );
    } else if (_sloganController.text.trim().isEmpty) {
      //show error
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const StyledHeadline('Misssing Character Slogan'),
            content: const StyledText(
                'Every good RPG character needs a great slogan...'),
            actions: [
              StyledButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const StyledHeadline('close'))
            ],
            actionsAlignment: MainAxisAlignment.center,
          );
        },
      );
    } else {
      Provider.of<CharacterStore>(context, listen: false).addCharacter(
        Character(
          name: _nameController.text,
          slogan: _sloganController.text,
          vocation: selectedVocation,
          id: uuid.v4(),
        ),
      );

      Navigator.push(context, MaterialPageRoute(builder: (_) => Home()));
    }
  }

  // select handler
  bool selectUpdate(Vocation vocation) {
    return selectedVocation == vocation;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const StyledTitle('Character Creation'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
          child: Column(
            children: [
              Center(
                child: Icon(Icons.code, color: AppColors.primaryColor),
              ),
              const Center(
                child: StyledHeadline('Welcome, new player.'),
              ),
              const Center(
                child: StyledText('Create a name & slogan for your character.'),
              ),
              const SizedBox(height: 30),

              //input username and slogan
              TextField(
                controller: _nameController,
                style: GoogleFonts.kanit(
                    textStyle: Theme.of(context).textTheme.bodyMedium),
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.person_2),
                  label: StyledText('Character name'),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: _sloganController,
                style: GoogleFonts.kanit(
                    textStyle: Theme.of(context).textTheme.bodyMedium),
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.chat),
                  label: StyledText('Character slogan'),
                ),
              ),
              const SizedBox(height: 30),
              Center(
                child: Icon(Icons.code, color: AppColors.primaryColor),
              ),
              const Center(
                child: StyledHeadline('Choose a vocation.'),
              ),
              const Center(
                child: StyledText('This determines your avilable skills.'),
              ),
              const SizedBox(height: 30),
              //vocation cards
              VocationCard(
                  onTap: updateVocation,
                  vocation: Vocation.junkie,
                  selected: selectUpdate(
                    Vocation.junkie,
                  )),
              VocationCard(
                  onTap: updateVocation,
                  vocation: Vocation.ninja,
                  selected: selectUpdate(
                    Vocation.ninja,
                  )),
              VocationCard(
                  onTap: updateVocation,
                  vocation: Vocation.raider,
                  selected: selectUpdate(
                    Vocation.raider,
                  )),
              VocationCard(
                onTap: updateVocation,
                vocation: Vocation.wizard,
                selected: selectUpdate(
                  Vocation.wizard,
                ),
              ),

              Center(
                child: Icon(Icons.code, color: AppColors.primaryColor),
              ),
              const Center(
                child: StyledHeadline('Good Luck.'),
              ),
              const Center(
                child: StyledText('And enjoy the journey....'),
              ),
              const SizedBox(height: 30),
              Center(
                child: StyledButton(
                  onPressed: handleSubmit,
                  child: const StyledHeadline("Create Character"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
