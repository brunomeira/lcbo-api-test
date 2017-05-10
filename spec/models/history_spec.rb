require 'rails_helper'

RSpec.describe History::NoSQL, type: :model do
	let(:user) { User.create email: 'test@test.com', password: '123456' }

	describe 'instance methods' do
		subject { History::NoSQL.new(user.id) }

		context '#key' do
			it { expect(subject.key).to eq("#{user.id}:history") }
		end

		context '#save' do
			it 'saves value on redis' do
				expect($redis.llen(subject.key)).to be(0)
				subject.save({ a: 123213 }.to_json)
				expect($redis.llen(subject.key)).to be(1)
			end

			it 'refuses to save data if data is not json formatted' do
				expect { subject.save('123213') }.to raise_error('Data must be JSON formatted')
				expect($redis.llen(subject.key)).to be(0)
			end
		end
	end

	describe 'class methods' do
		subject { History::NoSQL }

		context '.fetch' do
			context 'no value stored' do
				it 'returns an empty array' do
					expect(subject.fetch(user.id)).to eq([])
				end
			end

			context 'with values stored' do
				before do
					0.upto(15).each do |i|
						History::NoSQL.new(user.id).save({ test: i }.to_json)
					end
				end

				it 'returns a list of History::NoSQL objects with proper attributes assigned' do
					results = subject.fetch(user.id)

					expect(results).to be_an(Array)
					expect(results.size).to be(10)

					results.each_with_index do |result, i|
						expect(result).to be_a(History::NoSQL)
						expect(result.user).to eq(user.id)
						expect(result.data).to eq({ 'test' => (15 - i) })
					end
				end

				it 'next 10 elements when page set to 1',focus: true do
					results = subject.fetch(user.id, 1)

					expect(results.size).to be(7)

					results.each_with_index do |result, i|
						expect(result.data).to eq({ 'test' => (6 - i) })
					end
				end
			end
		end

		context '.key' do
			it { expect(subject.key(user.id)).to eq("#{user.id}:history") }
		end
	end
end
