import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_flutter_app/mentee/screen/premium_class/Karier/karier_screen.dart';
import 'package:my_flutter_app/mentee/screen/premium_class/Kuliah/kuliah_screen.dart';
import 'package:my_flutter_app/mentee/screen/premium_class/SD/sd_screen.dart';
import 'package:my_flutter_app/mentee/screen/premium_class/SMA/sma_screen.dart';
import 'package:my_flutter_app/mentee/screen/premium_class/SMP/smp_screen.dart';
import 'package:my_flutter_app/mentee/screen/premium_class/premiumclass_page.dart';
import 'package:my_flutter_app/mentee/screen/profile/mentee_profile_screen.dart';
import 'package:my_flutter_app/mentee/screen/session/session_screen.dart';
import 'package:my_flutter_app/widget/logo_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomDropdown extends StatefulWidget {
  final String title; // Tambahkan properti title

  CustomDropdown({Key? key, required this.title}) : super(key: key);

  @override
  _CustomDropdownState createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: () {
          Future.delayed(Duration.zero, () {
            _showDropdown(context);
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Icon(
                Icons.arrow_drop_down,
                color: Colors.black,
              ),
              const SizedBox(width: 8),
              Text(
                widget.title,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showDropdown(BuildContext context) async {
    try {
      final RenderBox box = context.findRenderObject() as RenderBox;
      final Offset target = box.localToGlobal(Offset(0.0, box.size.height));
      final RenderBox overlay =
          Overlay.of(context).context.findRenderObject() as RenderBox;

      final RelativeRect position = RelativeRect.fromRect(
        Rect.fromPoints(
          target,
          target.translate(box.size.width, 0),
        ),
        Offset.zero & overlay.size,
      );

      final String? result = await showMenu<String>(
        context: context,
        position: position,
        items: [
          PopupMenuItem<String>(
            value: 'Premium Class',
            child: SizedBox(
              width: 200,
              child: Text('Premium Class'),
            ),
          ),
          PopupMenuItem<String>(
            value: 'Sessions',
            child: SizedBox(
              width: 200,
              child: Text('Sessions'),
            ),
          ),
        ],
      );

      if (result == 'Premium Class') {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PremiumClassPage()),
        );
      } else if (result == 'Sessions') {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SessionScreen()),
        );
      }

      setState(() {
        if (result != 'Program dan Layanan' && result != 'Sessions') {
          selectedValue = result;
        }
      });
    } catch (error) {
      print('Error navigating to PremiumClassPage: $error');
    }
  }
}

// CustomDropdown for SD, SMP, SMA, Kuliah, Karier
class CustomDropdownCategory extends StatefulWidget {
  final String title; // Tambahkan properti title

  CustomDropdownCategory({Key? key, required this.title}) : super(key: key);

  @override
  _CustomDropdownCategoryState createState() => _CustomDropdownCategoryState();
}

class _CustomDropdownCategoryState extends State<CustomDropdownCategory> {
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: () {
          Future.delayed(Duration.zero, () {
            _showDropdown(context);
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Icon(
                Icons.arrow_drop_down,
                color: Colors.black,
              ),
              const SizedBox(width: 8),
              Text(
                widget.title,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showDropdown(BuildContext context) async {
    try {
      final RenderBox box = context.findRenderObject() as RenderBox;
      final Offset target = box.localToGlobal(Offset(0.0, box.size.height));
      final RenderBox overlay =
          Overlay.of(context).context.findRenderObject() as RenderBox;

      final RelativeRect position = RelativeRect.fromRect(
        Rect.fromPoints(
          target,
          target.translate(box.size.width, 0),
        ),
        Offset.zero & overlay.size,
      );

      final String? result = await showMenu<String>(
        context: context,
        position: position,
        items: [
          PopupMenuItem<String>(
            value: 'SD',
            child: SizedBox(
              width: 200,
              child: Text('SD'),
            ),
          ),
          PopupMenuItem<String>(
            value: 'SMP',
            child: SizedBox(
              width: 200,
              child: Text('SMP'),
            ),
          ),
          PopupMenuItem<String>(
            value: 'SMA',
            child: SizedBox(
              width: 200,
              child: Text('SMA'),
            ),
          ),
          PopupMenuItem<String>(
            value: 'Kuliah',
            child: SizedBox(
              width: 200,
              child: Text('Kuliah'),
            ),
          ),
          PopupMenuItem<String>(
            value: 'Karier',
            child: SizedBox(
              width: 200,
              child: Text('Karier'),
            ),
          ),
        ],
      );

      if (result == 'SD') {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SDScreen()),
        );
      } else if (result == 'SMP') {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SMPScreen()),
        );
      } else if (result == 'SMA') {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SMAScreen()),
        );
      } else if (result == 'Kuliah') {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => KuliahScreen()),
        );
      } else if (result == 'Karier') {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => KarierScreen()),
        );
      }
    } catch (error) {
      print('Error navigating to PremiumClassPage: $error');
    }
  }
}

