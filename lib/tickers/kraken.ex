defmodule BitcoinTicker.Tickers.Kraken do
  @moduledoc """
      Kraken Ticker Adapter
  """

  @ticker_url "https://api.kraken.com/0/public/Ticker?pair=XXBTZUSD"

  def tick do
    response = HTTPotion.get @ticker_url

    with {:ok, result} <- JSON.decode(response.body),
         do: transform(result["result"]["XXBTZUSD"])
  end

  def provider, do: 'kraken'

  defp transform(result) do
    {:ok, %{
      "currency"   => "USD",
      "average"    => Enum.at(result["p"], 1),
      "buy"        => Enum.at(result["b"], 0),
      "sell"       => Enum.at(result["a"], 0),
      "last"       => Enum.at(result["c"], 0),
      "high"       => Enum.at(result["h"], 1),
      "low"        => Enum.at(result["l"], 1),
      "updated_at" => :os.system_time(:seconds) * 1000
    }}
  end
end

