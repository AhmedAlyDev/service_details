import 'dart:async';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:quarizm_ui_task/widgets/custom_icon_button.dart';
import 'package:quarizm_ui_task/widgets/custom_page_indicator.dart';

class ServiceDetails extends StatefulWidget {
  const ServiceDetails({super.key});

  @override
  State<ServiceDetails> createState() => _ServiceDetailsState();
}

class _ServiceDetailsState extends State<ServiceDetails> {
  late Timer _timer;
  int _currentPage = 0;
  int _quantity = 1;
  late final PageController _pageController = PageController(
    initialPage: _currentPage,
  );

  final images = [
    'assets/images/1.jpg',
    'assets/images/2.png',
    'assets/images/3.jpg',
  ];

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      if (_currentPage < images.length) {
        _changePage(_currentPage++);
      } else {
        _changePage(0);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
    _timer.cancel();
  }

  void _onPageChanged(int page) {
    setState(() => _currentPage = page);
  }

  void _changePage(int page) {
    _pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 750),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildImageSlider(height, width),
            _buildDetails(),
          ],
        ),
      ),
    );
  }

  Padding _buildDetails() {
    return Padding(
      padding: const EdgeInsets.all(26.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ..._buildServiceNameAndPrice(),
          _buildRating(),
          _buildDescription(),
          const SizedBox(
            height: 16,
          ),
          _buildActionButtons()
        ],
      ),
    );
  }

  Row _buildActionButtons() {
    return Row(
      children: [
        CustomIconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.favorite,
            color: Colors.red,
            size: 25,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _buildAppointmentButton(),
        )
      ],
    );
  }

  Container _buildAppointmentButton() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
          colors: [Colors.green, Colors.yellow[600]!],
        ),
      ),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          foregroundColor: Colors.white,
          minimumSize: const Size(double.maxFinite, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: const Text('Make  Appointment'),
      ),
    );
  }

  SelectableText _buildDescription() {
    return const SelectableText(
      'Minimal Stand is made of by natural wood. The design that is very simple and minimal. This is truly onne of the best furnitures in any family for now. With 3 different colors. You can easily select the best match for your name.',
      textAlign: TextAlign.justify,
    );
  }

  Padding _buildRating() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Icon(
            Icons.star,
            color: Colors.yellow[600],
          ),
          const Text(
            '  4.5',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Text('  (50 reviews)'),
        ],
      ),
    );
  }

  List<Widget> _buildServiceNameAndPrice() {
    return [
      const Text(
        'Service Name',
        style: TextStyle(
          fontSize: 26,
          fontWeight: FontWeight.bold,
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            '\$ 50.00',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),
          _buildQuantitySelector()
        ],
      ),
    ];
  }

  Row _buildQuantitySelector() {
    return Row(
      children: [
        CustomIconButton(
          icon: const Icon(Icons.add),
          onPressed: () => setState(() => _quantity++),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            _quantity.toString().padLeft(2, '0'),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
        ),
        CustomIconButton(
          icon: const Icon(Icons.remove),
          onPressed: () => _quantity > 0 ? setState(() => _quantity--) : null,
        ),
      ],
    );
  }

  SizedBox _buildImageSlider(double height, double width) {
    return SizedBox(
      height: height * 0.6,
      child: Stack(
        children: [
          _buildPageView(height, width),
          _buildPageIndicator(),
          _buildThumbnailsSelector(width)
        ],
      ),
    );
  }

  PositionedDirectional _buildThumbnailsSelector(double width) {
    return PositionedDirectional(
      start: width * 0.1 - 30,
      top: width * 0.6 / 2,
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(30)),
        child: Container(
          width: 60,
          height: 220,
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: images
                .mapIndexed(
                  (i, image) => InkWell(
                    onTap: () => _changePage(i),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        border: _currentPage == i
                            ? Border.all(color: Colors.green, width: 3)
                            : null,
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage(image),
                        ),
                      ),
                      // child: Placeholder(),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }

  PositionedDirectional _buildPageIndicator() {
    return PositionedDirectional(
      bottom: 40,
      end: 100,
      child: CustomPageIndicator(
        onTap: _changePage,
        currentPage: _currentPage,
        numPages: images.length,
      ),
    );
  }

  PositionedDirectional _buildPageView(double height, double width) {
    return PositionedDirectional(
      end: 0,
      top: 0,
      child: ClipRRect(
        borderRadius: const BorderRadiusDirectional.only(
          bottomStart: Radius.circular(25),
        ),
        child: SizedBox(
          height: height * 0.6,
          width: width * 0.9,
          child: PageView(
            controller: _pageController,
            onPageChanged: _onPageChanged,
            physics: const ClampingScrollPhysics(),
            children: images
                .map(
                  (image) => Image.asset(
                    image,
                    fit: BoxFit.cover,
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}
