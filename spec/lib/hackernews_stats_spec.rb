require "spec_helper"
require "hacker_news"

describe HackerNews::Stats do
  item1 = {"id" => 1, "points"=> 3}
  item2 = {"id" => 2, "points"=> 4}
  item3 = {"id" => 3, "points"=> 1}
  item4 = {"id" => 4, "points"=> 2}
  items = [item1, item2, item3, item4]

  let(:stats) { HackerNews::Stats.new(items)}

  it "has 4 items" do 
    stats.should have(4).items
  end

  it "includes items" do
    stats.items.should include(item1)
    stats.items.should include(item2)
    stats.items.should include(item3)
    stats.items.should include(item4)
  end

  it "do stats" do
     stats.mean.should    == 2.50 
     stats.median.should  == 2.50
     stats.mode.should    be_empty
  end

  context "stats for 5 elements" do
    items5 = items.dup
    items5 << {"id" => 5, "points"=> 6}
    let(:stats) { HackerNews::Stats.new(items5)}

    it "has 5 items" do 
      stats.should have(5).items
    end

    it "do stats" do 
     stats.mean.should    == 3.2
     stats.median.should  == 3 
     stats.mode.should    be_empty
    end
  end

  context "stats for 5 elements with 1 duplicated elements" do
    items5 = items.dup
    items5 << {"id" => 5, "points"=> 1}
    let(:stats) { HackerNews::Stats.new(items5)}

    it "has 5 items" do 
      stats.should have(5).items
    end

    it "do stats" do 
     stats.mean.should    == 2.2
     stats.median.should  == 2 
     stats.mode.should    == [1]
    end
  end

  context "stats for 1 elements" do
    items1 = [{"id" => 5, "points"=> 7}]
    let(:stats) { HackerNews::Stats.new(items1)}

    it "has 1 items" do 
      stats.should have(1).items
    end

    it "do stats" do 
     stats.mean.should    == 7
     stats.median.should  == 7 
     stats.mode.should    be_empty
    end
  end

  context "stats for all items with equal values" do
    items_equal = items.dup.map do |item|
        item_dup = item.dup
        item_dup['points'] = 33
        item_dup
    end 
    let(:stats) { HackerNews::Stats.new(items_equal)}

    it "has 4 items" do 
      stats.should have(4).items
    end

    it "do stats" do 
     stats.mean.should    == 33
     stats.median.should  == 33 
     stats.mode.should    be_empty
    end
  end

  context "stats for 0 elements" do
    items0 = []
    let(:stats) { HackerNews::Stats.new(items0)}

    it "items is nil" do 
      stats.items.should == []
    end

    it "do stats" do 
     stats.mean.should    be_nil
     stats.median.should  be_nil
     stats.mode.should    be_nil
    end
  end

  it "has sorted items" do
    hn = HackerNews::Stats.new(items)
    i=1
    hn.items.each do |item|
      item['points'].should == i
      i += 1
    end

    hn.items.should_not == items

  end
end
