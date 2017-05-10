class DrinkDetails extends React.Component {

	render() {
		const drink = this.props.drink;
		return (
			<section style={{marginBottom: 10}} className='pure-g'>
				<div className='pure-u-1-3'>
					<img src={drink.image_thumb_url} />
				</div>
				<div className='pure-u-2-3'>
					<h1>{drink.name}</h1>
				</div>
			</section>
		);
	}
}
