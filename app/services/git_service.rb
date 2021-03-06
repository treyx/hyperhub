class GitService
  attr_reader :connection

  def initialize
    @connection = Faraday.new(url: "https://api.github.com/repos")
  end

  def find_repo(owner, repo, token)
    parse(connection.get("#{owner}/#{repo}?access_token=#{token}"))
  end

  def find_commit_history(owner, repo, token)
    parse(connection.get("#{owner}/#{repo}/stats/commit_activity?access_token=#{token}"))
  end

  def parse(response)
    JSON.parse(response.body, symbolize_names: true)
  end
end
