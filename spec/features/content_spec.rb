require "rails_helper"

describe "/recent" do
  it "has the captions of multiple photos", :points => 1 do
    first_user = User.new
    first_user.save

    second_user = User.new
    second_user.save

    first_photo = Photo.new
    first_photo.owner_id = first_user.id
    first_photo.caption = "First caption #{rand(100)}"
    first_photo.save

    second_photo = Photo.new
    second_photo.owner_id = second_user.id
    second_photo.caption = "Second caption #{rand(100)}"
    second_photo.save

    visit "/recent"

    expect(page).to have_content(first_photo.caption)
    expect(page).to have_content(second_photo.caption)
  end
end

describe "/photos/[ID]" do
  it "has the caption of the photo" do
    user = User.new
    user.save

    photo = Photo.new
    photo.owner_id = user.id
    photo.caption = "Some caption #{rand(100)}"
    photo.save

    visit "/photos/#{photo.id}"

    expect(page).to have_content(photo.caption)
  end
end

describe "/photos/[ID]" do
  it "has the username of the owner of the photo" do
    user = User.new
    user.username = "alice_#{rand(100)}"
    user.save

    photo = Photo.new
    photo.owner_id = user.id
    photo.save

    visit "/photos/#{photo.id}"

    expect(page).to have_content(user.username)
  end
end

describe "/photos/[ID]" do
  it "has the comments left on the photo" do
    user = User.new
    user.save

    photo = Photo.new
    photo.owner_id = user.id
    photo.save

    first_commenter = User.new
    first_commenter.save

    first_comment = Comment.new
    first_comment.author_id = first_commenter.id
    first_comment.photo_id = photo.id
    first_comment.body = "Some comment #{rand(100)}"
    first_comment.save

    second_commenter = User.new
    second_commenter.save

    second_comment = Comment.new
    second_comment.author_id = second_commenter.id
    second_comment.photo_id = photo.id
    second_comment.body = "Some comment #{rand(100)}"
    second_comment.save

    visit "/photos/#{photo.id}"

    expect(page).to have_content(first_comment.body)
    expect(page).to have_content(second_comment.body)
  end
end

describe "/photos/[ID]" do
  it "has the usernames of commenters on the photo" do
    user = User.new
    user.save

    photo = Photo.new
    photo.owner_id = user.id
    photo.save

    first_commenter = User.new
    first_commenter.username = "bob_#{rand(100)}"
    first_commenter.save

    first_comment = Comment.new
    first_comment.author_id = first_commenter.id
    first_comment.photo_id = photo.id
    first_comment.save

    second_commenter = User.new
    second_commenter.username = "carol_#{rand(100)}"
    second_commenter.save

    second_comment = Comment.new
    second_comment.author_id = second_commenter.id
    second_comment.photo_id = photo.id
    second_comment.save

    visit "/photos/#{photo.id}"

    expect(page).to have_content(first_commenter.username)
    expect(page).to have_content(second_commenter.username)
  end
end

describe "/users" do
  it "has the usernames of multiple users", :points => 1 do
    first_user = User.new
    first_user.username = "alice_#{rand(100)}"
    first_user.save

    second_user = User.new
    second_user.username = "bob_#{rand(100)}"
    second_user.save

    visit "/users"

    expect(page).to have_content(first_user.username)
    expect(page).to have_content(second_user.username)
  end
end

describe "/users/[ID]" do
  it "has the username of the user", :points => 1 do
    user = User.new
    user.username = "alice_#{rand(100)}"
    user.save

    visit "/users/#{user.id}"

    expect(page).to have_content(user.username)
  end
end

describe "/users/[ID]" do
  it "has the photos posted by the user", :points => 1 do
    user = User.new
    user.save

    other_user = User.new
    other_user.save

    first_photo = Photo.new
    first_photo.owner_id = user.id
    first_photo.caption = "First caption #{rand(100)}"
    first_photo.save

    second_photo = Photo.new
    second_photo.owner_id = other_user.id
    second_photo.caption = "Second caption #{rand(100)}"
    second_photo.save

    third_photo = Photo.new
    third_photo.owner_id = user.id
    third_photo.caption = "Third caption #{rand(100)}"
    third_photo.save

    visit "/users/#{user.id}"

    expect(page).to have_content(first_photo.caption)
    expect(page).to have_content(third_photo.caption)
    expect(page).to have_no_content(second_photo.caption)
  end
end

