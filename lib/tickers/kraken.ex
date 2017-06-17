defmodule BitcoinTicker.Tickers.Kraken do
  import BitcoinTicker.Tickers.Common.Validator
  @moduledoc """
      Kraken Ticker Adapter
  """

  def tick(currency) do
    validate_currency(["USD", "EUR", "GBP", "CAD", "JPY"], currency)
    response = HTTPotion.get build_ticker_url(currency)

    with {:ok, result} <- JSON.decode(response.body),
         do: transform(result["result"]["XXBTZ#{currency}"])
  end

  def provider, do: 'kraken'

  defp build_ticker_url(currency) do
    "https://api.kraken.com/0/public/Ticker?pair=XXBTZ#{currency}"
  end

  defp transform(result) do
    {:ok, %{
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

