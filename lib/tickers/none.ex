defmodule BitcoinTicker.Tickers.None do
    @moduledoc """
        None Ticker Adapter
    """

    def tick do
      {:error, "Provider not found."}
    end
end
