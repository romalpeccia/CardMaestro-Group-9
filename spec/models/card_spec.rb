describe Card, '#name' do
  it 'returns the concatenated first and last name' do
    # setup
    card = FactoryBot.build(:card, name: 'Josh')

    # excercise and verify
    expect(card.name).to eq 'Josh'
  end
end
