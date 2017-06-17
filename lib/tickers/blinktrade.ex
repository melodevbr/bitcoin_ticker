defmodule BitcoinTicker.Tickers.BlinkTrade do
  import BitcoinTicker.Tickers.Common.Validator
  @moduledoc """
      BlinkTrade Ticker Adapter
  """

  @currencies ["BRL", "VEF", "VND", "PKR", "CLP"]

  def tick(currency) do
    validate_currency(@currencies, currency)
    response = HTTPotion.get build_ticker_url(currency)

    with {:ok, result} <- JSON.decode(response.body),
         do: transform(result)
  end

  def provider, do: 'blinktrade'

  defp build_ticker_url(currency) do
    "https://api.blinktrade.com/api/v1/#{currency}/ticker?crypto_currency=BTC"
  end

  defp transform(result) do
    {:ok, %{
      "average"    => result["last"],
      "buy"        => result["buy"],
      "sell"       => result["sell"],
      "last"       => result["last"],
      "high"       => result["high"],
      "low"        => result["low"],
      "updated_at" => :os.system_time(:milli_seconds)
    }}
  end
end
