import 'package:flutter/material.dart';

class UserDetailPage extends StatelessWidget {
  final Map<String, dynamic> user;

  const UserDetailPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: ${user['name']}',
                style: Theme.of(context).textTheme.headline6),
            const SizedBox(height: 8),
            Text('Email: ${user['email']}',
                style: Theme.of(context).textTheme.subtitle1),
            const SizedBox(height: 8),
            Text('Phone: ${user['phone']}',
                style: Theme.of(context).textTheme.subtitle1),
            const SizedBox(height: 8),
            Text('Website: ${user['website']}',
                style: Theme.of(context).textTheme.subtitle1),
            const SizedBox(height: 8),
            Text('Company: ${user['company']['name']}',
                style: Theme.of(context).textTheme.subtitle1),
            const SizedBox(height: 8),
            Text('Address:', style: Theme.of(context).textTheme.subtitle1),
            Text('  Street: ${user['address']['street']}',
                style: Theme.of(context).textTheme.bodyText1),
            Text('  Suite: ${user['address']['suite']}',
                style: Theme.of(context).textTheme.bodyText1),
            Text('  City: ${user['address']['city']}',
                style: Theme.of(context).textTheme.bodyText1),
            Text('  Zipcode: ${user['address']['zipcode']}',
                style: Theme.of(context).textTheme.bodyText1),
          ],
        ),
      ),
    );
  }
}
