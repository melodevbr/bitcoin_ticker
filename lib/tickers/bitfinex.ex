defmodule BitcoinTicker.Tickers.Bitfinex do
  @moduledoc """
      Bitfinex Ticker Adapter
  """

  @ticker_url "https://api.bitfinex.com/v1/pubticker/btcusd"

  def tick do
    response = HTTPotion.get @ticker_url

    with {:ok, result} <- JSON.decode(response.body),
         do: transform(result)
  end

  def provider, do: 'bitfinex'

  defp transform(result) do
    {timestamp, ""} = Float.parse(result["timestamp"])
    {:ok, %{
      "currency"   => "USD",
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
