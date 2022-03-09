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
      <div id="has_hook_and_phx_remove" phx-remove={fire_js("#js_fired_1")} phx-hook="MyHook"></div>

      <!-- `MyHook.destroyed` does not fire -->
      <div phx-remove={fire_js("#js_fired_2")}>
        <div id="has_hook_and_parent_has_phx_remove" phx-hook="MyHook"></div>
      </div>

      <%= live_patch "Hide", to: Routes.home_path(@socket, :index) %>
    <% end %>

    <h2 style="margin-top: 2em">Indicate when phx-remove is fired:</h2>
    <span id="js_fired_1">js_fired_1 fired</span><br />
    <span id="js_fired_2">js_fired_2 fired</span>
    """
  end

  defp fire_js(js \\ %JS{}, indicator) do
    js
    |> JS.transition("fire", to: indicator, time: 500)
  end
end
