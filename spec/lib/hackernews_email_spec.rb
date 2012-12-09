require "spec_helper"
require "hacker_news"

describe HackerNews::Email do

  let(:hackernews_email){ HackerNews::Email.new(host:'localhost',port:25)}

  context "sending a message" do
    it "calls Net::SMTP start" do
        Net::SMTP.should_receive(:start)
        hackernews_email.send(from:'from',to:'to',subject:'subject',msg:'msg')
    end
  end
end
