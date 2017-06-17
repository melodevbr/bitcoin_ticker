defmodule BitcoinTicker.Tickers.Bitfinex do
  import BitcoinTicker.Tickers.Common.Validator
  @moduledoc """
      Bitfinex Ticker Adapter
  """

  @ticker_url "https://api.bitfinex.com/v1/pubticker/btcusd"

  def tick(currency) do
    validate_currency(["USD"], currency)
    response = HTTPotion.get @ticker_url

    with {:ok, result} <- JSON.decode(response.body),
         do: transform(result)
  end

  def provider, do: 'bitfinex'

  defp transform(result) do
    {timestamp, ""} = Float.parse(result["timestamp"])
    {:ok, %{
      "average"    => result["mid"],
      "buy"        => result["bid"],
      "sell"       => result["ask"],
      "last"       => result["last_price"],
      "high"       => result["high"],
      "low"        => result["low"],
      "updated_at" => round(timestamp * 1000)
    }}
  end
end
