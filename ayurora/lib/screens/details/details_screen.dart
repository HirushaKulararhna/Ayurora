import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ayurora/constants.dart';
import 'package:ayurora/models/plant.dart';

class DetailsScreen extends StatefulWidget {
  final Plant plant;

  const DetailsScreen({
    super.key,
    required this.plant,
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

  void _nextImage() {
    if (_currentImageIndex < widget.plant.galleryImages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _previousImage() {
    if (_currentImageIndex > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
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

  double _getExpandedHeight(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    if (width >= 900) return 500;
    if (width >= 600) return 450;
    if (height < 700) return 350;
    return 450;
  }

  double _getImageHeight(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    if (width >= 900) return 400;
    if (width >= 600) return 350;
    if (height < 700) return 250;
    return 300;
  }

  // Check if plant has multiple images
  bool get hasMultipleImages => widget.plant.galleryImages.length > 1;

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
      expandedHeight: _getExpandedHeight(context),
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
                  height: _getImageHeight(context),
                  margin: EdgeInsets.symmetric(
                    horizontal: isSmallScreen ? 12 : 20,
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // PageView for image gallery (works with single or multiple images)
                      PageView.builder(
                        controller: _pageController,
                        physics: hasMultipleImages 
                            ? const PageScrollPhysics() 
                            : const NeverScrollableScrollPhysics(),
                        onPageChanged: (index) {
                          if (hasMultipleImages) {
                            setState(() {
                              _currentImageIndex = index;
                            });
                          }
                        },
                        itemCount: widget.plant.galleryImages.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.symmetric(
                              horizontal: isSmallScreen ? 5 : 10,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                isSmallScreen ? 16 : 20,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: kPrimaryColor.withOpacity(0.3),
                                  blurRadius: 30,
                                  offset: const Offset(0, 10),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(
                                isSmallScreen ? 16 : 20,
                              ),
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
                      
                      // Previous button (only show if multiple images and not on first)
                      if (hasMultipleImages && _currentImageIndex > 0)
                        Positioned(
                          left: 0,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.9),
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: IconButton(
                              iconSize: isSmallScreen ? 18 : 24,
                              icon: Icon(Icons.arrow_back_ios_new, color: kPrimaryColor),
                              onPressed: _previousImage,
                            ),
                          ),
                        ),
                      
                      // Next button (only show if multiple images and not on last)
                      if (hasMultipleImages && _currentImageIndex < widget.plant.galleryImages.length - 1)
                        Positioned(
                          right: 0,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.9),
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: IconButton(
                              iconSize: isSmallScreen ? 18 : 24,
                              icon: Icon(Icons.arrow_forward_ios, color: kPrimaryColor),
                              onPressed: _nextImage,
                            ),
                          ),
                        ),
                      
                      // Page indicators (only show if multiple images)
                      if (hasMultipleImages)
                        Positioned(
                          bottom: isSmallScreen ? 12 : 20,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              widget.plant.galleryImages.length,
                              (index) => Container(
                                margin: EdgeInsets.symmetric(
                                  horizontal: isSmallScreen ? 3 : 4,
                                ),
                                width: _currentImageIndex == index 
                                  ? (isSmallScreen ? 20 : 24) 
                                  : (isSmallScreen ? 6 : 8),
                                height: isSmallScreen ? 6 : 8,
                                decoration: BoxDecoration(
                                  color: _currentImageIndex == index
                                      ? kPrimaryColor
                                      : Colors.white.withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(4),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      blurRadius: 4,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      
                      // Image counter (only show if multiple images)
                      if (hasMultipleImages)
                        Positioned(
                          top: isSmallScreen ? 12 : 20,
                          right: isSmallScreen ? 12 : 20,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: isSmallScreen ? 8 : 12,
                              vertical: isSmallScreen ? 4 : 6,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.6),
                              borderRadius: BorderRadius.circular(
                                isSmallScreen ? 16 : 20,
                              ),
                            ),
                            child: Text(
                              '${_currentImageIndex + 1}/${widget.plant.galleryImages.length}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: isSmallScreen ? 10 : 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                    ],
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
            _buildPlantStats(context),
            SizedBox(height: padding * 1.75),
            _buildDescription(context),
            SizedBox(height: padding * 1.75),
            _buildCareInstructions(context),
            SizedBox(height: padding * 1.75),
            _buildPlantBenefits(context),
            SizedBox(height: padding * 1.75),
            _buildPlantFacts(context),
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
          ],
        ),
      ],
    );
  }

  Widget _buildPlantStats(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 360;
    final isVerySmallScreen = screenWidth < 340;
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
      child: isVerySmallScreen
          ? Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildStatItem(context, Icons.wb_sunny_outlined, 'Light', widget.plant.lightLevel),
                    _buildStatItem(context, Icons.opacity, 'Water', widget.plant.waterLevel),
                  ],
                ),
                SizedBox(height: padding),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildStatItem(context, Icons.thermostat, 'Temp', widget.plant.temperature),
                    _buildStatItem(context, Icons.straighten, 'Growth', widget.plant.growthRate),
                  ],
                ),
              ],
            )
          : Row(
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
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 360;
    final padding = _getResponsivePadding(context);
    
    return Container(
      margin: EdgeInsets.only(bottom: padding * 0.75),
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(isSmallScreen ? 10 : 12),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(isSmallScreen ? 6 : 8),
            decoration: BoxDecoration(
              color: instruction.color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(isSmallScreen ? 6 : 8),
            ),
            child: Icon(
              instruction.icon,
              color: instruction.color,
              size: isSmallScreen ? 18 : 20,
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
                SizedBox(height: isSmallScreen ? 2 : 4),
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

  Widget _buildPlantFacts(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 360;
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
                    borderRadius: BorderRadius.circular(isSmallScreen ? 10 : 12),
                    border: Border.all(color: Colors.grey.shade200),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.03),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.all(isSmallScreen ? 6 : 8),
                        decoration: BoxDecoration(
                          color: kPrimaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(isSmallScreen ? 6 : 8),
                        ),
                        child: Icon(
                          Icons.lightbulb_outline,
                          color: kPrimaryColor,
                          size: isSmallScreen ? 18 : 20,
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
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 360;
    
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
      icon: Icon(
        Icons.add,
        size: isSmallScreen ? 20 : 24,
      ),
    );
  }
}