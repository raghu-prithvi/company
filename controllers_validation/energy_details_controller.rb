class EnergyDetailsController < ApplicationController

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
      @energy_details_list = EnergyDetails.find_all_by_user_id(@user[0].id, :conditions => conditions)
   else
        render :text => "0"
      end
  else
    render :text => "0"
  end    
end
 

def create  
  user_email = params[:email]
  energy_level = params[:energy_level]  
  @user_email_value = validate(user_email)
  @energy_level_value = validate(energy_level)
  if(@user_email_value == 1 && @energy_level_value == 1)
    @user = User.find_all_by_email(user_email)  
    if(!@user.blank?)
      @energy_details=EnergyDetails.new  
      @energy_details.user_id=@user[0].id
      @energy_details.energy_level=energy_level
      @energy_details.save
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
      @energy_details_list = EnergyDetails.find_all_by_user_id(@user[0].id, :conditions => conditions)
      @energy_details_list.each do |energy_details|
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
  