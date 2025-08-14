// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Welcome back, you have been missed!`
  String get welcome {
    return Intl.message(
      'Welcome back, you have been missed!',
      name: 'welcome',
      desc: '',
      args: [],
    );
  }

  /// `Username`
  String get username {
    return Intl.message('Username', name: 'username', desc: '', args: []);
  }

  /// `Enter your username`
  String get enter_your_username {
    return Intl.message(
      'Enter your username',
      name: 'enter_your_username',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message('Password', name: 'password', desc: '', args: []);
  }

  /// `Enter your password`
  String get enter_your_password {
    return Intl.message(
      'Enter your password',
      name: 'enter_your_password',
      desc: '',
      args: [],
    );
  }

  /// `Sign In`
  String get sign_in {
    return Intl.message('Sign In', name: 'sign_in', desc: '', args: []);
  }

  /// `Home`
  String get home {
    return Intl.message('Home', name: 'home', desc: '', args: []);
  }

  /// `Categories`
  String get category {
    return Intl.message('Categories', name: 'category', desc: '', args: []);
  }

  /// `Open barcode scanner`
  String get open_barcode_scanner {
    return Intl.message(
      'Open barcode scanner',
      name: 'open_barcode_scanner',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get search {
    return Intl.message('Search', name: 'search', desc: '', args: []);
  }

  /// `Notifications`
  String get notifications {
    return Intl.message(
      'Notifications',
      name: 'notifications',
      desc: '',
      args: [],
    );
  }

  /// `Invoice`
  String get invoice {
    return Intl.message('Invoice', name: 'invoice', desc: '', args: []);
  }

  /// `Logout`
  String get logout {
    return Intl.message('Logout', name: 'logout', desc: '', args: []);
  }

  /// `Details`
  String get details {
    return Intl.message('Details', name: 'details', desc: '', args: []);
  }

  /// `Search for a product...`
  String get search1 {
    return Intl.message(
      'Search for a product...',
      name: 'search1',
      desc: '',
      args: [],
    );
  }

  /// `No results found`
  String get no_result {
    return Intl.message(
      'No results found',
      name: 'no_result',
      desc: '',
      args: [],
    );
  }

  /// `Invoice Date`
  String get invoiceDate {
    return Intl.message(
      'Invoice Date',
      name: 'invoiceDate',
      desc: '',
      args: [],
    );
  }

  /// `Medicine`
  String get medicine {
    return Intl.message('Medicine', name: 'medicine', desc: '', args: []);
  }

  /// `Price`
  String get price {
    return Intl.message('Price', name: 'price', desc: '', args: []);
  }

  /// `Qty`
  String get quantity {
    return Intl.message('Qty', name: 'quantity', desc: '', args: []);
  }

  /// `Total`
  String get total {
    return Intl.message('Total', name: 'total', desc: '', args: []);
  }

  /// `Print Invoice`
  String get printInvoice {
    return Intl.message(
      'Print Invoice',
      name: 'printInvoice',
      desc: '',
      args: [],
    );
  }

  /// `Time`
  String get time {
    return Intl.message('Time', name: 'time', desc: '', args: []);
  }

  /// `Expiration date`
  String get expiration_date {
    return Intl.message(
      'Expiration date',
      name: 'expiration_date',
      desc: '',
      args: [],
    );
  }

  /// `Expired medications`
  String get expiration_date_med {
    return Intl.message(
      'Expired medications',
      name: 'expiration_date_med',
      desc: '',
      args: [],
    );
  }

  /// `Product name`
  String get product_name {
    return Intl.message(
      'Product name',
      name: 'product_name',
      desc: '',
      args: [],
    );
  }

  /// `Usage`
  String get usage {
    return Intl.message('Usage', name: 'usage', desc: '', args: []);
  }

  /// `Add to invoice`
  String get add_to_invoice {
    return Intl.message(
      'Add to invoice',
      name: 'add_to_invoice',
      desc: '',
      args: [],
    );
  }

  /// `Overview`
  String get overview {
    return Intl.message('Overview', name: 'overview', desc: '', args: []);
  }

  /// `Manufacturing date`
  String get manufacturing_date {
    return Intl.message(
      'Manufacturing date',
      name: 'manufacturing_date',
      desc: '',
      args: [],
    );
  }

  /// `Success`
  String get success {
    return Intl.message('Success', name: 'success', desc: '', args: []);
  }

  /// `added to invoice`
  String get added_to_invoice {
    return Intl.message(
      'added to invoice',
      name: 'added_to_invoice',
      desc: '',
      args: [],
    );
  }

  /// `Bacode`
  String get bacode {
    return Intl.message('Bacode', name: 'bacode', desc: '', args: []);
  }

  /// `Product not found`
  String get product_not_found {
    return Intl.message(
      'Product not found',
      name: 'product_not_found',
      desc: '',
      args: [],
    );
  }

  /// `Setting`
  String get setting {
    return Intl.message('Setting', name: 'setting', desc: '', args: []);
  }

  /// `Change language`
  String get change_lang {
    return Intl.message(
      'Change language',
      name: 'change_lang',
      desc: '',
      args: [],
    );
  }

  /// `Arabic`
  String get arabic {
    return Intl.message('Arabic', name: 'arabic', desc: '', args: []);
  }

  /// `English`
  String get english {
    return Intl.message('English', name: 'english', desc: '', args: []);
  }

  /// `Change mode`
  String get change_mode {
    return Intl.message('Change mode', name: 'change_mode', desc: '', args: []);
  }

  /// `Light mode`
  String get light {
    return Intl.message('Light mode', name: 'light', desc: '', args: []);
  }

  /// `Night mode`
  String get night {
    return Intl.message('Night mode', name: 'night', desc: '', args: []);
  }

  /// `Other`
  String get other {
    return Intl.message('Other', name: 'other', desc: '', args: []);
  }

  /// `Evaluation`
  String get evaluation {
    return Intl.message('Evaluation', name: 'evaluation', desc: '', args: []);
  }

  /// `Share our app`
  String get share {
    return Intl.message('Share our app', name: 'share', desc: '', args: []);
  }

  /// `Support us`
  String get support {
    return Intl.message('Support us', name: 'support', desc: '', args: []);
  }

  /// `Barcode Scanner`
  String get barcode_scanner {
    return Intl.message(
      'Barcode Scanner',
      name: 'barcode_scanner',
      desc: '',
      args: [],
    );
  }

  /// `Result`
  String get result {
    return Intl.message('Result', name: 'result', desc: '', args: []);
  }

  /// `Not yet scanned`
  String get not_yet_scanned {
    return Intl.message(
      'Not yet scanned',
      name: 'not_yet_scanned',
      desc: '',
      args: [],
    );
  }

  /// `Unknown`
  String get unknown {
    return Intl.message('Unknown', name: 'unknown', desc: '', args: []);
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
