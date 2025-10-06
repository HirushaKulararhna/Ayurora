// Create: lib/screens/about_screen.dart
import 'package:flutter/material.dart';
import 'package:ayurora/constants.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kPrimaryColor,
        title: Text(
          'About Ayurora',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(context),
            _buildContent(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmallScreen = size.width < 360;
    final iconSize = isSmallScreen ? 50.0 : 60.0;
    final titleSize = isSmallScreen ? 28.0 : 32.0;
    final subtitleSize = isSmallScreen ? 14.0 : 16.0;
    
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: size.width * 0.05,
        vertical: kDefaultPadding * 2,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            kPrimaryColor,
            kPrimaryColor.withOpacity(0.8),
          ],
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(isSmallScreen ? 16 : 20),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 20,
                  offset: Offset(0, 10),
                ),
              ],
            ),
            child: ClipOval(
              child: Image.asset(
                'assets/playstore.png',
                width: iconSize,
                height: iconSize,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: isSmallScreen ? 12 : 16),
          Text(
            'Ayurora',
            style: TextStyle(
              fontSize: titleSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Your Ayurvedic Plant Companion',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: subtitleSize,
              color: Colors.white.withOpacity(0.9),
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Version 1.0.0',
            style: TextStyle(
              fontSize: isSmallScreen ? 12.0 : 14.0,
              color: Colors.white.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final horizontalPadding = size.width * 0.05;
    
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: kDefaultPadding,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSection(
            context,
            'Our Mission',
            'Ayurora is dedicated to bringing the ancient wisdom of Ayurvedic plants to modern life. We believe in the healing power of nature and strive to make traditional plant knowledge accessible to everyone.',
            Icons.eco,
            Colors.green,
          ),
          _buildSection(
            context,
            'What We Offer',
            'Discover a comprehensive collection of Ayurvedic plants with detailed information about their medicinal properties, care instructions, and health benefits. Learn how to grow and maintain these powerful plants in your own home.',
            Icons.local_florist,
            kPrimaryColor,
          ),
          _buildSection(
            context,
            'Ayurvedic Wisdom',
            'Ayurveda, the ancient Indian system of medicine, has used plants for healing for over 5,000 years. Each plant in our collection has been carefully selected for its traditional therapeutic properties and ease of cultivation.',
            Icons.auto_stories,
            Colors.orange,
          ),
          _buildSection(
            context,
            'Our Vision',
            'We envision a world where everyone can access natural healing through plants. By combining traditional Ayurvedic knowledge with modern growing techniques, we make it easy for you to create your own medicinal garden.',
            Icons.visibility,
            Colors.blue,
          ),
          SizedBox(height: kDefaultPadding),
          _buildFeaturesList(context),
          SizedBox(height: kDefaultPadding * 2),
          _buildOwnerSection(context),
          SizedBox(height: kDefaultPadding * 2),
          _buildContactSection(context),
          SizedBox(height: kDefaultPadding * 2),
          _buildDisclaimerSection(context),
          SizedBox(height: kDefaultPadding),
        ],
      ),
    );
  }

  Widget _buildSection(
    BuildContext context,
    String title,
    String content,
    IconData icon,
    Color color,
  ) {
    final size = MediaQuery.of(context).size;
    final isSmallScreen = size.width < 360;
    final titleSize = isSmallScreen ? 18.0 : 20.0;
    final contentSize = isSmallScreen ? 14.0 : 15.0;
    final iconSize = isSmallScreen ? 20.0 : 24.0;
    
    return Container(
      margin: EdgeInsets.only(bottom: kDefaultPadding * 1.5),
      padding: EdgeInsets.all(size.width * 0.04),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 4),
            blurRadius: 10,
            color: Colors.black.withOpacity(0.05),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(isSmallScreen ? 10 : 12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color, size: iconSize),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: titleSize,
                    fontWeight: FontWeight.bold,
                    color: kTextColor,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Text(
            content,
            style: TextStyle(
              fontSize: contentSize,
              height: 1.6,
              color: Colors.grey.shade700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturesList(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmallScreen = size.width < 360;
    final titleSize = isSmallScreen ? 18.0 : 20.0;
    final featureSize = isSmallScreen ? 14.0 : 15.0;
    
    final features = [
      'Comprehensive plant database',
      'Detailed care instructions',
      'Medicinal properties and benefits',
      'Favorite plants collection',
      'Search and filter functionality',
      'Beautiful plant imagery',
      'Sanskrit and scientific names',
      'Growing difficulty levels',
    ];

    return Container(
      padding: EdgeInsets.all(size.width * 0.04),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 4),
            blurRadius: 10,
            color: Colors.black.withOpacity(0.05),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Features',
            style: TextStyle(
              fontSize: titleSize,
              fontWeight: FontWeight.bold,
              color: kTextColor,
            ),
          ),
          SizedBox(height: 16),
          ...features.map((feature) => Padding(
                padding: EdgeInsets.only(bottom: isSmallScreen ? 10 : 12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.check_circle,
                      color: kPrimaryColor,
                      size: isSmallScreen ? 18 : 20,
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        feature,
                        style: TextStyle(
                          fontSize: featureSize,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildOwnerSection(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmallScreen = size.width < 360;
    final avatarRadius = isSmallScreen ? 40.0 : 50.0;
    final nameSize = isSmallScreen ? 20.0 : 24.0;
    final roleSize = isSmallScreen ? 14.0 : 16.0;
    
    return Container(
      padding: EdgeInsets.all(size.width * 0.04),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 4),
            blurRadius: 10,
            color: Colors.black.withOpacity(0.05),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(4),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  kPrimaryColor,
                  kPrimaryColor.withOpacity(0.7),
                ],
              ),
            ),
            child: Container(
              padding: EdgeInsets.all(3),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: CircleAvatar(
                radius: avatarRadius,
                backgroundColor: kPrimaryColor.withOpacity(0.1),
                child: Icon(
                  Icons.person,
                  size: avatarRadius,
                  color: kPrimaryColor,
                ),
              ),
            ),
          ),
          SizedBox(height: 16),
          Text(
            'Developed By',
            style: TextStyle(
              fontSize: isSmallScreen ? 12.0 : 14.0,
              color: Colors.grey.shade600,
              letterSpacing: 1.2,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Your Name',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: nameSize,
              fontWeight: FontWeight.bold,
              color: kTextColor,
            ),
          ),
          SizedBox(height: 4),
          Text(
            'Mobile App Developer',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: roleSize,
              color: kPrimaryColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 16),
          Text(
            'Passionate about creating beautiful and functional mobile applications that bring traditional knowledge to modern users.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: isSmallScreen ? 13.0 : 14.0,
              height: 1.5,
              color: Colors.grey.shade700,
            ),
          ),
          SizedBox(height: 20),
          _buildSocialButtons(context),
        ],
      ),
    );
  }

  Widget _buildSocialButtons(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmallScreen = size.width < 360;
    
    if (isSmallScreen) {
      return Column(
        children: [
          _buildSocialButton(Icons.language, 'Website', isSmallScreen),
          SizedBox(height: 8),
          _buildSocialButton(Icons.code, 'GitHub', isSmallScreen),
          SizedBox(height: 8),
          _buildSocialButton(Icons.work, 'LinkedIn', isSmallScreen),
        ],
      );
    }
    
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      alignment: WrapAlignment.center,
      children: [
        _buildSocialButton(Icons.language, 'Website', isSmallScreen),
        _buildSocialButton(Icons.code, 'GitHub', isSmallScreen),
        _buildSocialButton(Icons.work, 'LinkedIn', isSmallScreen),
      ],
    );
  }

  Widget _buildSocialButton(IconData icon, String label, bool isSmallScreen) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isSmallScreen ? 12 : 16,
        vertical: isSmallScreen ? 8 : 10,
      ),
      decoration: BoxDecoration(
        color: kPrimaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: kPrimaryColor.withOpacity(0.3),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: isSmallScreen ? 16 : 18, color: kPrimaryColor),
          SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: isSmallScreen ? 12 : 13,
              fontWeight: FontWeight.w600,
              color: kPrimaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactSection(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmallScreen = size.width < 360;
    final iconSize = isSmallScreen ? 35.0 : 40.0;
    final titleSize = isSmallScreen ? 18.0 : 20.0;
    
    return Container(
      padding: EdgeInsets.all(size.width * 0.04),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            kPrimaryColor.withOpacity(0.1),
            kPrimaryColor.withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: kPrimaryColor.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Icon(
            Icons.mail_outline,
            size: iconSize,
            color: kPrimaryColor,
          ),
          SizedBox(height: 12),
          Text(
            'Get in Touch',
            style: TextStyle(
              fontSize: titleSize,
              fontWeight: FontWeight.bold,
              color: kTextColor,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Have questions or suggestions?',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: isSmallScreen ? 13.0 : 14.0,
              color: Colors.grey.shade600,
            ),
          ),
          SizedBox(height: 16),
          Text(
            'contact@ayurora.com',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: isSmallScreen ? 14.0 : 16.0,
              fontWeight: FontWeight.w600,
              color: kPrimaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDisclaimerSection(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmallScreen = size.width < 360;
    final titleSize = isSmallScreen ? 16.0 : 18.0;
    final contentSize = isSmallScreen ? 13.0 : 14.0;
    
    return Container(
      padding: EdgeInsets.all(size.width * 0.04),
      decoration: BoxDecoration(
        color: Colors.amber.shade50,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.amber.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.warning_amber_rounded,
                color: Colors.orange.shade700,
                size: isSmallScreen ? 20 : 24,
              ),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Important Disclaimer',
                  style: TextStyle(
                    fontSize: titleSize,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange.shade900,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Text(
            'This app provides information about Ayurvedic plants for educational purposes only. It is not intended to diagnose, treat, cure, or prevent any disease. Always consult with a qualified healthcare professional before using any plant for medicinal purposes.',
            style: TextStyle(
              fontSize: contentSize,
              height: 1.5,
              color: Colors.orange.shade900,
            ),
          ),
        ],
      ),
    );
  }
}