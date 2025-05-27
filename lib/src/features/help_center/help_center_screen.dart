import 'package:flutter/material.dart';
import '../../commons/widgets/reusable_back_button.dart';
import '../../commons/widgets/search_bar_widget.dart';
import '../../res/assets.dart';
import '../../res/colors.dart';

class HelpCenterScreen extends StatefulWidget {
  const HelpCenterScreen({super.key});
  static String routeName = 'helpCenter';
  static const routePath = '/helpCenter';

  @override
  _HelpCenterScreenState createState() => _HelpCenterScreenState();
}

class _HelpCenterScreenState extends State<HelpCenterScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        leading: const ReusableBackButton(),
        backgroundColor: AppColors.white,
        title: const Text(
          'Help Center',
          style: TextStyle(color: AppColors.black),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          PreferredSize(
            preferredSize: const Size.fromHeight(100.0),
            child: Column(
              children: [
                SearchBarWidget(
                  controller: _searchController,
                  hintText: 'Search...',
                  onChanged: (text) {
                    // Handle search input
                  },
                ),
                const SizedBox(height: 10),
                TabBar(
                  controller: _tabController,
                  labelColor: AppColors.theme,
                  unselectedLabelColor: AppColors.black,
                  indicatorColor: AppColors.theme,
                  tabs: const [
                    Tab(text: "FAQs"),
                    Tab(text: "Contact Us"),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                FAQsTab(),
                ContactUsTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ContactUsTab extends StatelessWidget {
  final List<Map<String, dynamic>> contacts = [
    {'image': ImageAssets.instagramLogo, 'text': 'Instagram'},
    {'image': ImageAssets.facebookLogo, 'text': 'Facebook'},
    {'image': ImageAssets.phoneLogo, 'text': 'Phone Call'},
    {'image': ImageAssets.twitterLogo, 'text': 'Twitter'},
    {'image': ImageAssets.websiteLogo, 'text': 'Website'},
    {'image': ImageAssets.whatsappLogo, 'text': 'WhatsApp'},
  ];

  ContactUsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: contacts.length,
      itemBuilder: (context, index) {
        final contact = contacts[index];
        return ContactTile(
          imagePath: contact['image'],
          contactMethod: contact['text'],
        );
      },
    );
  }
}

class ContactTile extends StatelessWidget {
  final String imagePath;
  final String contactMethod;

  const ContactTile({
    super.key,
    required this.imagePath,
    required this.contactMethod,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.white,
      margin: const EdgeInsets.only(bottom: 12),
      child: ExpansionTile(
        leading: Image.asset(
          imagePath,
          width: 30,
          height: 30,
        ),
        title: Text(
          contactMethod,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        trailing: const Icon(Icons.arrow_drop_down, color: AppColors.theme),
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Here is how you can contact us via $contactMethod.',
              style: const TextStyle(fontSize: 14, color: AppColors.black),
            ),
          ),
        ],
      ),
    );
  }
}

class FAQsTab extends StatelessWidget {
  final List<String> questions = [
    'What is Signature Salon?',
    'How to see saved salon?',
    'How to check pre-booked salon?',
    'How to check Transaction?',
    'How to add nearby Salon?',
    'How to check pre-booked salon?',
    'How to add review?',
  ];

  FAQsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: questions.length,
      itemBuilder: (context, index) {
        return FAQTile(question: questions[index]);
      },
    );
  }
}

class FAQTile extends StatelessWidget {
  final String question;

  const FAQTile({super.key, required this.question});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.white,
      margin: const EdgeInsets.only(bottom: 12),
      child: ExpansionTile(
        title: Text(
          question,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        trailing: const Icon(Icons.arrow_drop_down, color: Colors.green),
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Here is the answer to the question: $question',
              style: const TextStyle(fontSize: 14, color: Colors.black54),
            ),
          ),
        ],
      ),
    );
  }
}