describe "/users/[ID]/liked" do
  it "has the photos the user has liked", :points => 2 do
    user = User.new
    user.save

    other_user = User.new
    other_user.save

    first_photo = Photo.new
    first_photo.owner_id = other_user.id
    first_photo.caption = "Some caption #{rand(100)}"
    first_photo.save

    second_photo = Photo.new
    second_photo.owner_id = user.id
    second_photo.caption = "Some caption #{rand(100)}"
    second_photo.save

    third_photo = Photo.new
    third_photo.owner_id = other_user.id
    third_photo.caption = "Some caption #{rand(100)}"
    third_photo.save

    first_like = Like.new
    first_like.photo_id = first_photo.id
    first_like.fan_id = user.id
    first_like.save

    second_like = Like.new
    second_like.photo_id = second_photo.id
    second_like.fan_id = other_user.id
    second_like.save

    third_like = Like.new
    third_like.photo_id = third_photo.id
    third_like.fan_id = user.id
    third_like.save

    visit "/users/#{user.id}/liked"

    expect(page).to have_content(first_photo.caption)
    expect(page).to have_content(third_photo.caption)
    expect(page).to have_no_content(second_photo.caption)
  end
end

describe "/users/[ID]/feed" do
  it "has the photos posted by the people the user is following", :points => 4 do
    user = User.new
    user.save

    first_other_user = User.new
    first_other_user.save

    first_other_user_first_photo = Photo.new
    first_other_user_first_photo.owner_id = first_other_user.id
    first_other_user_first_photo.caption = "Some caption #{rand(100)}"
    first_other_user_first_photo.save
    first_other_user_second_photo = Photo.new
    first_other_user_second_photo.owner_id = first_other_user.id
    first_other_user_second_photo.caption = "Some caption #{rand(100)}"
    first_other_user_second_photo.save

    second_other_user = User.new
    second_other_user.save

    second_other_user_first_photo = Photo.new
    second_other_user_first_photo.owner_id = second_other_user.id
    second_other_user_first_photo.caption = "Some caption #{rand(100)}"
    second_other_user_first_photo.save
    second_other_user_second_photo = Photo.new
    second_other_user_second_photo.owner_id = second_other_user.id
    second_other_user_second_photo.caption = "Some caption #{rand(100)}"
    second_other_user_second_photo.save

    third_other_user = User.new
    third_other_user.save

    third_other_user_first_photo = Photo.new
    third_other_user_first_photo.owner_id = third_other_user.id
    third_other_user_first_photo.caption = "Some caption #{rand(100)}"
    third_other_user_first_photo.save
    third_other_user_second_photo = Photo.new
    third_other_user_second_photo.owner_id = third_other_user.id
    third_other_user_second_photo.caption = "Some caption #{rand(100)}"
    third_other_user_second_photo.save

    fourth_other_user = User.new
    fourth_other_user.save

    fourth_other_user_first_photo = Photo.new
    fourth_other_user_first_photo.owner_id = fourth_other_user.id
    fourth_other_user_first_photo.caption = "Some caption #{rand(100)}"
    fourth_other_user_first_photo.save
    fourth_other_user_second_photo = Photo.new
    fourth_other_user_second_photo.owner_id = fourth_other_user.id
    fourth_other_user_second_photo.caption = "Some caption #{rand(100)}"
    fourth_other_user_second_photo.save

    first_follow_request = FollowRequest.new
    first_follow_request.sender_id = user.id
    first_follow_request.recipient_id = first_other_user.id
    first_follow_request.status = "rejected"
    first_follow_request.save

    second_follow_request = FollowRequest.new
    second_follow_request.sender_id = user.id
    second_follow_request.recipient_id = second_other_user.id
    second_follow_request.status = "accepted"
    second_follow_request.save

    third_follow_request = FollowRequest.new
    third_follow_request.sender_id = user.id
    third_follow_request.recipient_id = third_other_user.id
    third_follow_request.status = "pending"
    third_follow_request.save

    fourth_follow_request = FollowRequest.new
    fourth_follow_request.sender_id = user.id
    fourth_follow_request.recipient_id = fourth_other_user.id
    fourth_follow_request.status = "accepted"
    fourth_follow_request.save

    visit "/users/#{user.id}/feed"

    expect(page).to have_content(second_other_user_first_photo.caption)
    expect(page).to have_content(second_other_user_second_photo.caption)
    expect(page).to have_content(fourth_other_user_first_photo.caption)
    expect(page).to have_content(fourth_other_user_second_photo.caption)

    expect(page).to have_no_content(first_other_user_first_photo.caption)
    expect(page).to have_no_content(third_other_user_first_photo.caption)
  end
end

