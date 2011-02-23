class HeartRateDetailsController < ApplicationController


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
      @heart_rate_details_list = HeartRateDetails.find_all_by_user_id(@user[0].id, :conditions => conditions)
    else
       render :text => "0"
    end  
  else
    render :text => "0"       
  end 
end


def create
  
  user_email = params[:email]
  heart_rate = params[:heart_rate]
  @user_email_value = validate(user_email)
  @heart_rate_value = validate(heart_rate)
  if(@user_email_value == 1 && @heart_rate_value ==1)
    @user = User.find_all_by_email(user_email)   
    if(!@user.blank?)
     @heart_rate_details=HeartRateDetails.new  
     @heart_rate_details.user_id=@user[0].id
     @heart_rate_details.heart_rate=params[:heart_rate] 
     @heart_rate_details.save
        
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
      @heart_rate_details_list = HeartRateDetails.find_all_by_user_id(@user[0].id, :conditions => conditions)
      @heart_rate_details_list.each do |heart_rate_details|
      heart_rate_details.destroy
  end
      else
       render :text => "0"
      end
  else
    render :text => "0"
  end 
    
end

end    
  