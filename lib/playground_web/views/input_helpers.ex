defmodule PlaygroundWeb.InputHelpers do
  use Phoenix.HTML

  def input(form, field, opts \\ []) do
    {type, opts} =
      Keyword.pop_lazy(opts, :using, fn -> Phoenix.HTML.Form.input_type(form, field) end)

    validations = Phoenix.HTML.Form.input_validations(form, field)
    input_opts = Keyword.merge(opts, validations)

    content_tag :div do
      label = label(form, field, humanize(field))
      input = input(type, form, field, input_opts)
      error = PlaygroundWeb.ErrorHelpers.error_tag(form, field)
      [label, input, error]
    end
  end

  defp input(:select_enum, form, field, input_opts) do
    PlaygroundWeb.EnumHelpers.select_enum(form, field, input_opts[:module])
  end

  defp input(type, form, field, input_opts) do
    apply(Phoenix.HTML.Form, type, [form, field, input_opts])
  end
end
