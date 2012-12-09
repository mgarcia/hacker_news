HackerNews
===========

HackerNews use the Hacker News API (http://api.ihackernews.com/) to pull the HN home page 
news using Ruby.  Calculate the mean, median, and mode score for the news items.  
It also sends an email with these calculated values, along with all 
stories above the median.

## Configure



Open the file bin/app.rb and change the email addresses.

    MAIL_FROM = <your_email@foo.com>
    MAIL_TO   = <your_email@foo.com>

By default it will send emails through a local email server (localhost:25). To change the email server add more
options in send_email method.

    hackernews.send_email(host:'localhost', port:25, from:MAIL_FROM, to:MAIL_TO) # send to localhost:25 by default

## How to use it

    $ bin/app.rb

## Test

The tests where made using RSpec and to run them first install the required gems
    
    $ bundle install
    
Run the tests
    
    $ rspec

## License

HackerNews is released under the {MIT License}[http://www.opensource.org/licenses/MIT].