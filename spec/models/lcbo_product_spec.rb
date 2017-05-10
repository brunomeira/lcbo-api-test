require 'rails_helper'

RSpec.describe LCBOProduct, type: :model do
	context '#fetch' do
		let(:id) { 1 }
		subject { LCBOProduct.new(id) }

		it 'returns product associated with specified id' do

		end
	end

	context '.fetch' do
		let(:params) { { q: 'test' } }
		subject { LCBOProduct.fetch(params) }

		it 'returns a list of products with determined params' do

		end
	end
end
