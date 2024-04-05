module ReviewsHelper
  def review_star(star_index, rating)
    default_classes = 'w-4 h-4 mr-1 '
    default_classes += star_index <= rating.to_i ? 'text-yellow-300' : 'text-gray-300'
    default_classes
  end

  def sort_review_option_list
    [
      ['Default', ''],
      ['Rating low to high', 'rating asc'],
      ['Rating high to low', 'rating desc'],
      ['Latest reviews', 'created_at desc']
    ]
  end
end
