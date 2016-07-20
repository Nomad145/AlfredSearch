#!/usr/bin/ruby

require 'yaml'
require 'uri'
require 'json'

def createItem(keyword, match, args = [])
    url = !args.empty? ? match['url'] + URI.escape(args.join('+')) : ''

    return {
        'title' => keyword,
        'subtitle' => 'Search ' + match['name'],
        'autocomplete' => keyword,
        'arg' => url
    }
end

results = {}
args = ARGV[0].nil? ? [] : ARGV[0].split
keyword = args.shift
filters = YAML::load_file('/Users/nomad/.bin/alfred/search/filters.yml')['search']

results[:items] = filters.keys.grep(/#{keyword}/) do |match|
    createItem(match, filters[match], args)
end

puts JSON.generate(results)
