class MainPageContainer extends React.Component {
	constructor () {
		super();

		this.fetchHistories = this.fetchHistories.bind(this);
		this.fetchDrinks = this.fetchDrinks.bind(this);
		this.state = { selectedDrink: null, drinks: [], histories: [] };
	}

	componentWillMount () {
		this.fetchHistories();
	}

	fetchHistories () {
		let headers = new Headers();
		headers.append('X-API-EMAIL', this.props.email);
		headers.append('X-API-TOKEN', this.props.token);

		fetch(`/api/v1/histories`, { headers: headers }).then((response) => {
			return response.json().then((json) => {
				this.setState({ histories: json.histories });
			});
		});
	}

	fetchDrinks(params) {
		let body = new URLSearchParams();

		for(param in params) {
			body.append(param, params[param]);
		}

		let headers = new Headers();
		headers.append('X-API-EMAIL', this.props.email);
		headers.append('X-API-TOKEN', this.props.token);

		fetch(`/api/v1/lcbo_products?${body.toString()}`, { headers: headers }).then((response)=>{
			return response.json().then((json) => {
				if(params['special_action']) {
					this.setState({ selectedDrink: json.lcbo_products[0] });
				} else {
					this.setState({ drinks: json.lcbo_products, selectedDrink: null });
				}

				this.fetchHistories();
			})
		});
	}

	fetchDrink(id) {
		let headers = new Headers();
		headers.append('X-API-EMAIL', this.props.email);
		headers.append('X-API-TOKEN', this.props.token);

		fetch(`/api/v1/lcbo_products/${id}`, { headers: headers }).then((response) => {
			return response.json().then((json) => {
				this.setState({ selectedDrink: json });
				this.fetchHistories();
			});
		});
	}

	render() {
		return (<MainPage fetchDrinks={ this.fetchDrinks }
											fetchDrink={ this.fetchDrink.bind(this) }
											selectedDrink={ this.state.selectedDrink }
											drinks={ this.state.drinks }
											histories={ this.state.histories }/>);
	}
}
