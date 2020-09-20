class AddUserToTweets < ActiveRecord::Migration[6.0]
  #正確には上のクラスはAddUserIdToTweets
  def change
    add_column :tweets, :user_id, :integer
  end
end
