class Root extends Component {
    constructor(props) {
      super(props);
      this.state = {
        authenticated:false,
        isLoading:true,
        store: configureStore(() => this.setState({isLoading: false})),
      };
  }

  componentDidMount() {
    //you can do check with authentication with fb, gmail and other right here
   /* firebase.auth().onAuthStateChanged((user) => {
      if (user) {
        api.resetRouteStack(dispatch, "UserProfile");
        console.log("authenticated", user);
      } else {
        api.resetRouteStack(dispatch, "Landing");
        console.log("authenticated", false);
      }
    });*/

  }

  render() {
    if (this.state.isLoading) {  //checking if the app fully loaded or not, splash screen can be rendered here
        return null;
      }
      return (

        <Provider store={this.state.store}>
          <App/>
        </Provider>

      );
  }
}
module.exports = Root;