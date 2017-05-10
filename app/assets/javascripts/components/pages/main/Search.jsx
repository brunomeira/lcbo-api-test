class Search extends React.Component {
	constructor (props) {
		super(props);

		this.search = this.search.bind(this);
		this.feelingLucky = this.feelingLucky.bind(this);
		this.state = { text: '' };
	}

	search(evt) {
		evt.preventDefault();
		this.props.fetchDrinks({ text: this.state.text });
	}

	feelingLucky(evt) {
		evt.preventDefault();
		this.props.fetchDrinks({ text: this.state.text, special_action: 'feeling_lucky' });
	}

	render() {
		return(
			<section>
				<form style={{ textAlign: 'center' } } className='pure-form'>
					<input type='text'
								 placeholder='Search by name or type (Ex: Beer, Canadian, etc...)'
								 className='pure-input-1-2'
								 value={ this.state.text }
								 onChange={ evt => this.setState({text: evt.target.value}) }/>

					<button className='pure-button' onClick={ this.search } style={{margin: '0px 10px'}}>Search</button>
					<button className='pure-button' onClick={ this.feelingLucky }>I am feeling lucky</button>
				</form>
			</section>
		);
	}
}
