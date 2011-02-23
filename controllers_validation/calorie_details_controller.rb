class CalorieDetailsController < ApplicationController
  
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
      @calorie_details_list = CalorieDetails.find_all_by_user_id(@user[0].id, :conditions => conditions)
    else
      render :text => "0"
    end  
  else
    render :text => "0"       
  end 
end


def create
  
  user_email = params[:email]
  calories_burnt = params[:calories_burnt] 
  @user_email_value = validate(user_email)
  @calories_burnt_val = validate(calories_burnt)
  if(@user_email_value == 1 && @calories_burnt_val == 1)
    @user = User.find_all_by_email(user_email)  
    if(!@user.blank?)
      @calorie_details=CalorieDetails.new  
      @calorie_details.user_id=@user[0].id
      @calorie_details.calories_burnt=params[:calories_burnt] 
      @calorie_details.save
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
      @calorie_details_list = CalorieDetails.find_all_by_user_id(@user[0].id, :conditions => conditions)
      @calorie_details_list.each do |calorie_details|
      calorie_details.destroy
    end
    else
      render :text => "0"
    end
  else
    render :text => "0"
  end 
    
end

end
  