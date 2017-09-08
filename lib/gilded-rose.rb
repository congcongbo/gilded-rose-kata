class GildedRose
  attr_accessor :items
  def initialize(items)
    @items = items
  end

  def update_quality
    @items.each { |item| item.update unless item.legendary? }
  end
end

class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s()
    "#{@name}, #{@sell_in}, #{@quality}"
  end

  def update
    update_sell_in
    if brie?
      update_brie
    elsif pass?
      update_pass
    elsif conjured?
      update_conjured
    else
      update_item_quality
    end
    zero_quality
  end

  def update_sell_in
    @sell_in -= 1 unless legendary?
  end

  def update_item_quality
    @sell_in > 0 ? @quality -= 1 : @quality -= 2
  end

  def update_brie
    @sell_in > 0 ? @quality += 1 : @quality -= 1
  end

  def update_conjured
    @sell_in > 0 ? @quality -= 2 : @quality -= 4
  end

  def update_pass
    if @sell_in <=0
      @quality = 0
    elsif @sell_in <= 5
      @quality += 3
    elsif @sell_in <= 10
      @quality += 2
    else @sell_in < 10
      @quality += 1
    end
  end

  def zero_quality
    @quality = 0 if @quality < 0
  end

  def legendary?
    @name == "Sulfuras, Hand of Ragnaros"
  end

  def brie?
    @name == "Aged Brie"
  end

  def pass?
    @name == "Backstage passes to a TAFKAL80ETC concert"
  end

  def conjured?
    @name == "Conjured Mana Cake"
  end

end
