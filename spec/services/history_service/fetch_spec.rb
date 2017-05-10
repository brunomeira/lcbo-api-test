require 'rails_helper'

RSpec.describe HistoryService::Fetch do
	let(:user) { User.create!(email: 'test@test.com', password: '123456') }

	context '#run' do
		subject { HistoryService::Fetch.new(user.id).run }

		it 'returns no history if user is not signed in' do
			history_service = HistoryService::Fetch.new(nil)
			expect(history_service.run).to eq([])
		end

		it 'returns values stored in Redis first and, if values present, not call SQL' do
			0.upto(2).each do |i|
				HistoryService::Create.new(user.id, 'test', i).run
			end

			expect(History::SQL).to receive(:paginate).never

			response = subject
			expect(response.size).to be(3)

			response.each do |data|
				expect(data).to be_a(History::NoSQL)
			end
		end

		it 'returns values stored on SQL database, if nothing was found in Redis' do
			0.upto(2).each do |i|
				History::SQL.create(user: user, data: { action: i })
			end

			response = subject
			expect(response.size).to be(3)

			response.each do |data|
				expect(data).to be_a(History::SQL)
			end
		end
	end
end
