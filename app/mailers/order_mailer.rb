class OrderMailer < ApplicationMailer
  
  def new_order_to_repairman(order)
    @order = order
    mail(to: @order.technician.email, subject: '新柯打: ' + @order.store.client.chi_name + ' (' + @order.store.code + ' ' + @order.store.chi_name + ') ' )
  end
  
  def escalate_order_to_manager(order)
    @order = order
    @user = User.manager
    @user.each do |u| 
        mail(to: u.email, subject: '上報柯打: ' + @order.store.client.chi_name + ' (' + @order.store.code + ' ' + @order.store.chi_name + ') ')
    end 
  end
    
end