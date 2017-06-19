import React, { Component, PropTypes } from 'react';
import {
  NavigationExperimental,
  BackAndroid,
  TouchableHighlight,
  PixelRatio,
  StyleSheet,
  Text,
  View,
} from 'react-native';
import { connect } from 'react-redux';

class AppWithNavigationState extends Component{
  constructor(props) {
    super(props);
    this.handleBackButton = this.handleBackButton.bind(this);
  }

  componentDidMount() {
    BackAndroid.addEventListener('hardwareBackPress', this.handleBackButton);
  }

  componentWillUnmount() {
    BackAndroid.removeEventListener('hardwareBackPress', this.handleBackButton);
  }

  //added to handle back button functionality on android
  handleBackButton() {
    const {nav, dispatch} = this.props;

    if (nav && nav.routes && nav.routes.length > 1) {
      dispatch(NavigationActions.back());
      return true;
    }
    return false;
  }

  render() {
    let {dispatch, nav} = this.props;

    return (
          <View style={styles.container}>
            {(api.isAndroid()) &&
              <StatusBar
                  backgroundColor="#C2185B"
                  barStyle="light-content"
              />
            }
            <AppNavigator navigation={addNavigationHelpers({ dispatch, state: nav })}/>
          </View>
    );
  }
};
export default connect(state =>({nav: state.nav}))(AppWithNavigationState);
//module.exports = AppWithNavigationState;