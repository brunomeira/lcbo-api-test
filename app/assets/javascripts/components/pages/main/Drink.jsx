class Drink extends React.Component {

	render() {
		const drink = this.props.drink;
		return (
			<section style={{marginBottom: 10}}>
				{drink.name}
				<button className='pure-btn' onClick={ () => this.props.fetchDrink(drink.id)}> More Details </button>
			</section>
		);
	}
}
