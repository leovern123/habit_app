class MemberBagusPage extends StatelessWidget {
  const MemberBagusPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Profil Mahasiswa'),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: const [
                  CircleAvatar(
                    radius: 55,
                    backgroundImage:
                        AssetImage('assets/images/bagus.jpeg'),
                  ),
                  SizedBox(height: 14),
                  Text(
                    'Bagus Ferdiansyah',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'TI-23-SE-M • Teknik Informatika',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            const SectionTitle(title: 'Biodata'),
            const ProfileLine(
              icon: Icons.badge_outlined,
              label: 'NIM',
              value: '6677889900',
            ),
            const ProfileLine(
              icon: Icons.email_outlined,
              label: 'Email',
              value: 'bagus@email.com',
            ),
