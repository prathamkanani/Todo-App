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

  /// `Hello`
  String get hello {
    return Intl.message('Hello', name: 'hello', desc: '', args: []);
  }

  /// `All`
  String get all {
    return Intl.message('All', name: 'all', desc: '', args: []);
  }

  /// `Ongoing`
  String get ongoing {
    return Intl.message('Ongoing', name: 'ongoing', desc: '', args: []);
  }

  /// `Pending`
  String get pending {
    return Intl.message('Pending', name: 'pending', desc: '', args: []);
  }

  /// `Completed`
  String get completed {
    return Intl.message('Completed', name: 'completed', desc: '', args: []);
  }

  /// `Low`
  String get low {
    return Intl.message('Low', name: 'low', desc: '', args: []);
  }

  /// `Medium`
  String get medium {
    return Intl.message('Medium', name: 'medium', desc: '', args: []);
  }

  /// `High`
  String get high {
    return Intl.message('High', name: 'high', desc: '', args: []);
  }

  /// `dd MMM yyyy`
  String get ddMmmYyyy {
    return Intl.message('dd MMM yyyy', name: 'ddMmmYyyy', desc: '', args: []);
  }

  /// `Update`
  String get update {
    return Intl.message('Update', name: 'update', desc: '', args: []);
  }

  /// `Create`
  String get create {
    return Intl.message('Create', name: 'create', desc: '', args: []);
  }

  /// `User Profile`
  String get userProfile {
    return Intl.message(
      'User Profile',
      name: 'userProfile',
      desc: '',
      args: [],
    );
  }

  /// `Create Task`
  String get createTask {
    return Intl.message('Create Task', name: 'createTask', desc: '', args: []);
  }

  /// `My Tasks`
  String get myTasks {
    return Intl.message('My Tasks', name: 'myTasks', desc: '', args: []);
  }

  /// `Todo App`
  String get todoApp {
    return Intl.message('Todo App', name: 'todoApp', desc: '', args: []);
  }

  /// `The smarter way to manage work.`
  String get theSmarterWayToManageWork {
    return Intl.message(
      'The smarter way to manage work.',
      name: 'theSmarterWayToManageWork',
      desc: '',
      args: [],
    );
  }

  /// `By continuing you agree to our`
  String get byContinuingYouAgreeToOur {
    return Intl.message(
      'By continuing you agree to our',
      name: 'byContinuingYouAgreeToOur',
      desc: '',
      args: [],
    );
  }

  /// `Privacy Policies`
  String get privacyPolicies {
    return Intl.message(
      'Privacy Policies',
      name: 'privacyPolicies',
      desc: '',
      args: [],
    );
  }

  /// `and`
  String get and {
    return Intl.message('and', name: 'and', desc: '', args: []);
  }

  /// `Terms & Conditions`
  String get termsConditions {
    return Intl.message(
      'Terms & Conditions',
      name: 'termsConditions',
      desc: '',
      args: [],
    );
  }

  /// `New Chat`
  String get newChat {
    return Intl.message('New Chat', name: 'newChat', desc: '', args: []);
  }

  /// `Chats`
  String get chats {
    return Intl.message('Chats', name: 'chats', desc: '', args: []);
  }

  /// `AI`
  String get ai {
    return Intl.message('AI', name: 'ai', desc: '', args: []);
  }

  /// `Clear Chat`
  String get clearChat {
    return Intl.message('Clear Chat', name: 'clearChat', desc: '', args: []);
  }

  /// `Hello User, Try our very own AI`
  String get helloUserTryOurVeryOwnAi {
    return Intl.message(
      'Hello User, Try our very own AI',
      name: 'helloUserTryOurVeryOwnAi',
      desc: '',
      args: [],
    );
  }

  /// `Create a task`
  String get createATask {
    return Intl.message(
      'Create a task',
      name: 'createATask',
      desc: '',
      args: [],
    );
  }

  /// `Give an idea`
  String get giveAnIdea {
    return Intl.message('Give an idea', name: 'giveAnIdea', desc: '', args: []);
  }

  /// `Deep Research`
  String get deepResearch {
    return Intl.message(
      'Deep Research',
      name: 'deepResearch',
      desc: '',
      args: [],
    );
  }

  /// `Loading chat failed!`
  String get loadingChatFailed {
    return Intl.message(
      'Loading chat failed!',
      name: 'loadingChatFailed',
      desc: '',
      args: [],
    );
  }

  /// `Ask anything`
  String get askAnything {
    return Intl.message(
      'Ask anything',
      name: 'askAnything',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message('Delete', name: 'delete', desc: '', args: []);
  }

  /// `Todo title`
  String get todoTitle {
    return Intl.message('Todo title', name: 'todoTitle', desc: '', args: []);
  }

  /// `Enter a todo`
  String get enterATodo {
    return Intl.message('Enter a todo', name: 'enterATodo', desc: '', args: []);
  }

  /// `Description`
  String get description {
    return Intl.message('Description', name: 'description', desc: '', args: []);
  }

  /// `Enter todo description`
  String get enterTodoDescription {
    return Intl.message(
      'Enter todo description',
      name: 'enterTodoDescription',
      desc: '',
      args: [],
    );
  }

  /// `Start Date`
  String get startDate {
    return Intl.message('Start Date', name: 'startDate', desc: '', args: []);
  }

  /// `Due Date`
  String get dueDate {
    return Intl.message('Due Date', name: 'dueDate', desc: '', args: []);
  }

  /// `Priority`
  String get priority {
    return Intl.message('Priority', name: 'priority', desc: '', args: []);
  }

  /// `Theme`
  String get theme {
    return Intl.message('Theme', name: 'theme', desc: '', args: []);
  }

  /// `Invalid Due Date!`
  String get invalidDueDate {
    return Intl.message(
      'Invalid Due Date!',
      name: 'invalidDueDate',
      desc: '',
      args: [],
    );
  }

  /// `MMMM dd`
  String get dateFormat {
    return Intl.message('MMMM dd', name: 'dateFormat', desc: '', args: []);
  }

  /// `Revert`
  String get revert {
    return Intl.message('Revert', name: 'revert', desc: '', args: []);
  }

  /// `Complete`
  String get complete {
    return Intl.message('Complete', name: 'complete', desc: '', args: []);
  }

  /// `Authenticated`
  String get authenticated {
    return Intl.message(
      'Authenticated',
      name: 'authenticated',
      desc: '',
      args: [],
    );
  }

  /// `Sign in with Google`
  String get signInWithGoogle {
    return Intl.message(
      'Sign in with Google',
      name: 'signInWithGoogle',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message('Home', name: 'home', desc: '', args: []);
  }

  /// `Account`
  String get account {
    return Intl.message('Account', name: 'account', desc: '', args: []);
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[Locale.fromSubtags(languageCode: 'en')];
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
