defmodule BitcoinTicker.Tickers.GDAX do
  import BitcoinTicker.Tickers.Common.Validator
  @moduledoc """
      GDAX Ticker Adapter
  """

  def tick(currency) do
    validate_currency(["USD", "EUR", "GBP"], currency)
    response = HTTPotion.get build_ticker_url(currency), [headers: ["User-Agent": "My Ticker"]]

    with {:ok, result} <- JSON.decode(response.body),
         do: transform(result)
  end

  def provider, do: 'gdax'

  defp build_ticker_url(currency) do
    "https://api.gdax.com/products/BTC-#{currency}/ticker"
  end

  defp transform(result) do
    {:ok, dateTime, 0} = DateTime.from_iso8601(result["time"])

    {:ok, %{
      "average"    => result["price"],
      "buy"        => result["bid"],
      "sell"       => result["ask"],
      "last"       => result["price"],
      "high"       => result["price"],
      "low"        => result["price"],
      "updated_at" => DateTime.to_unix(dateTime) * 1000
    }}
  end
end
