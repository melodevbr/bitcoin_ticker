defmodule BitcoinTicker.Tickers.Foxbit do
  @moduledoc """
      Foxbit Ticker Adapter
  """

  @ticker_url "https://api.blinktrade.com/api/v1/BRL/ticker?crypto_currency=BTC"

  def tick do
    response = HTTPotion.get @ticker_url

    with {:ok, result} <- JSON.decode(response.body),
         do: transform(result)
  end

  def provider, do: 'foxbit'

  defp transform(result) do
    {:ok, %{
      "currency"   => "BRL",
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
