defmodule Pow.Phoenix.SessionHTML do
  @moduledoc false
  use Pow.Phoenix.Template

  if Pow.dependency_vsn_match?(:phoenix, ">= 1.7.0") do
  template :new, :html,
  """
  <div class="mx-auto max-w-sm">
    <.header class="text-center">
      Sign in
      <:subtitle>
        Don't have an account?
        <.link navigate={<%= __inline_route__(Pow.Phoenix.RegistrationController, :new) %>} class="font-semibold text-brand hover:underline">
          Register
        </.link> now.
      </:subtitle>
    </.header>

    <.simple_form :let={f} for={<%= "@changeset" %>} as={:user} action={<%= "@action" %>} phx-update="ignore">
      <.error :if={<%= "@changeset.action" %>}>Oops, something went wrong! Please check the errors below.</.error>
      <.input field={<%= "f[\#{__user_id_field__("@changeset", :key)}]" %>} type={<%= __user_id_field__("@changeset", :type) %>} label={<%= __user_id_field__("@changeset", :label) %>} required />
      <.input field={<%= "f[:password]" %>} type="password" label="Password" value={nil} required />

      <:actions>
        <.button phx-disable-with="Signing in..." class="w-full">
          Sign in <span aria-hidden="true">→</span>
        </.button>
      </:actions>
    </.simple_form>
  </div>
  """
  else
  # TODO: Remove when Phoenix 1.7 required
  template :new, :html,
  """
  <h1>Sign in</h1>
  <%= render_form([
    {:text, {:changeset, :pow_user_id_field}},
    {:password, :password}
  ],
  button_label: "Sign in") %>

  <span><%%= link "Register", to: <%= __inline_route__(Pow.Phoenix.RegistrationController, :new) %> %></span>
  """
  end
end
