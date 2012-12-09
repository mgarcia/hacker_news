require "spec_helper"
require "hacker_news"
require 'json'

describe HackerNews::Api do

  context "call front page" do
    let(:api) {HackerNews::Api.new}

    items = [
                   {:id => 1, :title => "Test1 Title", :points => "23"},
                   {:id => 2, :title => "Test2 Title", :points => "13"}
      ]

    http_body = '{"nextId":null,"items":' + items.to_json + ',"version":"1.0"}'

    it "calls get_page" do
        api.should_receive(:get_page)
        api.front_page
    end

    it "as http status code 200" do
        stub_request(:get, "http://api.ihackernews.com/page").
                   with(:headers => {'Accept'=>'*/*', 'User-Agent'=>'Ruby'}).
                            to_return(:status => 200, :body => http_body, :headers => {})
        api.front_page
        api.http_code.should == "200"
    end

    it "as http status code 500 on server error" do
        stub_request(:get, "http://api.ihackernews.com/page").to_return(:status => 400)
        api.front_page
        api.http_code.should == "400"
    end

    it "returns properly items news array" do
      api.stub(:get_page).with("/page").and_return(items.dup)
      api.front_page.should == items
    end
  end
end
