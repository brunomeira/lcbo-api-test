require 'rails_helper'

RSpec.describe HistoryService::Create do
	let(:user) { User.create!(email: 'test@test.com', password: '123456') }
	let(:action) { 'test' }
	let(:value) { 'value' }
	let(:history_service) { HistoryService::Create.new(user.id, action, value) }

	context '#run' do
		subject { history_service.run }

		describe 'Successful action' do
			it 'creates a record of History in the SQL database' do
				expect { subject }.to change{ History::SQL.count }.by(1)

				history = History::SQL.last
				expected_data = {
					'action' => action,
					'value' => value,
					'datetime' => history_service.send(:datetime).to_s
				}

				expect(history.data).to eq(expected_data)
			end

			it 'creates a record of History in Redis' do
				expect(History::NoSQL.fetch(user.id).size).to be(0)
				subject
				expect(History::NoSQL.fetch(user.id).size).to be(1)
			end
		end
	end
end
