# A Partner can be either a Driver or an Owner

class Partner < ActiveRecord::Base
  has_many :driver_insurances, foreign_key: "driver_id"
  has_many :owned_vehicles, class_name: "Vehicle", foreign_key: "owner_id"
  has_many :vehicle_owner_insurances, through: :owned_vehicles

  def total_days_charged_for_all_driver_insurance_policies
    driver_insurances.map(&:numds).sum
  end

  def total_charges_for_all_insurance_policies
    driver_insurances.map(&:driver_insurance_price).sum
  end

  def total_vehicle_owner_insurance_v2_charges_pounds
    vehicle_owner_insurances.map(&:total_charge_pounds).sum
  end
end
