module ApplicationHelper
  def default_profile_photo
    'default.png'
  end

  def no_image_photo
    'no_image.png'
  end

  def bootstrap_class_for(flash_type)
    case flash_type
    when 'success'
      'success'
    when 'error'
      'danger'
    when 'alert'
      'warning'
    when 'notice'
      'info'
    else
      flash_type.to_s
    end
  end

end
