module PrintRequestHelper
  def pretty_next_state_of print_request
    if print_request.status == 'Not Ready'
      'Send to Printer'
    elsif print_request.status == 'Started'
      'Ready for Pickup'
    end
  end

  def next_state_visible? print_request
    not ['Not Ready', 'Started'].include? print_request.status
  end
end