class NavbarWidgetMentee extends StatefulWidget {
  const NavbarWidgetMentee({Key? key}) : super(key: key);

  @override
  State<NavbarWidgetMentee> createState() => _NavbarWidgetMenteeState();
}

class _NavbarWidgetMenteeState extends State<NavbarWidgetMentee> {
  String _photoUrl = "";

  Future<void> _loadProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      /// photourl
      _photoUrl = prefs.getString('photoUrl') ?? "";
    });
  }

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              ButtonLogoMenteeMatch(),
              const SizedBox(width: 20),
            ],
          ),
          Row(
            children: [
              CustomDropdown(
                title: 'Program dan Layanan',
              ),
              const SizedBox(width: 20),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProfileMenteeScreen()),
                      );
                    },
                    child: _buildCircularImage(
                      _photoUrl,
                      40,
                      40,
                      null,
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCircularImage(
    String imageUrl,
    double height,
    double width,
    Color? color,
  ) {
    return ClipOval(
      child: CachedNetworkImage(
        placeholder: (context, url) => Center(
          child: CircularProgressIndicator(),
        ),
        errorWidget: (context, url, error) => Image.asset(
          'assets/blank_profile.jpg',
          fit: BoxFit.cover,
        ),
        imageUrl: imageUrl,
        height: height,
        width: width,
        fit: BoxFit.cover,
        color: color,
        colorBlendMode: color != null ? BlendMode.modulate : null,
      ),
    );
  }
}

// NavbarPremiumClass
class NavbarWidgetPremiumClass extends StatefulWidget {
  const NavbarWidgetPremiumClass({Key? key}) : super(key: key);

  @override
  State<NavbarWidgetPremiumClass> createState() =>
      _NavbarWidgetPremiumClassState();
}

class _NavbarWidgetPremiumClassState extends State<NavbarWidgetPremiumClass> {
  String _photoUrl = "";

  Future<void> _loadProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      /// photourl
      _photoUrl = prefs.getString('photoUrl') ?? "";
    });
  }

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              ButtonLogoMenteeMatch(),
              const SizedBox(width: 20),
            ],
          ),
          Row(
            children: [
              CustomDropdown(
                title: 'Premium Class',
              ),
              const SizedBox(width: 20),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProfileMenteeScreen()),
                      );
                    },
                    child: _buildCircularImage(
                      _photoUrl,
                      40,
                      40,
                      null,
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCircularImage(
    String imageUrl,
    double height,
    double width,
    Color? color,
  ) {
    return ClipOval(
      child: CachedNetworkImage(
        placeholder: (context, url) => Center(
          child: CircularProgressIndicator(),
        ),
        errorWidget: (context, url, error) => Image.asset(
          'assets/blank_profile.jpg',
          fit: BoxFit.cover,
        ),
        imageUrl: imageUrl,
        height: height,
        width: width,
        fit: BoxFit.cover,
        color: color,
        colorBlendMode: color != null ? BlendMode.modulate : null,
      ),
    );
  }
}

// NavbarSession
class NavbarWidgetSession extends StatefulWidget {
  const NavbarWidgetSession({Key? key}) : super(key: key);

  @override
  State<NavbarWidgetSession> createState() => _NavbarWidgetSessionState();
}

class _NavbarWidgetSessionState extends State<NavbarWidgetSession> {
  String _photoUrl = "";

