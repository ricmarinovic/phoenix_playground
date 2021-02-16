defmodule Playground.Business.Company do
  use Ecto.Schema
  import Ecto.Changeset

  @states ~w[open closed pending]a

  schema "companies" do
    field :name, :string
    field :state, Ecto.Enum, values: @states

    timestamps()
  end

  @doc false
  def changeset(company, attrs) do
    company
    |> cast(attrs, [:name, :state])
    |> validate_required([:name, :state])
  end
end
