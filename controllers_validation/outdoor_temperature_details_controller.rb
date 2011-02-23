class OutdoorTemperatureDetailsController < ApplicationController

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
      @outdoor_temperature_details_list = OutdoorTemperatureDetails.find_all_by_user_id(@user[0].id, :conditions => conditions)
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
  @user_email_value = validate(user_email)
  @value = validate(value)
  @duration_value = validate(duration)
  if(@user_email_value == 1 && @value ==1 && @duration_value == 1)
     @user = User.find_all_by_email(user_email)   
     if(!@user.blank?)
       @outdoor_temperature_details=OutdoorTemperatureDetails.new  
       @outdoor_temperature_details.user_id=@user[0].id
      @outdoor_temperature_details.value=params[:value] 
      @outdoor_temperature_details.duration=params[:duration] 
      @outdoor_temperature_details.save
    
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
      @outdoor_temperature_details_list = OutdoorTemperatureDetails.find_all_by_user_id(@user[0].id, :conditions => conditions)
      @outdoor_temperature_details_list.each do |outdoor_temperature_details|
      outdoor_temperature_details.destroy
  end
      else
       render :text => "0"
      end
  else
    render :text => "0"
  end 
    
end

end
