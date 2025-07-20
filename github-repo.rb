require 'net/http'
require 'json'

def fetch_repos(org, token)
  page = 1
  all_repos = []

  loop do
    url = URI("https://api.github.com/orgs/#{org}/repos?per_page=100&page=#{page}")
    request = Net::HTTP::Get.new(url)
    request["Authorization"] = "Bearer #{token}"

    response = Net::HTTP.start(url.hostname, url.port, use_ssl: true) { |http| http.request(request) }

    unless response.is_a?(Net::HTTPSuccess)
      puts "Error: #{response.code} - #{JSON.parse(response.body)['message'] rescue 'Unknown error'}"
      return
    end

    repos = JSON.parse(response.body)

    break if repos.empty?

    repos.each do |repo|
      unless repo['archived'] || repo['disabled'] || repo['fork']
        all_repos << repo['html_url']
      end
    end

    page += 1
  end

  all_repos
end

if ARGV.length != 2
  puts "Usage: ruby fetch_repos.rb <GITHUB_ORG> <GITHUB_TOKEN>"
  exit 1
end

org = ARGV[0]
token = ARGV[1]

repos = fetch_repos(org, token)
puts repos unless repos.empty?
