defmodule BitcoinTicker.Tickers.Liqui do
    import BitcoinTicker.Tickers.Common.Validator
    @moduledoc """
        Liqui Ticker Adapter
    """

    @ticker_url "https://api.liqui.io/api/3/ticker/btc_usdt"

    def tick(currency) do
      validate_currency(["USD"], currency)
      response = HTTPotion.get @ticker_url

      with {:ok, result} <- JSON.decode(response.body),
           do: transform(result["btc_usdt"])
    end

    def provider, do: "liqui"

    defp transform(result) do
      {:ok, %{
        "average"    => result["avg"],
        "buy"        => result["buy"],
        "sell"       => result["sell"],
        "last"       => result["last"],
        "high"       => result["high"],
        "low"        => result["low"],
        "updated_at" => result["updated"] * 1000
      }}
    end
end
