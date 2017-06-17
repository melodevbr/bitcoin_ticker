defmodule BitcoinTicker.Tickers.Bitstamp do
  @moduledoc """
      Bitstamp Ticker Adapter
  """

  @ticker_url "https://www.bitstamp.net/api/v2/ticker/btcusd"

  def tick do
    response = HTTPotion.get @ticker_url

    with {:ok, result} <- JSON.decode(response.body),
         do: transform(result)
  end

  def provider, do: 'bitstamp'

  defp transform(result) do
    {:ok, %{
      "currency"   => "USD",
      "average"    => result["open"],
      "buy"        => result["bid"],
      "sell"       => result["ask"],
      "last"       => result["last"],
      "high"       => result["high"],
      "low"        => result["low"],
      "updated_at" => :os.system_time(:seconds) * 1000
    }}
  end
end
