enumextension 50200 "CUST ShptCommissCalcMethodExt" extends "PKT Shipm. Comm. Calc Method"
{
    value(50200; "Fixed Price")
    {
        Implementation = "PKT IShipmentCommissionCalculation" = "CUST Shipmt Comm. Calc. Custom";
    }
}