defmodule Bamboo.MailjetHelper do
  @moduledoc """
  Functions for using features specific to Mailjet
  """

  alias Bamboo.Email

  @doc """
  Set the template ID to use for the email contents.

  This overrides any message body provided.

  ## Example

      email
      |> template("4242")
  """
  def template(email, template_id) do
    Email.put_private(email, :mj_templateid, template_id)
  end

  @doc """
  Set whether to activate the interpretation of the template language.

  Defaults to false.

  ## Example

      email
      |> template_language(true)
  """
  def template_language(email, active) do
    Email.put_private(email, :mj_templatelanguage, active)
  end

  @doc """
  Add a variable to the email.

  This can be used for email personalization when using variables in the template.

  ## Example

      email
      |> put_var("name", "Arthur")
      |> put_var("reset_token", "8938463f-8910-461b-8b4b-e9d0368e979c")
  """
  def put_var(email, key, value) do
    vars = Map.get(email.private, :mj_vars, %{})
    Email.put_private(email, :mj_vars, Map.put(vars, key, value))
  end

  @doc """
  Add template error reporting to the email.

  This can be used to set an email address that will receive templating language errors.

  ## Example

      email
      |> template_error_reporting("Arthur Dent", "arthur_dent@example.com")
  """
  def template_error_reporting(email, name, address) do
    Email.put_private(email, :templateerrorreporting, %{name: name, email: address})
  end
end
