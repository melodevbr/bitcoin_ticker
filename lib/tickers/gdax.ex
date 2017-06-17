defmodule BitcoinTicker.Tickers.GDAX do
  @moduledoc """
      GDAX Ticker Adapter
  """

  @ticker_url "https://api.gdax.com/products/BTC-USD/ticker"

  def tick do
    response = HTTPotion.get @ticker_url, [headers: ["User-Agent": "My Ticker"]]

    with {:ok, result} <- JSON.decode(response.body),
         do: transform(result)
  end

  def provider, do: 'gdax'

  defp transform(result) do
    {:ok, dateTime, 0} = DateTime.from_iso8601(result["time"])

    {:ok, %{
      "currency"   => "USD",
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
