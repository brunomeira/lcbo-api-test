class History extends React.Component {
	actionText(history) {
		let text = '';

		switch(history.action){
			case 'search_products':
			text = `Searched For: ${history.value}`;
			break;
			case 'view_product':
			text = `View Product: ${history.value}`;
			break;
		}

		return text;
	}

	render() {
		const history = this.props.history;

		return (
			<section style= {{marginBottom: 20}}>
				Date: { history.datetime }
				<div>
					{this.actionText(history) }
				</div>
			</section>
		);
	}
}
