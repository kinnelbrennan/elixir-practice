defmodule Practice.Calc do
  def parse_float(text) do
    {num, _} = Float.parse(text)
    num
  end
  def combine(list, op) when op == "+" do
    combo = parse_float(Enum.at(list, 0)) + parse_float(Enum.at(list, 2))
    list = Enum.drop(list, 3)
    list = List.insert_at(list, 0, Float.to_string(combo))
    check_op(list)
  end
  def combine(list, op) when op == "-" do
    combo = parse_float(Enum.at(list, 0)) - parse_float(Enum.at(list, 2))
    list = Enum.drop(list, 3)
    list = List.insert_at(list, 0, Float.to_string(combo))
    check_op(list)
  end
  def combine(list, op, ind) when op == "*" do
    combo = parse_float(Enum.at(list, ind - 1)) * parse_float(Enum.at(list, ind + 1))
    list = List.replace_at(list, ind, Float.to_string(combo))
    list = List.delete_at(list, ind - 1)
    list = List.delete_at(list, ind)
    check_op(list)
  end
  def combine(list, op, ind) when op == "/" do
    combo = parse_float(Enum.at(list, ind - 1)) / parse_float(Enum.at(list, ind + 1))
    list = List.replace_at(list, ind, Float.to_string(combo))
    list = List.delete_at(list, ind - 1)
    list = List.delete_at(list, ind)
    check_op(list)
  end

  #Scans the list for operations and passes them to helper
  def scan_list(list, op) when length(list) == 1 do
    list
    |>hd
    |>parse_float
  end
  def scan_list(list, op) when op == "+" or op == "-" do
    cond do
      op == "+" ->
        combine(list, "+")

      op == "-" ->
        combine(list, "-")

      true ->
        "Catch addition error"
    end
  end
  def scan_list(list, op) do
    cond do
      op == "*" ->
        combine(list, "*", Enum.find_index(list, fn x -> x == "*" end))

      op == "/" ->
        combine(list, "/", Enum.find_index(list, fn x -> x == "/" end))

      true ->
        "Catch multiplication error"
    end
  end

  def check_op(list) when length(list) == 1 do
    list
    |>hd
    |>parse_float
  end
  def check_op(list) do
    cond do
      Enum.find(list,fn x -> x == "*" or x == "/" end) == "*" ->
        scan_list(list, "*")

      Enum.find(list,fn x -> x == "*" or x == "/" end) == "/" ->
        scan_list(list, "/")

      true ->
        scan_list(list, Enum.fetch!(list, 1))
    end
  end

  def calc(expr) do
    # This should handle +,-,*,/ with order of operations,
    # but doesn't need to handle parens.
    expr
    |> String.split(~r/\s+/)
    |> check_op

    # Hint:
    # expr
    # |> split
    # |> tag_tokens  (e.g. [+, 1] => [{:op, "+"}, {:num, 1.0}]
    # |> convert to postfix
    # |> reverse to prefix
    # |> evaluate as a stack calculator using pattern matching
  end
end
