# What's TwitCasting-rb

TwitCasting is a live streaming service. TwitCasting-rb is TwitCasting API wrapper in Ruby implements.

## Installation

```
$ git clone https://github.com/suzukaze/Twicasting-rb
$ cd Twicasting-rb
$ rake build
$ gem install pkg/twicasting-x.x.x.gem
$ rbenv rehash # if you use rbenv.
```


## Usage

This is a sample source twitcasting.rb:

```ruby
require 'twitcasting'

# Get messages.
twitcast = TwitCasting::Client.new
comments = twitcast.get_comments({:user => 'twitcastest'})

# Display messages.
puts "-" * 40
puts "date                 user   message"
puts "-" * 40
comments.each do |comment|
  time = Time.at(comment.created).strftime("%Y/%m/%d %H:%M:%S")
  puts "#{time}, #{comment.userid}, #{comment.message}"
end
```

Execute the following command at console.

```
$ ruby twitcasting.rb
----------------------------------------
date                 user   message
----------------------------------------
2011/02/13 05:34:22, yoski, hello
2011/02/13 05:31:08, yoski, 32r32r3
2011/02/13 05:31:03, yoski, ewfeef
2011/02/13 05:31:01, yoski, gadsfadsf
2011/02/13 05:30:59, yoski, asfadf
2011/02/13 05:30:56, yoski, gasfsd
2011/02/13 05:30:54, yoski, fadsfdas
2011/02/13 05:30:52, yoski, adfd
2011/02/13 05:30:31, yoski, gagasgfd
2011/02/13 05:30:29, yoski, adfdaf
```

## Contributing

1. Fork it ( http://github.com/suzukaze/twicasting-rb/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## License

Author : Jun Hiroe

Copyrigh : Copyright (c) 2014 Jun Hiroe

License : MIT License
