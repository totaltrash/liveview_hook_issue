defmodule MyAppWeb.HomeLive do
  use MyAppWeb, :live_view

  alias Phoenix.LiveView.JS

  def handle_params(_params, _uri, socket) do
    {:noreply, socket}
  end

  def render(assigns) do
    ~H"""
    <%= if @live_action == :index do %>
      <%= live_patch "Show", to: Routes.home_path(@socket, :show) %>
    <% end %>

    <%= if @live_action == :show do %>
      <!-- `MyHook.destroyed` fires -->
      <div id="has_hook" phx-hook="MyHook"></div>

      <!-- `MyHook.destroyed` fires -->
      <div id="has_hook_and_phx_remove" phx-remove={some_js()} phx-hook="MyHook"></div>

      <!-- `MyHook.destroyed` does not fire -->
      <div phx-remove={some_js()}>
        <div id="has_hook_and_parent_has_phx_remove" phx-hook="MyHook"></div>
      </div>

      <%= live_patch "Hide", to: Routes.home_path(@socket, :index) %>
    <% end %>
    """
  end

  defp some_js(js \\ %JS{}) do
    js
  end
end
