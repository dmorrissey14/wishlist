require 'thread'

# Memory cache meant to facilitate suggesting members of a group
# a user is editing.
class UserSuggestionCache
  # Default constructor - initializes a new instance of the
  # UserSuggestionCache class.
  def initialize(user)
    super()
    @user = user
    @last_results = []
    @mutex = Mutex.new
    load_cache
  end

  # Whether or not the cache is initialized.
  def initialized?
    @mutex.synchronize do
      @is_initialized
    end
  end

  # The results of the last query made against the cache as an array.
  def last_results
    @mutex.synchronize do
      @last_results
    end
  end

  # Returns all users in the cache's search pool.
  def search_pool
    @mutex.synchronize do
      @users.to_ary
    end
  end

  # Queries the cache contents to suggest users whose full names contain
  # the provided substring. The results are returned as an array.
  def suggest_users(substr)
    return [] unless initialized?
    return @users if substr.empty?
    @mutex.synchronize do
      search_pool = if @last_substr && (substr.downcase.include? @last_substr)
                      @last_results
                    else
                      @users
                    end
      @last_substr = substr.downcase
      @last_results = []
      search_pool.each do |u|
        @last_results.push(u) if u.full_name.downcase.include? @last_substr
      end
      @last_results
    end
  end

  # Refreshes the contents of the cache.
  def refresh
    return unless initialized?
    load_cache
  end

  private

  # Populates the cache with users that are a member of one or more groups
  # to which the user used to create the cache belongs.
  def load_cache
    @mutex.synchronize do
      @users = []
      @is_initialized = false
      @user.reload
      @user.groups.each do |g|
        g.users.each do |u|
          @users.push(u) if u.id != @user.id && !@users.include?(u)
        end
      end
      @is_initialized = true
    end
  end
end
