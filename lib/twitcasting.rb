require "twitcasting/version"
require "curl"
require "json"

module TwitCasting
  class Client
    BASE_URL = 'http://api.twitcasting.tv/api/'

    def initialize(options = {})

    end

    def get_comments(options = {})
      params = {}
      params['type'] = 'json'
      params['user'] = options[:user] if options[:user]
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

  class Comment

    attr_accessor :commentid,
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

    def initialize(options = {})
      @commentid = options['commentid']
      @movieid = options['movieid']
      @message = options['message']
      @userid = options['userid']
      @socialid = options['socialid']
      @userstatus = options['userstatus']
      @moviestatus = options['moviestatus']
      @created = options['created'].to_i if options['created']
      @thumbnail = options['thumbnail']
      @latitude = options['latitude']
      @longuitude = options['longuitude']
      @statusid = options['statusid']
      @duration = options['duration']
    end

  end
end
