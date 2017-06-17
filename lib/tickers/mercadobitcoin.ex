defmodule BitcoinTicker.Tickers.MercadoBitcoin do
  import BitcoinTicker.Tickers.Common.Validator
  @moduledoc """
      MercadoBitcoin Ticker Adapter
  """

  @ticker_url "https://www.mercadobitcoin.com.br/api/ticker/"

  def tick(currency) do
    validate_currency(["BRL"], currency)
    response = HTTPotion.get @ticker_url

    with {:ok, result} <- JSON.decode(response.body),
         do: transform(result["ticker"])
  end

  def provider, do: 'mercado_bitcoin'

  defp transform(result) do
    {:ok, %{
      "average"    => result["last"],
      "buy"        => result["buy"],
      "sell"       => result["sell"],
      "last"       => result["last"],
      "high"       => result["high"],
      "low"        => result["low"],
      "updated_at" => result["date"] * 1000
    }}
  end
end
