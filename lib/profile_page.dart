import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple.shade50,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/images/profile_picture.png'),
            ),
            SizedBox(height: 16),
            Text(
              'Votre nom',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.purple.shade700,
             
              ),
            ),
            SizedBox(height: 8),
            Text(
              'votre.email@example.com',
              style: TextStyle(
                fontSize: 16,
                color: Colors.purple.shade700,
              ),
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                // Ajoutez ici la fonctionnalité de déconnexion
              },
              child: Text('Se déconnecter'),
              style: ElevatedButton.styleFrom(
                primary: Colors.purple.shade700,
                padding: EdgeInsets.symmetric(horizontal: 48, vertical: 16),
                textStyle: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
