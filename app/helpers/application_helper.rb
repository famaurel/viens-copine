module ApplicationHelper
  def category_icon(category)
    icons  = {
      'fêtarde' => "fas fa-cocktail",
      'calme' => "fa-glass-whiskey"
    }
    return icons[category] ||  "fas fa-wine-glass-alt"
  end
end
