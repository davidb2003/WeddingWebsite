class WelcomeController < ApplicationController
  require 'mail'
  options = { :address              => "smtp.gmail.com",
              :port                 => 587,
              :user_name            => 'davidandkalkidan@gmail.com',
              :password             => 'dk7978236$',
              :authentication       => 'plain',
              :enable_starttls_auto => true  }
  Mail.defaults do
    delivery_method :smtp, options
  end
  def index
    redirect_to '/index.html'
  end

  def create

  if(params[:RSVP])
    ceremony = 'ceremony' if params[:ceremony]
    melse = 'melse' if params[:melse]
    reception = 'reception' if params[:reception]
    shower = 'shower' if params[:shower]
    attending = 'yes' if (params[:attending_yes])
    attending = 'no' if (params[:attending_no])
    attending = 'idk' if (params[:attending_idk])
    guests = params[:guest]
    name = params[:name]
    email = params[:email]
    phone = params[:phone]
    comment = params[:comment]
    mail = Mail.new do
      from     'davidandkalkidan@gmail.com'
      to       'david.brown2003@gmail.com, kalkidanbelay@gmail.com'
      subject  "#{name} RSVP'd with  #{guests} guest(s)"
      body     "Phone number: #{phone} \n Email: #{email} \n Attending: #{attending} the #{ceremony} and/or #{melse} and/or #{reception} and/or #{shower} \n Message: #{comment}"
    end
    mail.deliver!
    redirect_to '/rsvp.html'
  else
    name = params[:name]
    amount = params[:amount]
    phone = params[:phone]
    message = params[:message]
    mail = Mail.new do
      from     'davidandkalkidan@gmail.com'
      to       'david.brown2003@gmail.com, kalkidanbelay@gmail.com'
      subject  "#{name} Pledged a  #{amount}$ donation"
      body     "Phone number: #{phone} \n Message: #{message}"
    end
    mail.deliver!
    redirect_to '/contact.html'
  end
  end
end

