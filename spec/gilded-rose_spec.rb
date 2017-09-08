require 'gilded-rose'

describe GildedRose do

  describe '#update_quality' do

    vest = Item.new("+5 Dexterity Vest", 10, 0) #0
    brie = Item.new("Aged Brie", 2, 5) #1
    elixir = Item.new("Elixir of the Mongoose", 0, 7) #2
    sulfuras = Item.new("Sulfuras, Hand of Ragnaros", 0, 50) #3
    pass1 = Item.new("Backstage passes to a TAFKAL80ETC concert", 15, 20) #4
    pass2 = Item.new("Backstage passes to a TAFKAL80ETC concert", 9, 40) #5
    pass3 = Item.new("Backstage passes to a TAFKAL80ETC concert", 5, 46) #6
    pass4 = Item.new("Backstage passes to a TAFKAL80ETC concert", -1, 46) #7
    cake1 = Item.new("Conjured Mana Cake", 3, 6) #8
    cake2 = Item.new("Victoria Sponge", 3, 50) #9
    stock = GildedRose.new([vest, brie, elixir, sulfuras, pass1, pass2, pass3, pass4, cake1, cake2])
    stock.update_quality

    it 'sell_in decreases by 1' do
      expect(stock.items[0].sell_in).to eq 9
    end

    it "does not change the name" do
      expect(stock.items[0].name).to eq "+5 Dexterity Vest"
    end

    it 'quality is never negative' do
      expect(stock.items[0].quality).to be >=0
    end

    it 'quality of an item is <= 50' do
      expect(stock.items[9].quality).to be <=50
    end

    it 'if legendary, sell_in and quality stay the same' do
      expect(stock.items[3].quality).to eq 50
      expect(stock.items[3].sell_in).to eq 0
    end

    it 'if maturing, quality increases' do
      expect(stock.items[1].quality).to eq 6
    end

    it 'for a pass, quality increases' do
      expect(stock.items[4].quality).to eq 21
    end

    it 'for a pass whose sell_in <=10, quality increases by 2' do
      expect(stock.items[5].quality).to eq 42
    end

    it 'for a pass whose sell_in <=5, quality increases by 3' do
      expect(stock.items[6].quality).to eq 49
    end

    it 'for a pass whose sell_in <=0, quality to 0' do
      expect(stock.items[7].quality).to eq 0
    end

    it 'if sell_in <= 0, quality degrades twice as fast' do
      expect(stock.items[2].quality).to eq 5
    end

    # it 'if conjured, quality decreases by 2' do
    #   expect(stock.items[8].quality).to eq 4
    # end

  end
end

describe Item do
  subject(:cake) {described_class.new("cake", 3, 6)}
  it 'has a name, type, sell_in and quality on initialization' do
    expect(cake.name).to eq "cake"
    expect(cake.sell_in).to eq 3
    expect(cake.quality).to eq 6
  end

  describe '#to_s' do
    it 'prints the item details' do
      expect(cake.to_s).to eq "cake, 3, 6"
    end
  end
end
