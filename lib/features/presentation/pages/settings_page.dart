import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_app/config/routes/app_router.dart';
import 'package:flutter_news_app/config/routes/screen_routes.dart';
import 'package:flutter_news_app/features/data/preferences/app_prefs.dart';
import 'package:flutter_news_app/features/presentation/bloc/remote/remote_article_bloc.dart';
import 'package:flutter_news_app/features/presentation/bloc/remote/remote_article_event.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String dropdownValue = 'United States';
  static final Map<String, String> countryCodes = {
    'United Arab Emirates': 'ae',
    'Argentina': 'ar',
    'Austria': 'at',
    'Australia': 'au',
    'Belgium': 'be',
    'Bulgaria': 'bg',
    'Brazil': 'br',
    'Canada': 'ca',
    'Switzerland': 'ch',
    'China': 'cn',
    'Columbia': 'co',
    'Cuba': 'cu',
    'Czech Republic': 'cz',
    'Germany': 'de',
    'Egypt': 'eg',
    'France': 'fr',
    'United Kingdom': 'gb',
    'Greece': 'gr',
    'Hong Kong': 'hk',
    'Hungary': 'hu',
    'Indonesia': 'id',
    'Ireland': 'ie',
    'Israel': 'is',
    'India': 'in',
    'Italy': 'it',
    'Japan': 'jp',
    'South Korea': 'kr',
    'Lithuania': 'lt',
    'Latvia': 'lv',
    'Morocco': 'ma',
    'Mexico': 'mx',
    'Malaysia': 'my',
    'Nigeria': 'ng',
    'Netherlands': 'nl',
    'Norway': 'no',
    'New Zealand': 'nz',
    'Philippines': 'ph',
    'Poland': 'pl',
    'Portugal': 'pt',
    'Romania': 'ro',
    'Serbia': 'rs',
    'Russia': 'ru',
    'Saudi Arabia': 'sa',
    'Sweden': 'se',
    'Singapore': 'sg',
    'Slovenia': 'si',
    'Slovakia': 'sk',
    'Thailand': 'th',
    'Turkey': 'tr',
    'Taiwan': 'tw',
    'Ukraine': 'ua',
    'United States': 'us',
    'Venezuela': 've',
    'South Africa': 'za',
  };

  @override
  void initState() {
    super.initState();
    _loadCountry();
  }

  void _loadCountry() async {
    String? savedCountry = await AppPreference.getCountry();

    if (savedCountry != null) {
      var key = countryCodes.keys.firstWhere(
        (key) => countryCodes[key] == savedCountry,
        orElse: () => 'United States',
      );
      setState(() {
        dropdownValue = key;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        leading: IconButton(
          onPressed: () {
            BlocProvider.of<RemoteArticleBloc>(context).add(
              GetArticlesByCategory('general'),
            );
            AppRouter().pushAndRemoveUntil(context, ScreenRoutes.home);
          },
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [_buildCountryDropdown(context)],
        ),
      ),
    );
  }

  Widget _buildCountryDropdown(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          flex: 2,
          child: Text(
            'News Preference',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          flex: 3,
          child: DropdownButton<String>(
            value: dropdownValue,
            icon: const Icon(Icons.keyboard_arrow_down_rounded),
            onChanged: (String? newValue) async {
              if (newValue != null) {
                setState(() {
                  dropdownValue = newValue;
                });
                AppPreference.setCountry(countryCodes[newValue]!);
              }
            },
            items: countryCodes.keys.map<DropdownMenuItem<String>>(
              (String key) {
                return DropdownMenuItem<String>(
                  value: key,
                  child: Text(key),
                );
              },
            ).toList(),
          ),
        ),
      ],
    );
  }
}
