defmodule BitcoinTicker.Tickers.Common.Validator do

    def validate_currency(list, currency) do
        result = Enum.member?(list, currency)
        unless result, do: raise ArgumentError, message: "#{currency} do not supported"
    end

end
