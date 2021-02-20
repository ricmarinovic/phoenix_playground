defmodule PlaygroundWeb.InputHelpers do
  use Phoenix.HTML

  alias PlaygroundWeb.ErrorHelpers

  @doc """
  Defines an input, a label, and other elements associated with a given `field`.

  ## Options:

    * `:using` - the type of the input, defaults to a type inferred from the
      field name using `Phoenix.HTML.Form.html.input_type/3`. `input_type/3`
      relies on the database type and, if the database type is a string,
      it uses the field name to inflect the type for email, url, search,
      and password. `:checkbox` and `:select` types are also supported.

    * `:label` - the text of the label, defaults to one inferred from the field
      name.

  All remaining options are automatically passed to the underlying input element.
  """
  def input(form, field, opts \\ []) do
    {type, opts} =
      Keyword.pop_lazy(opts, :using, fn -> Phoenix.HTML.Form.input_type(form, field) end)

    {label_text, opts} = Keyword.pop(opts, :label, humanize(field))

    validations = Phoenix.HTML.Form.input_validations(form, field)
    input_opts = Keyword.merge(opts, validations)

    content_tag :div do
      label = label(form, field, label_text)
      input = input(type, form, field, input_opts)
      error = ErrorHelpers.error_tag(form, field)
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
