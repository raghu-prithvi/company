class ActivityDetailsController < ApplicationController

# method 1 = get list of activities for user between a date range
# method 2 = create activity for user
# method 3 = delete activity for user with start date & end date

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
      @activities_list = ActivityDetails.find_all_by_user_id(@user[0].id, :conditions => conditions)
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
  intensity = params[:intensity] 
  @user_email_val = validate(user_email)
  @val = validate(value)
  @intensity_val = validate(intensity)
  if(@user_email_val == 1 && @val ==1 && @intensity_val == 1)
    @user = User.find_all_by_email(user_email)  
      if(!@user.blank?)
        @activity=ActivityDetails.new   
        @activity.user_id=@user[0].id
        @activity.value=params[:value]
        @activity.intensity=params[:intensity]  
        @activity.save
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
      @activities_list = ActivityDetails.find_all_by_user_id(@user[0].id, :conditions => conditions)
      @activities_list.each do |activity|
      activity.destroy
    end
    else
      render :text => "0"
    end
  else
    render :text => "0"
  end 
    
end

end
  