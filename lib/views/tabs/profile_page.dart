import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_bee/models/profile_model.dart';
import 'package:weather_bee/providers/profile_provider.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final profileRef = ref.watch(profileFutureProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: profileRef.when(
        data: (data) {
          if (data == null) {
            return const Center(child: Text("Something went wrong!"));
          } else {
            return Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        data.name,
                        textAlign: TextAlign.center,
                      ),
                      IconButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) =>
                                  ChangeNameDialog(profile: data));
                        },
                        icon: const Icon(Icons.edit),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    data.email,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }
        },
        error: (error, stackTrace) => Center(
          child: Text(error.toString()),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}

class ChangeNameDialog extends ConsumerStatefulWidget {
  final ProfileModel profile;
  const ChangeNameDialog({
    super.key,
    required this.profile,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ChangeNameDialogState();
}

class _ChangeNameDialogState extends ConsumerState<ChangeNameDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();

  @override
  void initState() {
    _nameController.text = widget.profile.name;
    super.initState();
  }

  void _onSave() async {
    if (_formKey.currentState!.validate()) {
      final ProfileModel newProfile = widget.profile.copyWith(
        name: _nameController.text.trim(),
      );

      await ProfileProvider.updateProfile(newProfile).then((value) {
        if (value) {
          ref.invalidate(profileFutureProvider);
          Navigator.pop(context);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: AlertDialog(
        title: const Text('Change Name'),
        content: TextFormField(
          controller: _nameController,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please enter your name';
            }
            return null;
          },
          decoration: const InputDecoration(
            labelText: 'Name',
            prefixIcon: Icon(Icons.person),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: _onSave,
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
