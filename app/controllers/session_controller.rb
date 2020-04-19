class SessionsController < ApplicationController

    def new
    end
  
    def create
        #:session is the object defined on the form of new.html.erb
        #you need to use downcase since email has no upper cases and its not case sensitive
        #find_by instead of find, when looking for a particular parameter
        user = User.find_by(email: params[:session][:email].downcase)
        #https://apidock.com/rails/ActiveModel/SecurePassword/InstanceMethodsOnActivation/authenticate
        #authenticate way on bcrypt', '~> 3.1.7'
        if user && user.authenticate(params[:session][:password])
        #session object in ruby that would lives in all the HTTP request through the application
          session[:user_id] = user.id
          flash[:notice] = "Logged in successfully"
          redirect_to user
        else
        #the difference between flash.now and the other, it's that is displayed inmediately and not when the page redirects 
          flash.now[:alert] = "There was something wrong with your login details"
          render 'new'
        end
    end
  
    def destroy
        #the way to logout (deauthenticate) is to nil the session.
        session[:user_id] = nil
        flash[:notice] = "Logged out"
        redirect_to root_path
      end
  
  end 