  Future<void> _loadProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      /// photourl
      _photoUrl = prefs.getString('photoUrl') ?? "";
    });
  }

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              ButtonLogoMenteeMatch(),
              const SizedBox(width: 20),
            ],
          ),
          Row(
            children: [
              CustomDropdown(
                title: 'Sessions',
              ),
              const SizedBox(width: 20),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProfileMenteeScreen()),
                      );
                    },
                    child: _buildCircularImage(
                      _photoUrl,
                      40,
                      40,
                      null,
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCircularImage(
    String imageUrl,
    double height,
    double width,
    Color? color,
  ) {
    return ClipOval(
      child: CachedNetworkImage(
        placeholder: (context, url) => Center(
          child: CircularProgressIndicator(),
        ),
        errorWidget: (context, url, error) => Image.asset(
          'assets/blank_profile.jpg',
          fit: BoxFit.cover,
        ),
        imageUrl: imageUrl,
        height: height,
        width: width,
        fit: BoxFit.cover,
        color: color,
        colorBlendMode: color != null ? BlendMode.modulate : null,
      ),
    );
  }
}

// NavbarSD
class NavbarWidgetSD extends StatefulWidget {
  const NavbarWidgetSD({Key? key}) : super(key: key);

  @override
  State<NavbarWidgetSD> createState() => _NavbarWidgetSDState();
}

class _NavbarWidgetSDState extends State<NavbarWidgetSD> {
  String _photoUrl = "";

  Future<void> _loadProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      /// photourl
      _photoUrl = prefs.getString('photoUrl') ?? "";
    });
  }

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              ButtonLogoMenteeMatch(),
              const SizedBox(width: 20),
            ],
          ),
          Row(
            children: [
              CustomDropdownCategory(
                title: 'SD',
              ),
              const SizedBox(width: 20),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProfileMenteeScreen()),
                      );
                    },
                    child: _buildCircularImage(
                      _photoUrl,
                      40,
                      40,
                      null,
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCircularImage(
    String imageUrl,
    double height,
    double width,
    Color? color,
  ) {
    return ClipOval(
      child: CachedNetworkImage(
        placeholder: (context, url) => Center(
          child: CircularProgressIndicator(),
        ),
        errorWidget: (context, url, error) => Image.asset(
          'assets/blank_profile.jpg',
          fit: BoxFit.cover,
        ),
        imageUrl: imageUrl,
        height: height,
        width: width,
        fit: BoxFit.cover,
        color: color,
        colorBlendMode: color != null ? BlendMode.modulate : null,
      ),
    );
  }
}

// NavbarSMP
class NavbarWidgetSMP extends StatefulWidget {
  const NavbarWidgetSMP({Key? key}) : super(key: key);

  @override
  State<NavbarWidgetSMP> createState() => _NavbarWidgetSMPState();
}

class _NavbarWidgetSMPState extends State<NavbarWidgetSMP> {
  String _photoUrl = "";

  Future<void> _loadProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      /// photourl
      _photoUrl = prefs.getString('photoUrl') ?? "";
    });
  }

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              ButtonLogoMenteeMatch(),
              const SizedBox(width: 20),
            ],
          ),
          Row(
            children: [
              CustomDropdownCategory(
                title: 'SMP',
              ),
              const SizedBox(width: 20),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProfileMenteeScreen()),
                      );
                    },
                    child: _buildCircularImage(
                      _photoUrl,
                      40,
                      40,
                      null,
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCircularImage(
    String imageUrl,
    double height,
    double width,
    Color? color,
  ) {
    return ClipOval(
      child: CachedNetworkImage(
        placeholder: (context, url) => Center(
          child: CircularProgressIndicator(),
        ),
        errorWidget: (context, url, error) => Image.asset(
          'assets/blank_profile.jpg',
          fit: BoxFit.cover,
        ),
        imageUrl: imageUrl,
        height: height,
        width: width,
        fit: BoxFit.cover,
        color: color,
        colorBlendMode: color != null ? BlendMode.modulate : null,
      ),
    );
  }
}

// NavbarSMA
class NavbarWidgetSMA extends StatefulWidget {
  const NavbarWidgetSMA({Key? key}) : super(key: key);

  @override
  State<NavbarWidgetSMA> createState() => _NavbarWidgetSMAState();
}

