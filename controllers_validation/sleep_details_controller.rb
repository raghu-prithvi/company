class SleepDetailsController < ApplicationController

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
      @sleep_details_list = SleepDetails.find_all_by_user_id(@user[0].id, :conditions => conditions)
      else
       render :text => "0"
    end  
  else
    render :text => "0"       
  end 
end


def create
  
  user_email = params[:email]
  sleep_time = params[:sleep_time]
  sleep_efficiency = params[:sleep_efficiency]   
  @user_email_val = validate(user_email)
  @sleep_time_val = validate(sleep_time)
  @sleep_time_eff_val = validate(sleep_efficiency)
  if(@user_email_val == 1 && @sleep_time_val ==1 && @sleep_time_eff_val == 1)  
    @user = User.find_all_by_email(user_email)  
    if(!@user.blank?)
     @sleep_details=SleepDetails.new  
     @sleep_details.user_id=@user[0].id
     @sleep_details.sleep_time=params[:sleep_time]   
     @sleep_details.sleep_efficiency=params[:sleep_efficiency]   
     @sleep_details.save
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
      @sleep_details_list = SleepDetails.find_all_by_user_id(@user[0].id, :conditions => conditions)
      @sleep_details_list.each do |energy_details|
      energy_details.destroy
      end
      else
       render :text => "0"
      end
  else
    render :text => "0"
  end 
    
end

end
  