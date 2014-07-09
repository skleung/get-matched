module ApplicationHelper

  def bootstrap_class_for(type)
    if type == 'alert'
      return 'alert-danger'
    end
    'alert-success'
  end

end