describe "/users/[ID]/discover" do
  it "has the photos that are liked by the people the user is following", :points => 4 do
    user = User.new
    user.save

    first_other_user = User.new
    first_other_user.save

    second_other_user = User.new
    second_other_user.save

    third_other_user = User.new
    third_other_user.save

    fourth_other_user = User.new
    fourth_other_user.save

    first_other_user_first_liked_photo = Photo.new
    first_other_user_first_liked_photo.owner_id = fourth_other_user.id
    first_other_user_first_liked_photo.caption = "Some caption #{rand(100)}"
    first_other_user_first_liked_photo.save

    first_other_user_first_like = Like.new
    first_other_user_first_like.fan_id = first_other_user.id
    first_other_user_first_like.photo_id = first_other_user_first_liked_photo.id
    first_other_user_first_like.save

    first_other_user_second_liked_photo = Photo.new
    first_other_user_second_liked_photo.owner_id = fourth_other_user.id
    first_other_user_second_liked_photo.caption = "Some caption #{rand(100)}"
    first_other_user_second_liked_photo.save

    first_other_user_first_like = Like.new
    first_other_user_first_like.fan_id = first_other_user.id
    first_other_user_first_like.photo_id = first_other_user_second_liked_photo.id
    first_other_user_first_like.save

    second_other_user_first_liked_photo = Photo.new
    second_other_user_first_liked_photo.owner_id = fourth_other_user.id
    second_other_user_first_liked_photo.caption = "Some caption #{rand(100)}"
    second_other_user_first_liked_photo.save

    second_other_user_first_like = Like.new
    second_other_user_first_like.fan_id = second_other_user.id
    second_other_user_first_like.photo_id = second_other_user_first_liked_photo.id
    second_other_user_first_like.save

    second_other_user_second_liked_photo = Photo.new
    second_other_user_second_liked_photo.owner_id = fourth_other_user.id
    second_other_user_second_liked_photo.caption = "Some caption #{rand(100)}"
    second_other_user_second_liked_photo.save

    second_other_user_first_like = Like.new
    second_other_user_first_like.fan_id = second_other_user.id
    second_other_user_first_like.photo_id = second_other_user_second_liked_photo.id
    second_other_user_first_like.save

    third_other_user_first_liked_photo = Photo.new
    third_other_user_first_liked_photo.owner_id = fourth_other_user.id
    third_other_user_first_liked_photo.caption = "Some caption #{rand(100)}"
    third_other_user_first_liked_photo.save

    third_other_user_first_like = Like.new
    third_other_user_first_like.fan_id = third_other_user.id
    third_other_user_first_like.photo_id = third_other_user_first_liked_photo.id
    third_other_user_first_like.save

    third_other_user_second_liked_photo = Photo.new
    third_other_user_second_liked_photo.owner_id = fourth_other_user.id
    third_other_user_second_liked_photo.caption = "Some caption #{rand(100)}"
    third_other_user_second_liked_photo.save

    third_other_user_first_like = Like.new
    third_other_user_first_like.fan_id = third_other_user.id
    third_other_user_first_like.photo_id = third_other_user_second_liked_photo.id
    third_other_user_first_like.save

    fourth_other_user_first_liked_photo = Photo.new
    fourth_other_user_first_liked_photo.owner_id = fourth_other_user.id
    fourth_other_user_first_liked_photo.caption = "Some caption #{rand(100)}"
    fourth_other_user_first_liked_photo.save

    fourth_other_user_first_like = Like.new
    fourth_other_user_first_like.fan_id = fourth_other_user.id
    fourth_other_user_first_like.photo_id = fourth_other_user_first_liked_photo.id
    fourth_other_user_first_like.save

    fourth_other_user_second_liked_photo = Photo.new
    fourth_other_user_second_liked_photo.owner_id = fourth_other_user.id
    fourth_other_user_second_liked_photo.caption = "Some caption #{rand(100)}"
    fourth_other_user_second_liked_photo.save

    fourth_other_user_first_like = Like.new
    fourth_other_user_first_like.fan_id = fourth_other_user.id
    fourth_other_user_first_like.photo_id = fourth_other_user_second_liked_photo.id
    fourth_other_user_first_like.save

    first_follow_request = FollowRequest.new
    first_follow_request.sender_id = user.id
    first_follow_request.recipient_id = first_other_user.id
    first_follow_request.status = "rejected"
    first_follow_request.save

    second_follow_request = FollowRequest.new
    second_follow_request.sender_id = user.id
    second_follow_request.recipient_id = second_other_user.id
    second_follow_request.status = "accepted"
    second_follow_request.save

    third_follow_request = FollowRequest.new
    third_follow_request.sender_id = user.id
    third_follow_request.recipient_id = third_other_user.id
    third_follow_request.status = "pending"
    third_follow_request.save

    fourth_follow_request = FollowRequest.new
    fourth_follow_request.sender_id = user.id
    fourth_follow_request.recipient_id = fourth_other_user.id
    fourth_follow_request.status = "accepted"
    fourth_follow_request.save

    visit "/users/#{user.id}/discover"

    expect(page).to have_content(second_other_user_first_liked_photo.caption)
    expect(page).to have_content(second_other_user_second_liked_photo.caption)
    expect(page).to have_content(fourth_other_user_first_liked_photo.caption)
    expect(page).to have_content(fourth_other_user_second_liked_photo.caption)

    expect(page).to have_no_content(first_other_user_first_liked_photo.caption)
    expect(page).to have_no_content(third_other_user_first_liked_photo.caption)
  end
end
