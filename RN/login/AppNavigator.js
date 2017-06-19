'use strict';

import React, {Component} from 'react';
import { View, BackAndroid, StatusBar,} from 'react-native';
import {
  NavigationActions,
  addNavigationHelpers,
  StackNavigator,
} from 'react-navigation';
import { connect} from 'react-redux';

import LandingScreen from 'src/screens/landingScreen';
import Login from 'src/screens/login'
import SignUp from 'src/screens/signUp'
import ForgotPassword from 'src/screens/forgotPassword'
import UserProfile from 'src/screens/userProfile'
import Drawer from 'src/screens/drawer'



const routesConfig = {
  //Splash:{screen:SplashScreen},
  Landing:{screen:LandingScreen},
  Login: { screen: Login },
  SignUp: { screen: SignUp },
  ForgotPassword: { screen: ForgotPassword },
  UserProfile:{screen:UserProfile},
};


export const AppNavigator = StackNavigator(routesConfig, {initialRouteName:'UserProfile'}); //navigator that will be used after login