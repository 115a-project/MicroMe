class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Welcome to the Homepage'),
          actions: <Widget> [
            IconButton(
              icon: const Icon(Icons.settings),
              tooltip: 'Settings',
              onPressed: () {},
            ),
          ],
          leading: IconButton(
            icon: const Icon(Icons.home),
            tooltip: 'Return to homepage',
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Screen2()));
            },
          )
      ),
      body: const Center(
          child: Text('Welcome!')
      ),

    );
  }
}