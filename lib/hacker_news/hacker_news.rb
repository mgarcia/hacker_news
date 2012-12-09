module HackerNews

  class HackerNews

    def load_data
      @items = Api.new.front_page
      @stats = Stats.new(@items)
    end

    def send_email(options = {host:'locahost', port:25, subject:'HackerNews'})
      msg = build_email_msg
      mail  = Email.new(host:options[:host], port:options[:port])
      mail.send(from:options[:from], to:options[:to], subject:options[:subject], msg:msg)
    end


    private

    def build_email_msg
      msg =  "Mean:   #{@stats.mean}\n"
      msg += "Median: #{@stats.median}\n"
      msg += "Mode:   #{@stats.mode.join(',')}\n\n"
      msg += @stats.items_above_median.reverse.inject("") do |items, item|
          items += item.inject(""){|m,(k,v)| m += "#{k.capitalize}: #{v}\n"} + "\n"
      end
    end


  end

end
