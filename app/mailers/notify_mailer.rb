class NotifyMailer < ActionMailer::Base
  #Alerts email from pickgrapevine; auto-reply nada!
  default from: "alerts@pickgrapevine.com"

  ### Used for testing inside of 'rails c', can email as an argument
  # def signup(email)
  #   mail to: email, subject: "TESTy: Ohh.. me soo horny...; Thanks for signing up!"
  # end

  ### Used in production
  # Send a signup email to the user, pass user object that contains the user's email address
  def signup(user)
    mail to: user.email, subject: "Thanks for signing up!"
  end

  # Send signup email notification to Erik, pass in user object
  def new_customer(user)
    @user = user
    mail to: "erik@pickgrapevine.com", subject: "New customer signed up"
  end

  def invoice_succeeded(invoice, customer)
    @subscription = invoice.lines.subscription[0]
    @user = customer
    mail to: "erik@pickgrapevine.com", subject: "#{@user.name} was charged, invoice sent"
  end

end
