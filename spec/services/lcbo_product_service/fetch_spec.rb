require 'rails_helper'

RSpec.describe LCBOProductService::Fetch do
	let(:user) { User.create(email: 'test@test.com', password: '123456') }
	let(:product_id) { rand }

	describe 'instance methods' do
		subject { LCBOProductService::Fetch.new(user.id, product_id) }

		context '#run' do
			it 'fetches content for product with specified id' do
				expect_any_instance_of(LCBOProduct).to receive(:fetch).once.and_return('test')
				expect(subject.run).to eq('test')
			end

			it 'logs action in history and viewed product sections' do
				expect_any_instance_of(LCBOProduct).to receive(:fetch).once

				expect(History::SQL.count).to be(0)
				expect(History::NoSQL.fetch(user.id).size).to be(0)
				expect(ViewProduct::NoSQL.viewed?(user.id, product_id)).to be_falsy

				subject.run

				expect(History::SQL.count).to be(1)
				expect(History::NoSQL.fetch(user.id).size).to be(1)
				expect(ViewProduct::NoSQL.viewed?(user.id, product_id)).to be_truthy
			end
		end
	end

	describe 'class methods' do
		subject { LCBOProductService::Fetch }

		context '.run' do
			let(:params) do
				{ q: 'test' }
			end

			it 'fetches content for products with specified params' do
				expect(LCBOProduct).to receive(:fetch).with(params).once.and_return('test')
				expect(subject.run(user.id, params)).to eq('test')
			end

			it 'logs action in history' do
				expect(LCBOProduct).to receive(:fetch).once

				expect(History::SQL.count).to be(0)
				expect(History::NoSQL.fetch(user.id).size).to be(0)

				subject.run(user.id, params)

				expect(History::SQL.count).to be(1)
				expect(History::NoSQL.fetch(user.id).size).to be(1)
			end
		end
	end
end
