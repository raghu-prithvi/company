class AmbientTemperatureDetailsController < ApplicationController


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
      @ambient_temperature_details_list = AmbientTemperatureDetails.find_all_by_user_id(@user[0].id, :conditions => conditions)
else
       render :text => "0"
    end  
  else
    render :text => "0"       
  end 
end

def create
  
  user_email = params[:email]
  value = params[:value]
  duration = params[:duration] 
  @user_email_val = validate(user_email)
  @val = validate(value)
  @duration_val = validate(duration)
  if(@user_email_val == 1 && @val ==1 && @duration_val == 1)
    @user = User.find_all_by_email(user_email)  
    if(!@user.blank?)
      @ambient_temperature_details=AmbientTemperatureDetails.new  
      @ambient_temperature_details.user_id=@user[0].id
      @ambient_temperature_details.value=params[:value] 
      @ambient_temperature_details.duration=params[:duration] 
      @ambient_temperature_details.save
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
       @ambient_temperature_details_list = AmbientTemperatureDetails.find_all_by_user_id(@user[0].id, :conditions => conditions)
       @ambient_temperature_details_list.each do |ambient_temperature_details|
       ambient_temperature_details.destroy
       end
      else
       render :text => "0"
      end
  else
    render :text => "0"
  end 
    
end

end
  

