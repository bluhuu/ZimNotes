import AppWithNavigationState,{AppBeforeLogin} from './AppNavigator';

class App extends Component{
    constructor(props){
        super(props);
    }

    render(){
        let {authenticated} = this.props;
        if(authenticated){
            return <AppWithNavigationState/>;
        }
        return <AppBeforeLogin/>


    }
}

export default connect(state =>({authenticated: state.user.authenticated}))(App);