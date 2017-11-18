class ParlorController < ApplicationController
  before_action :validate_member

  def fireplace

  end

  private

  def validate_member
    @member = Member.find_by uid: params[:uid]
    not_found unless @member
  end
end
