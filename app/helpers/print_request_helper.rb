module PrintRequestHelper
  def pretty_next_state_of print_request
    if print_request.status == 'Delivered'
      'Send to Printer'
    elsif print_request.status == 'Started'
      'Ready for Pickup'
    end
  end

  def next_state_visible? print_request
    ['Delivered', 'Started'].include? print_request.status
  end
end
