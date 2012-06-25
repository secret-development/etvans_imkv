# -*- encoding : utf-8 -*-

class Subject < ActiveRecord::Base
  
  # associations
  belongs_to :typesubject
  belongs_to :city
  belongs_to :typetransaction
  belongs_to :customer
  belongs_to :district
  belongs_to :resident
  has_many :photos, :dependent => :destroy
  has_one :transaction, :dependent => :nullify, :autosave => true
  belongs_to :user
  
  has_many :properties, :dependent => :destroy
  accepts_nested_attributes_for :properties, :reject_if => lambda {|a| a[:value].blank? }
  
  
  # callbacks:
  before_update :check_typesubject
  
  # verify customer real
  after_save :verify_customer_real
  after_update :verify_customer_real
  after_destroy :verify_customer_real
  
  before_save :nill_floor
  before_update :nill_floor
  before_save :full_address
  before_update :full_address
  
  before_validation :format_price
  before_validation :resident_check
  
  # validations:
  validates :typesubject_id, :presence => true
  validates :city_id, :presence => true
  validates :price, :presence => true, :numericality => true
  validates :customer_id, :presence => true
  validates :districtname, :presence => true
  validates :floor, :presence => true, :if => :floor?
  validates :floorall, :presence => true, :if => :floor?
  validates :room, :presence => true, :if => :room?
  validates :price_currency, :presence => true
  validates :note, :length => { :maximum => 800 }, :allow_blank => true
  attr_writer :street, :house, :flat

  # scopes
  scope :active_subjects, where(:active => true)
  scope :inactive_subjects, where(:active => false)

  def price_cur
    {
      "доллар" => "доллар",
      "тенге" => "тенге",
      "евро" => "евро",
      "рубль" => "рубль"
    }
  end
  
  # for search:
  def self.price_cur_search
    {
      "любая валюта" => "",
      "доллар" => "доллар",
      "тенге" => "тенге",
      "евро" => "евро",
      "рубль" => "рубль"
    }
  end

  def full_address
    if @street.blank?
      if new_record?
        self.address = "Адресс неизвестен"
      end
    else
      if @house.blank? && @flat.blank?
        self.address = "ул. #{@street}"  
      elsif @flat.blank?
        self.address = "ул. #{@street}, дом #{@house}"
      else
        self.address = "ул. #{@street}, дом #{@house}, кв. #{@flat}"
      end
      fill_src_if_any
    end
  end
  
  
  def street
    unless street_src.nil?
      street_src
    end
  end
  
  def house
    unless house_src.nil?
      house_src
    end
  end
  
  def flat
    unless flat_src.nil?
      flat_src
    end
  end
  
  def fill_src_if_any
    self.street_src = @street
    self.house_src = @house
    self.flat_src = @flat
  end

  def floor?
    if typesubject.nil?
      false
    else
      typesubject.floor == true  
    end
  end
  
  def room?
    if typesubject.nil?
      false
    else
      typesubject.room == true  
    end
  end
  
  def nill_floor
    if typesubject.floor == false
      self.floor = nil
      self.floorall = nil
    end
  end

  
  def legend_value
    new_record? ? "Добавить объект" : "Редактировать объект"
  end
  
  def button_value
    new_record? ? "Добавить" : "Редактировать"
  end
  
  
  def verify_customer_real
    cust = Customer.find(customer_id)
    if cust.subjects.count > 0
      cust.update_attributes(:potentials => false)
    elsif cust.transactions.count > 0
      cust.update_attributes(:potentials => false)
    else
      cust.update_attributes(:potentials => true)
    end
  end

  # district
  def districtname=(title)
    # d = District.create(:title => title, :city_id => city_id)
    d = District.find_by_title_and_city_id(title, city_id)
    if d.nil?
      d = District.create(:title => title, :city_id => city_id)
    end
    self.district_id = d.id
  end
  
  def districtname
    unless district_id.nil?
      d = District.find(district_id)
      d.title
    end
  end
  
  # resident
  def residentname=(title)
    # d = District.create(:title => title, :city_id => city_id)
    r = Resident.find_by_title_and_city_id(title, city_id)
    if r.nil?
      r = Resident.create(:title => title, :city_id => city_id)
    end
    self.resident_id = r.id
  end
  
  def residentname
    unless resident_id.nil?
      r = Resident.find(resident_id)
      r.title
    end
  end
  
  def resident_check
    if resident_id == 0
      self.resident_id = nil
    end
  end
  
  def check_typesubject
    if self.typesubject_id_changed?
      properties = Property.where(:subject_id => self.id)
      properties.each do |p|
        p.destroy
      end
    end
  end

  def format_price
    self.price = price_before_type_cast.to_s.gsub(/\s/, '')
  end

  
end

# == Schema Information
#
# Table name: subjects
#
#  id                 :integer(4)      not null, primary key
#  typesubject_id     :integer(4)
#  city_id            :integer(4)
#  price              :integer(4)
#  area               :integer(4)
#  address            :string(255)
#  created_at         :datetime        not null
#  updated_at         :datetime        not null
#  typetransaction_id :integer(4)
#  customer_id        :integer(4)
#  district_id        :integer(4)
#  floor              :integer(4)
#  street_src         :string(255)
#  house_src          :string(255)
#  flat_src           :string(255)
#  user_id            :integer(4)
#  active             :boolean(1)      default(TRUE)
#  price_currency     :string(255)
#  room               :integer(4)
#  resident_id        :integer(4)
#  floorall           :integer(4)
#  note               :text
#

