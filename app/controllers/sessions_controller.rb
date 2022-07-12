class SessionsController < Devise::SessionsController 
	def create
		#byebug
		# if User.find_by_phone_number(params[:user][:phone_number]) == nil &&  User.find_by_user_name(params[:user][:user_name]) == nil
		# 	user = User.find_by_email(params[:user][:email])
		# 	elsif User.find_by_phone_number(params[:user][:phone_number]) == nil &&  User.find_by_email(params[:user][:email]) == nil
		# 	user = User.find_by_user_name(params[:user][:user_name])
		# 	elsif User.find_by_email(params[:user][:email]) == nil &&  User.find_by_user_name(params[:user][:user_name]) == nil
		# 	user = User.find_by_phone_number(params[:user][:phone_number])
		# end
		user = User.find_by_mobileno(params[:user][:mobileno])
		if user
		    if user.valid_password?(params[:user][:password])
		       flash[:notice] = "---------Log-in Sucessfully----------"
		       sign_in(user)
		       redirect_to root_path
		    else
			   flash[:alert]= "--------Incorrect password-----------"
			   redirect_to  user_session_path
		    end
		else
		       flash[:alert]="---------User not found--------------"
		       redirect_to  user_session_path
	    end
	end
end