class _NavbarWidgetSMAState extends State<NavbarWidgetSMA> {
  String _photoUrl = "";

  Future<void> _loadProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      /// photourl
      _photoUrl = prefs.getString('photoUrl') ?? "";
    });
  }

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              ButtonLogoMenteeMatch(),
              const SizedBox(width: 20),
            ],
          ),
          Row(
            children: [
              CustomDropdownCategory(
                title: 'SMA',
              ),
              const SizedBox(width: 20),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProfileMenteeScreen()),
                      );
                    },
                    child: _buildCircularImage(
                      _photoUrl,
                      40,
                      40,
                      null,
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCircularImage(
    String imageUrl,
    double height,
    double width,
    Color? color,
  ) {
    return ClipOval(
      child: CachedNetworkImage(
        placeholder: (context, url) => Center(
          child: CircularProgressIndicator(),
        ),
        errorWidget: (context, url, error) => Image.asset(
          'assets/blank_profile.jpg',
          fit: BoxFit.cover,
        ),
        imageUrl: imageUrl,
        height: height,
        width: width,
        fit: BoxFit.cover,
        color: color,
        colorBlendMode: color != null ? BlendMode.modulate : null,
      ),
    );
  }
}

// NavbarKuliah
class NavbarWidgetKuliah extends StatefulWidget {
  const NavbarWidgetKuliah({Key? key}) : super(key: key);

  @override
  State<NavbarWidgetKuliah> createState() => _NavbarWidgetKuliahState();
}

class _NavbarWidgetKuliahState extends State<NavbarWidgetKuliah> {
  String _photoUrl = "";

  Future<void> _loadProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      /// photourl
      _photoUrl = prefs.getString('photoUrl') ?? "";
    });
  }

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              ButtonLogoMenteeMatch(),
              const SizedBox(width: 20),
            ],
          ),
          Row(
            children: [
              CustomDropdownCategory(
                title: 'Kuliah',
              ),
              const SizedBox(width: 20),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProfileMenteeScreen()),
                      );
                    },
                    child: _buildCircularImage(
                      _photoUrl,
                      40,
                      40,
                      null,
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCircularImage(
    String imageUrl,
    double height,
    double width,
    Color? color,
  ) {
    return ClipOval(
      child: CachedNetworkImage(
        placeholder: (context, url) => Center(
          child: CircularProgressIndicator(),
        ),
        errorWidget: (context, url, error) => Image.asset(
          'assets/blank_profile.jpg',
          fit: BoxFit.cover,
        ),
        imageUrl: imageUrl,
        height: height,
        width: width,
        fit: BoxFit.cover,
        color: color,
        colorBlendMode: color != null ? BlendMode.modulate : null,
      ),
    );
  }
}

// NavbarKarier
class NavbarWidgetKarier extends StatefulWidget {
  const NavbarWidgetKarier({Key? key}) : super(key: key);

  @override
  State<NavbarWidgetKarier> createState() => _NavbarWidgetKarierState();
}

class _NavbarWidgetKarierState extends State<NavbarWidgetKarier> {
  String _photoUrl = "";

  Future<void> _loadProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      /// photourl
      _photoUrl = prefs.getString('photoUrl') ?? "";
    });
  }

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              ButtonLogoMenteeMatch(),
              const SizedBox(width: 20),
            ],
          ),
          Row(
            children: [
              CustomDropdownCategory(
                title: 'Karier',
              ),
              const SizedBox(width: 20),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProfileMenteeScreen()),
                      );
                    },
                    child: _buildCircularImage(
                      _photoUrl,
                      40,
                      40,
                      null,
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCircularImage(
    String imageUrl,
    double height,
    double width,
    Color? color,
  ) {
    return ClipOval(
      child: CachedNetworkImage(
        placeholder: (context, url) => Center(
          child: CircularProgressIndicator(),
        ),
        errorWidget: (context, url, error) => Image.asset(
          'assets/blank_profile.jpg',
          fit: BoxFit.cover,
        ),
        imageUrl: imageUrl,
        height: height,
        width: width,
        fit: BoxFit.cover,
        color: color,
        colorBlendMode: color != null ? BlendMode.modulate : null,
      ),
    );
  }
}
