defmodule DocEvaluator do
  def ask_info do
    # Step 1 - Ask for the doc name which is meant to be evaluated
    filename = IO.gets("Submit File Name: ")
    # Step 2 - Trim out any blank spaces before and after the user input
    |> String.trim()

    # Step 3 - Read the contents of the file
    case File.read(filename) do
      # If the file is readable, accept the content
      # Step 4 - Ask the user for their choice
      {:ok, content} ->
        choice = ask_for_choice()
        # Call perform_count function passing on the choice specified
        perform_count(choice, content)

      {:error, reason} ->
        # In case there is an error in reading the file, show the error message
        IO.puts("Error reading file: #{reason}")
    end
  end

  # Function to ask the user for what to count
  def ask_for_choice do
    IO.gets("Enter 'word' for word count or 'line' for line count: ")
    |> String.trim()
  end

  # If the choice is word then count words
  # If line then count the lines
  # Else request to resubmit choice
  def perform_count(choice, content) do
    case choice do
      "word" -> count_words(content)
      "line" -> count_lines(content)
      _ ->
        IO.puts("Invalid Choice")
        ask_info()
    end
  end

  def count_words(content) do
    words = content
    |> String.split(~r{(\n|[^\w'])+})
    |> Enum.filter(&(&1 != ""))

    IO.inspect(words)
    IO.puts("Total word count: #{Enum.count(words)}")
  end

  def count_lines(content) do
    lines = content
    |> String.split("\n", trim: true)
    |> Enum.count()

    IO.puts("Total number of lines: #{lines}")
  end
end
