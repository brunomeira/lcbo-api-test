require 'rails_helper'

RSpec.describe ViewProduct::NoSQL, type: :model do
	let(:user) { User.create email: 'test@test.com', password: '123456' }

	describe 'instance methods' do
		subject { ViewProduct::NoSQL.new(user.id) }

		context '#key' do
			it { expect(subject.key).to eq("#{user.id}:history:viewed_products") }
		end

		context '#save' do
			it 'saves value on redis' do
				expect($redis.sismember(subject.key, '1')).to be_falsy
				expect(subject.save('1')).to be_truthy
				expect($redis.sismember(subject.key, '1')).to be_truthy
			end

			it 'does not allow duplicated values' do
				expect(subject.save('1')).to be_truthy
				expect(subject.save('1')).to be_falsy
			end
		end
	end

	describe 'class methods' do
		subject { ViewProduct::NoSQL }

		context '.viewed?' do
			it 'returns true if element was already viewed by user' do
				ViewProduct::NoSQL.new(user.id).save('1')
				expect(subject.viewed?(user.id, '1')).to be_truthy
			end

			it 'returns false if element was not viewed by user' do
				expect(subject.viewed?(user.id, '1')).to be_falsy
			end
		end

		context '.key' do
			it { expect(subject.key(user.id)).to eq("#{user.id}:history:viewed_products") }
		end
	end
end
