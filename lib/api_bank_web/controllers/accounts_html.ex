defmodule ApiBankWeb.AccountsHTML do
  use ApiBankWeb, :html

  embed_templates "accounts_html/*"

  @doc """
  Renders a accounts form.
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true

  def accounts_form(assigns)
end
