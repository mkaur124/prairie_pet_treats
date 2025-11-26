class TaxCalculator
  TAX_RATES = {
    "ON" => 0.13, "BC" => 0.12, "AB" => 0.05, "QC" => 0.14975,
    "MB" => 0.12, "SK" => 0.11, "NS" => 0.15, "NB" => 0.15,
    "NL" => 0.15, "PE" => 0.15, "NT" => 0.05, "YT" => 0.05, "NU" => 0.05
  }

  def self.calculate(subtotal, province)
    rate = TAX_RATES[province] || 0
    (subtotal * rate).round(2)
  end
end
