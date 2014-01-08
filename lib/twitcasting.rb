require "twitcasting/version"
require "curl"
require "json"

module TwitCasting
  class Client
    BASE_URL = 'http://api.twitcasting.tv/api/'

    def initialize
    end

    def get_live_status(user)
      params = {}
      params['type'] = 'json'
      params['user'] = user

      parse_live_status(get(BASE_URL + 'livestatus' + make_query_string(params)))
    end

    def get_comments(user, options = {})
      params = {}
      params['type'] = 'json'
      params['user'] = user if user
      params['movieid'] = options[:movieid] if options[:movieid]
      params['from'] = options[:from] if options[:from]
      params['count'] = options[:count] if options[:count]
      params['since'] = options[:since] if options[:since]

      parse_get_comments(get(BASE_URL + 'commentlist' + make_query_string(params)))
    end

    private

    def response(result)
      result[:response]
    end

    def body(result)
      result[:body]
    end

    def parse_live_status(result)
      response = response(result)

      return nil unless response == 200

      body = body(result)

      LiveStatus.new(body)
    end

    def parse_get_comments(result)
      response = response(result)

      return nil unless response == 200

      body = body(result)
      comments = []
      body.each { |value| comments << Comment.new(value) }

      comments
    end

    def make_query_string(options)
      query = "?"
      options.each do |key, value|
        query += "#{key}=#{value.to_s.gsub(" ", "+")}&"
      end

      query[0...-1]
    end

    def post(url, data)
      JSON.parse(Curl.post(url, data).body_str)
      c = Curl.post(url, data)

      { :body => JSON.parse(c.body_str), :response => c.response_code }
    end

    def get(url)
      c = Curl.get(url)

      { :body => JSON.parse(c.body_str), :response => c.response_code }
    end

#    def put(url, data)
#      c = Curl.put(url,data.to_json) do |curl|
#        curl.headers['Accept'] = 'application/json'
#        curl.headers['Content-Type'] = 'application/json'
#        curl.headers['Api-Version'] = '2.2'
#        end
#      { :body => JSON.parse(c.body_str), :response => c.response_code }
#    end

  end

  class LiveStatus

    attr_reader :islive,
                :protected,
                :movieid,
                :comments,
                :viewers,
                :total,
                :duration,
                :subtitle,
                :typing,
                :hashtag,
                :title

    def initialize(elements = {})
      @islive = elements['islive']
      @protected = elements['protected']
      @movieid = elements['movieid']
      @comments = elements['comments']
      @viewers = elements['viewers']
      @total = elements['total']
      @duration = elements['duration']
      @subtitle = elements['subtitle']
      @typing = elements['typing']
      @hashtag = elements['hashtag']
      @title = elements['title']
    end
  end

  class Comment

    attr_reader :commentid,
                :movieid,
                :userid,
                :socialid,
                :message,
                :userstatus,
                :moviestatus,
                :created,
                :thumbnail,
                :latitude,
                :longuitude,
                :statusid,
                :duration

    def initialize(elements = {})
      @commentid = elements['commentid']
      @movieid = elements['movieid']
      @message = elements['message']
      @userid = elements['userid']
      @socialid = elements['socialid']
      @userstatus = elements['userstatus']
      @moviestatus = elements['moviestatus']
      @created = elements['created'].to_i if elements['created']
      @thumbnail = elements['thumbnail']
      @latitude = elements['latitude']
      @longuitude = elements['longuitude']
      @statusid = elements['statusid']
      @duration = elements['duration']
    end

  end
end
