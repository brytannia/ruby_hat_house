Rails.application.routes.draw do
  get 'house/:uid' => 'parlor#fireplace'
end
