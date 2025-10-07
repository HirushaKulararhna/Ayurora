import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ayurora/constants.dart';
import 'package:ayurora/models/plant.dart';

class DetailsScreen extends StatefulWidget {
  final Plant plant;
  final VoidCallback? onFavoriteToggle;

  const DetailsScreen({
    super.key,
    required this.plant,
    this.onFavoriteToggle,
  });

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late PageController _pageController;
  int _currentImageIndex = 0;

  @override
  void initState() {
    super.initState();
    
    _pageController = PageController();
    
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    ));

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  double _getResponsivePadding(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width >= 900) return 24;
    if (width >= 600) return 20;
    if (width < 360) return 12;
    return 16;
  }

  double _getResponsiveFontSize(BuildContext context, double baseSize) {
    final width = MediaQuery.of(context).size.width;
    if (width < 360) return baseSize * 0.85;
    if (width < 400) return baseSize * 0.9;
    return baseSize;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(context),
          SliverToBoxAdapter(
            child: SlideTransition(
              position: _slideAnimation,
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: _buildPlantDetails(context),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: _buildFloatingActionButton(context),
    );
  }

  Widget _buildSliverAppBar(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 360;
    
    return SliverAppBar(
      expandedHeight: 400,
      pinned: true,
      elevation: 0,
      backgroundColor: kBackgroundColor,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      leading: Container(
        margin: EdgeInsets.all(isSmallScreen ? 6 : 8),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          borderRadius: BorderRadius.circular(isSmallScreen ? 10 : 12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: IconButton(
          iconSize: isSmallScreen ? 18 : 24,
          icon: Icon(Icons.arrow_back_ios_new, color: kTextColor),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      actions: [
        Container(
          margin: EdgeInsets.all(isSmallScreen ? 6 : 8),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.9),
            borderRadius: BorderRadius.circular(isSmallScreen ? 10 : 12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: IconButton(
            iconSize: isSmallScreen ? 18 : 24,
            icon: Icon(
              widget.plant.isFavorite ? Icons.favorite : Icons.favorite_border,
              color: widget.plant.isFavorite ? Colors.red : kTextColor,
            ),
            onPressed: () {
              setState(() {
                widget.plant.toggleFavorite();
              });
              
              if (widget.onFavoriteToggle != null) {
                widget.onFavoriteToggle!();
              }
              
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    widget.plant.isFavorite 
                      ? '${widget.plant.name} added to favorites!' 
                      : '${widget.plant.name} removed from favorites!',
                  ),
                  backgroundColor: kPrimaryColor,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  duration: const Duration(seconds: 2),
                ),
              );
            },
          ),
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    widget.plant.backgroundColor.withOpacity(0.3),
                    widget.plant.backgroundColor.withOpacity(0.1),
                    Colors.white,
                  ],
                ),
              ),
            ),
            Hero(
              tag: 'plant_${widget.plant.id}',
              child: Center(
                child: Container(
                  width: double.infinity,
                  height: 300,
                  margin: EdgeInsets.symmetric(horizontal: isSmallScreen ? 12 : 20),
                  child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: (index) {
                      setState(() {
                        _currentImageIndex = index;
                      });
                    },
                    itemCount: widget.plant.galleryImages.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.symmetric(horizontal: isSmallScreen ? 5 : 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(isSmallScreen ? 16 : 20),
                          boxShadow: [
                            BoxShadow(
                              color: kPrimaryColor.withOpacity(0.3),
                              blurRadius: 30,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(isSmallScreen ? 16 : 20),
                          child: Image.asset(
                            widget.plant.galleryImages[index],
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: kPrimaryColor.withOpacity(0.2),
                                child: Icon(
                                  Icons.local_florist,
                                  size: isSmallScreen ? 60 : 80,
                                  color: kPrimaryColor,
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            // Image indicator
            Positioned(
              bottom: 20,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  widget.plant.galleryImages.length,
                  (index) => Container(
                    margin: EdgeInsets.symmetric(horizontal: 4),
                    width: isSmallScreen ? 6 : 8,
                    height: isSmallScreen ? 6 : 8,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _currentImageIndex == index 
                          ? Colors.white 
                          : Colors.white.withOpacity(0.5),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlantDetails(BuildContext context) {
    final padding = _getResponsivePadding(context);
    
    return Container(
      decoration: BoxDecoration(
        color: kBackgroundColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(padding * 1.5),
          topRight: Radius.circular(padding * 1.5),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPlantHeader(context),
            SizedBox(height: padding * 1.5),
            _buildPlantNames(context),
            SizedBox(height: padding * 1.5),
            _buildPlantStats(context),
            SizedBox(height: padding * 1.75),
            _buildDescription(context),
            SizedBox(height: padding * 1.75),
            
            // Ayurvedic Properties
            _buildAyurvedicProperties(context),
            SizedBox(height: padding * 1.75),
            
            // Used Parts
            if (widget.plant.usedParts.isNotEmpty) ...[
              _buildUsedParts(context),
              SizedBox(height: padding * 1.75),
            ],
            
            // Care Instructions
            if (widget.plant.careInstructions.isNotEmpty) ...[
              _buildCareInstructions(context),
              SizedBox(height: padding * 1.75),
            ],
            
            // Plant Benefits
            if (widget.plant.benefits.isNotEmpty) ...[
              _buildPlantBenefits(context),
              SizedBox(height: padding * 1.75),
            ],
            
            // Therapeutic Uses
            if (widget.plant.therapeuticUses.isNotEmpty) ...[
              _buildTherapeuticUses(context),
              SizedBox(height: padding * 1.75),
            ],
            
            // Modern Therapeutics
            if (widget.plant.modernTherapeutics.isNotEmpty) ...[
              _buildModernTherapeutics(context),
              SizedBox(height: padding * 1.75),
            ],
            
            // Important Formulations
            if (widget.plant.importantFormulations.isNotEmpty) ...[
              _buildFormulations(context),
              SizedBox(height: padding * 1.75),
            ],
            
            // Dosage Information
            if (widget.plant.dose.isNotEmpty) ...[
              _buildDosageInfo(context),
              SizedBox(height: padding * 1.75),
            ],
            
            // Macroscopic Description
            if (widget.plant.macroscopicDescription.isNotEmpty) ...[
              _buildMacroscopicDescription(context),
              SizedBox(height: padding * 1.75),
            ],
            
            // Microscopic Description
            if (widget.plant.microscopicDescription.isNotEmpty) ...[
              _buildMicroscopicDescription(context),
              SizedBox(height: padding * 1.75),
            ],
            
            // Constituents
            if (widget.plant.constituents.isNotEmpty) ...[
              _buildConstituents(context),
              SizedBox(height: padding * 1.75),
            ],
            
            // Guna Shloka
            if (widget.plant.gunaShloka.isNotEmpty) ...[
              _buildGunaShloka(context),
              SizedBox(height: padding * 1.75),
            ],
            
            // Interesting Facts
            if (widget.plant.interestingFacts.isNotEmpty) ...[
              _buildPlantFacts(context),
              SizedBox(height: padding * 1.75),
            ],
            
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  Widget _buildPlantHeader(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 360;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                widget.plant.name,
                style: TextStyle(
                  fontSize: _getResponsiveFontSize(context, 28),
                  fontWeight: FontWeight.bold,
                  color: kTextColor,
                ),
              ),
            ),
            SizedBox(width: 8),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: isSmallScreen ? 10 : 12,
                vertical: isSmallScreen ? 4 : 6,
              ),
              decoration: BoxDecoration(
                color: kPrimaryColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(isSmallScreen ? 16 : 20),
              ),
              child: Text(
                widget.plant.category,
                style: TextStyle(
                  fontSize: _getResponsiveFontSize(context, 12),
                  fontWeight: FontWeight.w600,
                  color: kPrimaryColor,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          widget.plant.scientificName,
          style: TextStyle(
            fontSize: _getResponsiveFontSize(context, 16),
            fontStyle: FontStyle.italic,
            color: Colors.grey.shade600,
          ),
        ),
        if (widget.plant.synonyms.isNotEmpty) ...[
          SizedBox(height: 8),
          Text(
            'Synonyms: ${widget.plant.synonyms.join(', ')}',
            style: TextStyle(
              fontSize: _getResponsiveFontSize(context, 14),
              color: Colors.grey.shade600,
            ),
          ),
        ],
        SizedBox(height: isSmallScreen ? 10 : 12),
        Wrap(
          spacing: isSmallScreen ? 12 : 16,
          runSpacing: 8,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.star,
                  color: Colors.amber.shade600,
                  size: isSmallScreen ? 16 : 18,
                ),
                SizedBox(width: isSmallScreen ? 3 : 4),
                Text(
                  '${widget.plant.difficultyLevel} Care',
                  style: TextStyle(
                    fontSize: _getResponsiveFontSize(context, 14),
                    fontWeight: FontWeight.w600,
                    color: kTextColor,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.access_time,
                  color: Colors.grey.shade600,
                  size: isSmallScreen ? 14 : 16,
                ),
                SizedBox(width: isSmallScreen ? 3 : 4),
                Text(
                  widget.plant.growthTime,
                  style: TextStyle(
                    fontSize: _getResponsiveFontSize(context, 14),
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
             /* children: [
                Icon(
                  Icons.attach_money,
                  color: Colors.green.shade600,
                  size: isSmallScreen ? 14 : 16,
                ),
                SizedBox(width: isSmallScreen ? 3 : 4),
                Text(
                  'LKR ${widget.plant.price}',
                  style: TextStyle(
                    fontSize: _getResponsiveFontSize(context, 14),
                    color: Colors.green.shade600,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],*/
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPlantNames(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(_getResponsivePadding(context)),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            widget.plant.backgroundColor.withOpacity(0.1),
            widget.plant.backgroundColor.withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: widget.plant.backgroundColor.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildNameRow('සිංහල', widget.plant.sinhalaName),
          Divider(height: 16, color: Colors.grey.shade300),
          _buildNameRow('संस्कृत', widget.plant.sanskritName),
          Divider(height: 16, color: Colors.grey.shade300),
          _buildNameRow('English', widget.plant.englishName),
          Divider(height: 16, color: Colors.grey.shade300),
          _buildNameRow('Family', widget.plant.family),
        ],
      ),
    );
  }

  Widget _buildNameRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 80,
          child: Text(
            label,
            style: TextStyle(
              fontSize: _getResponsiveFontSize(context, 14),
              fontWeight: FontWeight.w600,
              color: kPrimaryColor,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: _getResponsiveFontSize(context, 14),
              color: kTextColor,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPlantStats(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 360;
    final padding = _getResponsivePadding(context);
    
    return Container(
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(isSmallScreen ? 12 : 16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem(context, Icons.wb_sunny_outlined, 'Light', widget.plant.lightLevel),
          _buildStatItem(context, Icons.opacity, 'Water', widget.plant.waterLevel),
          _buildStatItem(context, Icons.thermostat, 'Temp', widget.plant.temperature),
          _buildStatItem(context, Icons.straighten, 'Growth', widget.plant.growthRate),
        ],
      ),
    );
  }

  Widget _buildStatItem(BuildContext context, IconData icon, String label, String value) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 360;
    
    return Column(
      children: [
        Icon(
          icon,
          size: isSmallScreen ? 20 : 24,
          color: kPrimaryColor,
        ),
        SizedBox(height: isSmallScreen ? 6 : 8),
        Text(
          label,
          style: TextStyle(
            fontSize: _getResponsiveFontSize(context, 12),
            color: Colors.grey.shade600,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: isSmallScreen ? 2 : 4),
        Text(
          value,
          style: TextStyle(
            fontSize: _getResponsiveFontSize(context, 14),
            fontWeight: FontWeight.w600,
            color: kTextColor,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildDescription(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'About',
          style: TextStyle(
            fontSize: _getResponsiveFontSize(context, 20),
            fontWeight: FontWeight.bold,
            color: kTextColor,
          ),
        ),
        SizedBox(height: _getResponsivePadding(context) * 0.75),
        Text(
          widget.plant.description,
          style: TextStyle(
            fontSize: _getResponsiveFontSize(context, 16),
            height: 1.6,
            color: Colors.grey.shade700,
          ),
        ),
      ],
    );
  }

  Widget _buildAyurvedicProperties(BuildContext context) {
    final props = widget.plant.ayurvedicProperties;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Ayurvedic Properties',
          style: TextStyle(
            fontSize: _getResponsiveFontSize(context, 20),
            fontWeight: FontWeight.bold,
            color: kTextColor,
          ),
        ),
        SizedBox(height: _getResponsivePadding(context)),
        _buildPropertyCard('Rasa (Taste)', props.rasa.join(', '), Icons.restaurant),
        _buildPropertyCard('Guna (Quality)', props.guna.join(', '), Icons.science),
        _buildPropertyCard('Virya (Potency)', props.virya, Icons.local_fire_department),
        _buildPropertyCard('Vipaka (Post-digestion)', props.vipaka, Icons.health_and_safety),
        _buildPropertyCard('Effect on Tridosha', props.effectOnTridosha, Icons.balance),
        SizedBox(height: 8),
        _buildPropertyCard('Karma (Actions)', props.karma.join(', '), Icons.autorenew),
      ],
    );
  }

  Widget _buildPropertyCard(String title, String value, IconData icon) {
    final padding = _getResponsivePadding(context);
    
    return Container(
      margin: EdgeInsets.only(bottom: padding * 0.75),
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: kPrimaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: kPrimaryColor, size: 20),
          ),
          SizedBox(width: padding),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: _getResponsiveFontSize(context, 14),
                    fontWeight: FontWeight.w600,
                    color: kPrimaryColor,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: _getResponsiveFontSize(context, 14),
                    color: kTextColor,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUsedParts(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Used Parts',
          style: TextStyle(
            fontSize: _getResponsiveFontSize(context, 20),
            fontWeight: FontWeight.bold,
            color: kTextColor,
          ),
        ),
        SizedBox(height: _getResponsivePadding(context)),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: widget.plant.usedParts.map((part) => Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.purple.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.purple.withOpacity(0.3)),
            ),
            child: Text(
              part,
              style: TextStyle(
                fontSize: _getResponsiveFontSize(context, 13),
                color: Colors.purple.shade700,
                fontWeight: FontWeight.w500,
              ),
            ),
          )).toList(),
        ),
      ],
    );
  }

  Widget _buildCareInstructions(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Care Instructions',
          style: TextStyle(
            fontSize: _getResponsiveFontSize(context, 20),
            fontWeight: FontWeight.bold,
            color: kTextColor,
          ),
        ),
        SizedBox(height: _getResponsivePadding(context)),
        ...widget.plant.careInstructions
            .map((instruction) => _buildCareItem(context, instruction))
            .toList(),
      ],
    );
  }

  Widget _buildCareItem(BuildContext context, CareInstruction instruction) {
    final padding = _getResponsivePadding(context);
    
    return Container(
      margin: EdgeInsets.only(bottom: padding * 0.75),
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: instruction.color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              instruction.icon,
              color: instruction.color,
              size: 20,
            ),
          ),
          SizedBox(width: padding),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  instruction.title,
                  style: TextStyle(
                    fontSize: _getResponsiveFontSize(context, 16),
                    fontWeight: FontWeight.w600,
                    color: kTextColor,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  instruction.description,
                  style: TextStyle(
                    fontSize: _getResponsiveFontSize(context, 14),
                    color: Colors.grey.shade600,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlantBenefits(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 360;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Plant Benefits',
          style: TextStyle(
            fontSize: _getResponsiveFontSize(context, 20),
            fontWeight: FontWeight.bold,
            color: kTextColor,
          ),
        ),
        SizedBox(height: _getResponsivePadding(context)),
        Wrap(
          spacing: isSmallScreen ? 6 : 8,
          runSpacing: isSmallScreen ? 6 : 8,
          children: widget.plant.benefits
              .map((benefit) => Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: isSmallScreen ? 12 : 16,
                      vertical: isSmallScreen ? 6 : 8,
                    ),
                    decoration: BoxDecoration(
                      color: kPrimaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(isSmallScreen ? 16 : 20),
                      border: Border.all(color: kPrimaryColor.withOpacity(0.3)),
                    ),
                    child: Text(
                      benefit,
                      style: TextStyle(
                        fontSize: _getResponsiveFontSize(context, 14),
                        fontWeight: FontWeight.w500,
                        color: kPrimaryColor,
                      ),
                    ),
                  ))
              .toList(),
        ),
      ],
    );
  }

  Widget _buildTherapeuticUses(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Traditional Therapeutic Uses',
          style: TextStyle(
            fontSize: _getResponsiveFontSize(context, 20),
            fontWeight: FontWeight.bold,
            color: kTextColor,
          ),
        ),
        SizedBox(height: _getResponsivePadding(context)),
        ...widget.plant.therapeuticUses.map((use) => Padding(
          padding: EdgeInsets.only(bottom: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(top: 6),
                width: 6,
                height: 6,
                decoration: BoxDecoration(
                  color: kPrimaryColor,
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  use,
                  style: TextStyle(
                    fontSize: _getResponsiveFontSize(context, 14),
                    color: Colors.grey.shade700,
                    height: 1.5,
                  ),
                ),
              ),
            ],
          ),
        )).toList(),
      ],
    );
  }

  Widget _buildModernTherapeutics(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Modern Therapeutics',
          style: TextStyle(
            fontSize: _getResponsiveFontSize(context, 20),
            fontWeight: FontWeight.bold,
            color: kTextColor,
          ),
        ),
        SizedBox(height: _getResponsivePadding(context)),
        ...widget.plant.modernTherapeutics.map((use) => Padding(
          padding: EdgeInsets.only(bottom: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(top: 6),
                width: 6,
                height: 6,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  use,
                  style: TextStyle(
                    fontSize: _getResponsiveFontSize(context, 14),
                    color: Colors.grey.shade700,
                    height: 1.5,
                  ),
                ),
              ),
            ],
          ),
        )).toList(),
      ],
    );
  }

  Widget _buildFormulations(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Important Formulations',
          style: TextStyle(
            fontSize: _getResponsiveFontSize(context, 20),
            fontWeight: FontWeight.bold,
            color: kTextColor,
          ),
        ),
        SizedBox(height: _getResponsivePadding(context)),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: widget.plant.importantFormulations.map((formulation) => Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.orange.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.orange.withOpacity(0.3)),
            ),
            child: Text(
              formulation,
              style: TextStyle(
                fontSize: _getResponsiveFontSize(context, 13),
                color: Colors.orange.shade700,
                fontWeight: FontWeight.w500,
              ),
            ),
          )).toList(),
        ),
      ],
    );
  }

  Widget _buildDosageInfo(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(_getResponsivePadding(context)),
      decoration: BoxDecoration(
        color: Colors.amber.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.amber.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Icon(Icons.medical_services, color: Colors.amber.shade700, size: 24),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Dosage',
                  style: TextStyle(
                    fontSize: _getResponsiveFontSize(context, 16),
                    fontWeight: FontWeight.w600,
                    color: Colors.amber.shade900,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  widget.plant.dose,
                  style: TextStyle(
                    fontSize: _getResponsiveFontSize(context, 14),
                    color: Colors.amber.shade800,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Consult an Ayurvedic practitioner before use',
                  style: TextStyle(
                    fontSize: _getResponsiveFontSize(context, 12),
                    fontStyle: FontStyle.italic,
                    color: Colors.red.shade700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMacroscopicDescription(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Macroscopic Description',
          style: TextStyle(
            fontSize: _getResponsiveFontSize(context, 20),
            fontWeight: FontWeight.bold,
            color: kTextColor,
          ),
        ),
        SizedBox(height: _getResponsivePadding(context)),
        Container(
          padding: EdgeInsets.all(_getResponsivePadding(context)),
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Text(
            widget.plant.macroscopicDescription,
            style: TextStyle(
              fontSize: _getResponsiveFontSize(context, 14),
              color: Colors.grey.shade700,
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMicroscopicDescription(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Microscopic Description',
          style: TextStyle(
            fontSize: _getResponsiveFontSize(context, 20),
            fontWeight: FontWeight.bold,
            color: kTextColor,
          ),
        ),
        SizedBox(height: _getResponsivePadding(context)),
        Container(
          padding: EdgeInsets.all(_getResponsivePadding(context)),
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Text(
            widget.plant.microscopicDescription,
            style: TextStyle(
              fontSize: _getResponsiveFontSize(context, 14),
              color: Colors.grey.shade700,
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildConstituents(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Chemical Constituents',
          style: TextStyle(
            fontSize: _getResponsiveFontSize(context, 20),
            fontWeight: FontWeight.bold,
            color: kTextColor,
          ),
        ),
        SizedBox(height: _getResponsivePadding(context)),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: widget.plant.constituents.map((constituent) => Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.green.withOpacity(0.3)),
            ),
            child: Text(
              constituent,
              style: TextStyle(
                fontSize: _getResponsiveFontSize(context, 13),
                color: Colors.green.shade700,
                fontWeight: FontWeight.w500,
              ),
            ),
          )).toList(),
        ),
      ],
    );
  }

  Widget _buildGunaShloka(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(_getResponsivePadding(context)),
      decoration: BoxDecoration(
        color: Colors.brown.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.brown.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.book, color: Colors.brown.shade700, size: 24),
              SizedBox(width: 12),
              Text(
                'Guna Shloka',
                style: TextStyle(
                  fontSize: _getResponsiveFontSize(context, 18),
                  fontWeight: FontWeight.bold,
                  color: Colors.brown.shade800,
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Text(
            widget.plant.gunaShloka,
            style: TextStyle(
              fontSize: _getResponsiveFontSize(context, 14),
              color: Colors.brown.shade700,
              fontStyle: FontStyle.italic,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlantFacts(BuildContext context) {
    final padding = _getResponsivePadding(context);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Interesting Facts',
          style: TextStyle(
            fontSize: _getResponsiveFontSize(context, 20),
            fontWeight: FontWeight.bold,
            color: kTextColor,
          ),
        ),
        SizedBox(height: padding),
        ...widget.plant.interestingFacts
            .map((fact) => Container(
                  margin: EdgeInsets.only(bottom: padding * 0.75),
                  padding: EdgeInsets.all(padding),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: kPrimaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          Icons.lightbulb_outline,
                          color: kPrimaryColor,
                          size: 20,
                        ),
                      ),
                      SizedBox(width: padding),
                      Expanded(
                        child: Text(
                          fact,
                          style: TextStyle(
                            fontSize: _getResponsiveFontSize(context, 14),
                            color: Colors.grey.shade700,
                            height: 1.4,
                          ),
                        ),
                      ),
                    ],
                  ),
                ))
            .toList(),
      ],
    );
  }

  Widget _buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Added to My Plants!'),
            backgroundColor: kPrimaryColor,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
      },
      backgroundColor: kPrimaryColor,
      foregroundColor: Colors.white,
      elevation: 8,
      label: Text(
        'Add to My Plants',
        style: TextStyle(
          fontSize: _getResponsiveFontSize(context, 16),
          fontWeight: FontWeight.w600,
        ),
      ),
      icon: Icon(Icons.add, size: 24),
    );
  }
}