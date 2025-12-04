class TaxCalculator
  TAX_RATES = {
    "Ontario" => { gst: 0.05, pst: 0.08, hst: 0.0 },
    "British Columbia" => { gst: 0.05, pst: 0.07, hst: 0.0 },
    "Alberta" => { gst: 0.05, pst: 0.0, hst: 0.0 },
    "Quebec" => { gst: 0.05, pst: 0.09975, hst: 0.0 },
    "Manitoba" => { gst: 0.05, pst: 0.07, hst: 0.0 },
    "Saskatchewan" => { gst: 0.05, pst: 0.06, hst: 0.0 },
    "Nova Scotia" => { gst: 0.0, pst: 0.0, hst: 0.15 },
    "New Brunswick" => { gst: 0.0, pst: 0.0, hst: 0.15 },
    "Newfoundland and Labrador" => { gst: 0.0, pst: 0.0, hst: 0.15 },
    "Prince Edward Island" => { gst: 0.05, pst: 0.10, hst: 0.0 },
    "Northwest Territories" => { gst: 0.05, pst: 0.0, hst: 0.0 },
    "Yukon" => { gst: 0.05, pst: 0.0, hst: 0.0 },
    "Nunavut" => { gst: 0.05, pst: 0.0, hst: 0.0 }
  }

  def self.calculate(subtotal, province_name)
    rates = TAX_RATES[province_name] || { gst: 0.0, pst: 0.0, hst: 0.0 }
    gst = (subtotal * rates[:gst]).round(2)
    pst = (subtotal * rates[:pst]).round(2)
    hst = (subtotal * rates[:hst]).round(2)
    total_tax = (gst + pst + hst).round(2)
    { gst: gst, pst: pst, hst: hst, total_tax: total_tax }
  end
end
