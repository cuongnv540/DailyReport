require 'rubygems'
require 'rufus/scheduler'

scheduler = Rufus::Scheduler.start_new
	scheduler.at(" 17:00:00 +0700 ")  do
		@users = User.find_by_sql("select *from users where users.manager='t' ")
		@users.each do |user|
			UserMailer.send_email(user).deliver
		end
	end