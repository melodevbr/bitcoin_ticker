defmodule BitcoinTicker.Tickers.Bitstamp do
  import BitcoinTicker.Tickers.Common.Validator
  @moduledoc """
      Bitstamp Ticker Adapter
  """

  def tick(currency) do
    validate_currency(["USD", "EUR"], currency)
    response = HTTPotion.get build_ticker_url(currency)

    with {:ok, result} <- JSON.decode(response.body),
         do: transform(result)
  end

  def provider, do: 'bitstamp'

  defp build_ticker_url(currency) do
    "https://www.bitstamp.net/api/v2/ticker/btc#{String.downcase(currency)}"
  end

  defp transform(result) do
    {:ok, %{
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
