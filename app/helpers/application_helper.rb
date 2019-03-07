module ApplicationHelper
  def category_icon(category)
    icons  = {
      'fêtarde' => "fas fa-cocktail",
      'calme' => "fa-glass-whiskey"
    }
    return icons[category] || "fas fa-wine-glass-alt"
  end

  def transport_icon(number)
    icons = ["fas fa-walking","fas fa-bicycle", "fas fa-bus-alt"]
    return icons[number.to_i] || "fas fa-walking"
  end

end
