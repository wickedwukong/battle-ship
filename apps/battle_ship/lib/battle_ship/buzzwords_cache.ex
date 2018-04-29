defmodule BattleShip.BuzzwordsCache do
  use GenServer

  alias BattleShip.Buzzwords

  @interval :timer.seconds(100)

  defmodule State do
    defstruct [:buzzwords, :buzzwords_file_path]
  end

  # server code
  def init(state) do
    new_buzzwords = load_buzzwords(state.buzzwords_file_path)
    new_state = %{state | buzzwords: new_buzzwords}
    schedule_refresh()
    {:ok, new_state}
  end

  def handle_info(:refresh, state) do
    IO.puts("refreshing cache")
    new_buzzwords = load_buzzwords(state.buzzwords_file_path)
    new_state = %{state | buzzwords: new_buzzwords}
    schedule_refresh()
    {:noreply, new_state}
  end

  def handle_call(:get_buzzwords, _from, state) do
    IO.puts("getting buzzwords")
    {:reply, state.buzzwords, state}
  end

  defp load_buzzwords(buzzwords_file_path) do
    Buzzwords.read_buzzwords(buzzwords_file_path)
  end

  defp schedule_refresh do
    Process.send_after(__MODULE__, :refresh, @interval)
  end

  # client code
  def start_link(buzzwords_file_path) do
    GenServer.start_link(
      __MODULE__,
      %State{buzzwords_file_path: buzzwords_file_path},
      name: __MODULE__
    )
  end

  def get_buzzwords do
    GenServer.call(__MODULE__, :get_buzzwords)
  end
end
