class BottomSection extends React.Component {
	renderSelectedDrink() {
		if(!this.props.selectedDrink) { return }
		return <DrinkDetails drink={this.props.selectedDrink}></DrinkDetails>;
	}

	renderDrinks(drinks) {
		let content = '';

		if (drinks.length == 0) {
			content = <h1>No drinks found</h1>;
		} else {
			content = this.props.drinks.map((drink) => <Drink key={drink.id} drink={drink} fetchDrink={this.props.fetchDrink}></Drink>);
		}

		return content;
	}

	renderHistories() {
		let content = '';

		if (this.props.histories.length > 0) {
			content = this.props.histories.map((history) => <History history={history}></History>);
		}

		return content;
	}

	render() {
		return (
			<div>
				{ this.renderSelectedDrink(this.props.selectedDrink) }

				<div className='pure-g'>
					<section className='pure-u-1-2'>
						<header>
							<h1>Results</h1>
						</header>

						<div>
							{ this.renderDrinks(this.props.drinks) }
						</div>
					</section>

					<section className='pure-u-1-2'>
						<header>
							<h1>History</h1>
						</header>

						<div>
							{ this.renderHistories(this.props.histories) }
						</div>
					</section>
				</div>
			</div>
		)
	}
}
