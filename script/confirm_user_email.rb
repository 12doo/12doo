User.all.each do |u|
  u.confirmed_at = Time.now
  u.save
end