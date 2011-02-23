class GsrDetailsController < ApplicationController

def list
  user_email = params[:email]
  start_date = params[:start_date]
  end_date = params[:end_date]
  @user_email_value = validate(user_email)
  @start_date_value = validate(start_date)
  @end_date_value = validate(end_date)
  if(@user_email_value == 1 && @start_date_value ==1 && @end_date_value == 1)
    @user = User.find_all_by_email(user_email)  
    if(!@user.blank?)
      conditions = []
      conditions.add_condition!(["updated_at>= ?",start_date])
      conditions.add_condition!(["updated_at<= ?",end_date])
      @gsr_details_list = GsrDetails.find_all_by_user_id(@user[0].id, :conditions => conditions)
      else
       render :text => "0"
    end  
  else
    render :text => "0"       
  end 
end


def create
  
  user_email = params[:email]
  gsr_data = params[:gsr_data]
  @user_email_val = validate(user_email)
  @gsr_data = validate(gsr_data)
  if(@user_email_val == 1 && @gsr_data ==1)
    @user = User.find_all_by_email(user_email) 
    if(!@user.blank?)
     @gsr_details=GsrDetails.new  
     @gsr_details.user_id=@user[0].id
     @gsr_details.gsr_data=params[:gsr_data] 
     @gsr_details.save
   else
     render :text => "0"
    end
  else
    render :text => "0"
  end
    
end
    


def delete
  user_email = params[:email]
  start_date = params[:start_date]
  end_date = params[:end_date]
  @user_email_value = validate(user_email)
  @start_date_value = validate(start_date)
  @end_date_value = validate(end_date)
  if(@user_email_value == 1 && @start_date_value ==1 && @end_date_value == 1)
    @user = User.find_all_by_email(user_email)
    if(!@user.blank?)
     conditions = []
     conditions.add_condition!(["updated_at>= ?",start_date])
     conditions.add_condition!(["updated_at<= ?",end_date])
     @gsr_details_list = GsrDetails.find_all_by_user_id(@user[0].id, :conditions => conditions)
     @gsr_details_list.each do |gsr_details|
      gsr_details.destroy
      end
      else
       render :text => "0"
      end
  else
    render :text => "0"
  end 
    
end

end
  