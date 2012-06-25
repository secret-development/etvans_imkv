# -*- encoding : utf-8 -*-
class Photo < ActiveRecord::Base
  belongs_to :subject
  mount_uploader :image, PhotoUploader
end
# == Schema Information
#
# Table name: photos
#
#  id         :integer(4)      not null, primary key
#  subject_id :integer(4)
#  image      :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

