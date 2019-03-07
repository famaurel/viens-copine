module ApplicationHelper

  def transport_icon(number)
    icons = ["fas fa-walking","fas fa-bicycle", "fas fa-bus-alt"]
    return icons[number.to_i] || "fas fa-walking"
  end

end
