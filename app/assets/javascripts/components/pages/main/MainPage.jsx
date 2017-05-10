class MainPage extends React.Component {
	render() {
		return (
			<section>
				<Search fetchDrinks={ this.props.fetchDrinks } />
				<BottomSection drinks={ this.props.drinks }
											 fetchDrink={ this.props.fetchDrink }
											 selectedDrink={ this.props.selectedDrink }
											 histories={ this.props.histories }/>
			</section>
		) ;
	}
}
