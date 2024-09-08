# Design a simplified version of Twitter where users can post tweets, follow/unfollow another user, and is able to see the 10 most recent tweets in the user's news feed.

# Implement the Twitter class:

# Twitter() Initializes your twitter object.
# void postTweet(int userId, int tweetId) Composes a new tweet with ID tweetId by the user userId. Each call to this function will be made with a unique tweetId.
# List<Integer> getNewsFeed(int userId) Retrieves the 10 most recent tweet IDs in the user's news feed. Each item in the news feed must be posted by users who the user followed or by the user themself. Tweets must be ordered from most recent to least recent.
# void follow(int followerId, int followeeId) The user with ID followerId started following the user with ID followeeId.
# void unfollow(int followerId, int followeeId) The user with ID followerId started unfollowing the user with ID followeeId.

# 簡略化されたTwitterのデザインを実装します。ユーザーがツイートを投稿し、他のユーザーをフォロー/アンフォローし、そのユーザーのニュースフィードに最新の10件のツイートが表示されるようにします。

# 次の操作を行える Twitter クラスを実装します:

# Twitter()
# Twitterオブジェクトを初期化します。

# void postTweet(int userId, int tweetId)
# userId によって tweetId のツイートを投稿します。この関数は、呼び出されるたびにユニークな tweetId を持つツイートが投稿されます。

# List<Integer> getNewsFeed(int userId)
# userId のニュースフィードに表示される最新の10件のツイートIDを取得します。このニュースフィードには、そのユーザーがフォローしているユーザーや自身が投稿したツイートが含まれます。ツイートは最新のものから順に表示されます。

# void follow(int followerId, int followeeId)
# followerId が followeeId をフォローします。

# void unfollow(int followerId, int followeeId)
# followerId が followeeId のフォローを解除します。

# Example 1:

# Input
# ["Twitter", "postTweet", "getNewsFeed", "follow", "postTweet", "getNewsFeed", "unfollow", "getNewsFeed"]
# [[], [1, 5], [1], [1, 2], [2, 6], [1], [1, 2], [1]]
# Output
# [null, null, [5], null, null, [6, 5], null, [5]]

# Explanation
# Twitter twitter = new Twitter();
# twitter.postTweet(1, 5); // User 1 posts a new tweet (id = 5).
# twitter.getNewsFeed(1);  // User 1's news feed should return a list with 1 tweet id -> [5]. return [5]
# twitter.follow(1, 2);    // User 1 follows user 2.
# twitter.postTweet(2, 6); // User 2 posts a new tweet (id = 6).
# twitter.getNewsFeed(1);  // User 1's news feed should return a list with 2 tweet ids -> [6, 5]. Tweet id 6 should precede tweet id 5 because it is posted after tweet id 5.
# twitter.unfollow(1, 2);  // User 1 unfollows user 2.
# twitter.getNewsFeed(1);  // User 1's news feed should return a list with 1 tweet id -> [5], since user 1 is no longer following user 2.
 

# Constraints:

# 1 <= userId, followerId, followeeId <= 500
# 0 <= tweetId <= 104
# All the tweets have unique IDs.
# At most 3 * 104 calls will be made to postTweet, getNewsFeed, follow, and unfollow.

require 'set'

class Twitter
  def initialize
    # ユーザーごとのツイートを保存する
    @tweets = Hash.new { |hash, key| hash[key] = [] }
    # ユーザーごとのフォロワーリストを保存する
    @followers = Hash.new { |hash, key| hash[key] = Set.new }
    # グローバルなタイムスタンプ
    @time = 0
  end

  # ツイートを投稿する
  def postTweet(userId, tweetId)
    @tweets[userId] << [tweetId, @time] # ツイートIDとタイムスタンプを保存
    @time += 1
  end

  # ニュースフィードを取得する
  def getNewsFeed(userId)
    # ユーザー自身とフォローしているユーザーのツイートを取得
    feeds = @tweets[userId] + @followers[userId].flat_map { |followeeId| @tweets[followeeId] }
    # 最新10件のツイートIDを返す
    feeds.sort_by { |tweetId, time| -time }.first(10).map { |tweetId, time| tweetId }
  end

  # ユーザーをフォローする
  def follow(followerId, followeeId)
    return if followerId == followeeId # 自分自身をフォローする場合を除外
    @followers[followerId].add(followeeId)
  end

  # ユーザーのフォローを解除する
  def unfollow(followerId, followeeId)
    @followers[followerId].delete(followeeId)
  end
end

# 実行例
twitter = Twitter.new
twitter.postTweet(1, 5) # ユーザー1がツイート5を投稿
puts "NewsFeed for user 1: #{twitter.getNewsFeed(1)}" # ユーザー1のニュースフィードは[5]
twitter.follow(1, 2)    # ユーザー1がユーザー2をフォロー
twitter.postTweet(2, 6) # ユーザー2がツイート6を投稿
puts "NewsFeed for user 1 after following user 2: #{twitter.getNewsFeed(1)}" # [6, 5]
twitter.unfollow(1, 2)  # ユーザー1がユーザー2のフォローを解除
puts "NewsFeed for user 1 after unfollowing user 2: #{twitter.getNewsFeed(1)}" # [5]
