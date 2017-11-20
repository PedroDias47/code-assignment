require "rails_helper"

RSpec.describe DriverInsurance, type: :model do
  it "calculates the number of days to charge for a driver insurance policy" do
    driver_insurance = DriverInsurance.create(start_date: Date.today, end_date: Date.today + 1.week)
    expect(driver_insurance.numds).to eq 7
  end

  it "calculates the number of days to charge for all the insurance for one driver" do
    driver = Partner.create(name: "Danny Driver")
    driver_insurance = DriverInsurance.create(start_date: Date.today, end_date: Date.today + 1.week, driver: driver)
    driver_insurance2 = DriverInsurance.create(start_date: Date.today - 3.weeks, end_date: Date.today - 1.week, driver: driver)

    expect(driver.total_days_charged_for_all_driver_insurance_policies).to eq 21
  end

  it "calculates the price for a driver insurance policy" do
    vehicle = Vehicle.create(driver_insurance_daily_rate_pounds: 58.50)
    driver_insurance = DriverInsurance.create(start_date: Date.today, end_date: Date.today + 1.week,
                                              vehicle: vehicle)
    expect(driver_insurance.driver_insurance_price).to eq 7 * 58.50
  end

  it "calculates the price for all the insurances for one driver" do
    driver = Partner.create(name: "Pedro Matos")

    vehicle = Vehicle.create(driver_insurance_daily_rate_pounds: 30.50)
    driver_insurance = DriverInsurance.create(start_date: Date.today - 1.week, end_date: Date.today - 1.day,
                                              vehicle: vehicle, driver: driver)

    vehicle2 = Vehicle.create(driver_insurance_daily_rate_pounds: 40.00)
    driver_insurance2 = DriverInsurance.create(start_date: Date.today, end_date: Date.today + 1.week,
                                              vehicle: vehicle2, driver: driver)

    expect(driver.total_charges_for_all_insurance_policies).to eq 6 * 30.50 + 7 * 40.00
  end
end
