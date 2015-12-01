class Label < ActiveRecord::Base
  EasyPost.api_key = 'w0RFbWAWL3XkNyaWVCDMPw'
  #To Address
  validates :to_name, presence: true
  validates :to_street_1, presence: true
  validates :to_zip, presence: true
  validates :to_city, presence: true
  validates :to_state, presence: true
  validates :to_country, length: { is: 2 }

  #From Address
  validates :from_name, presence: true
  validates :from_street_1, presence: true
  validates :from_zip, presence: true
  validates :from_zip, presence: true
  validates :from_city, presence: true
  validates :from_state, presence: true
  validates :from_country, length: { is: 2 }

  #Parcel Info
  validates :parcel_length, presence: true, numericality: true
  validates :parcel_width, presence: true, numericality: true
  validates :parcel_height, presence: true, numericality: true
  validates :parcel_weight, presence: true, numericality: true

  before_save :generate_label

  def generate_label
    shipment = generate_shipment
    shipment.buy(rate: shipment.lowest_rate)
    self.label_url = shipment.postage_label.label_url
  end

  def generate_from_address
    address = EasyPost::Address.create_and_verify(
      name: self.from_name,
      street1: self.from_street_1,
      street2: self.from_street_2,
      city: self.from_city,
      state: self.from_state,
      zip: self.from_zip,
      country: self.from_country,
      email: self.from_email,
      phone: self.from_phone
    )
  end

  def generate_to_address
    EasyPost::Address.create_and_verify(
      name: self.to_name,
      street1: self.to_street_1,
      street2: self.to_street_2,
      city: self.to_city,
      state: self.to_state,
      zip: self.to_zip,
      country: self.to_country,
      email: self.to_email,
    )
  end

  def generate_parcel_info
    EasyPost::Parcel.create(
      width: self.parcel_width,
      length: self.parcel_length,
      height: self.parcel_height,
      weight: self.parcel_weight
    )
  end

  def generate_shipment
    from_address = generate_from_address
    to_address = generate_to_address
    parcel = generate_parcel_info
    EasyPost::Shipment.create(
      to_address: to_address,
      from_address: from_address,
      parcel: parcel
    )
  end

  def needs_from_city_state?
    self.from_city.nil? || self.from_state.nil?
  end

  def needs_to_city_state?
    self.to_city.nil? || self.to_state.nil?
  end
end
