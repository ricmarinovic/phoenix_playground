defmodule PlaygroundWeb.EnumHelpers do
  @moduledoc """
  Conveniences for translating and building enum selects.
  """

  use Phoenix.HTML

  @doc """
  Translates an enum value using gettext.
  """
  def translate_enum(value) when is_atom(value) do
    value =
      value
      |> Atom.to_string()
      |> humanize()

    Gettext.dgettext(PlaygroundWeb.Gettext, "enums", value)
  end

  @doc """
  Returns all translated enum values for the select options.
  """
  def translated_select_enums(module, field) do
    module
    |> Ecto.Enum.values(field)
    |> Enum.map(fn value -> {translate_enum(value), value} end)
  end

  @doc """
  Generates a select with translated enum options.
  """
  def select_enum(form, field, module) do
    select(form, field, translated_select_enums(module, field))
  end
end
