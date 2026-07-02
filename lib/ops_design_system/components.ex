defmodule OpsDesignSystem.Components do
  @moduledoc """
  HEEx function components for Phoenix/LiveView consumers.

  All styling comes from the `ods-*` classes in `components.css` — import it
  in your `app.css` (see README). Components accept a `class` attr for
  layout/responsive tweaks and pass global attributes (including `phx-*`)
  through to the underlying element.

      import OpsDesignSystem.Components

      <.ods_button variant={:danger} big phx-click="clock_out">Clock Out</.ods_button>

      <.ods_input label="Badge ID" id="badge" name="badge" value={@badge} />

      <.ods_tabs>
        <:tab active={@tab == :scan} phx-click="tab" phx-value-tab="scan">Scan</:tab>
        <:tab locked={true} phx-click="tab" phx-value-tab="report">Report</:tab>
      </.ods_tabs>
  """

  use Phoenix.Component

  @doc """
  Button. Variants: `:primary` (default), `:success`, `:danger`, `:ghost`.
  `big` bumps it to kiosk-comfortable control height.
  """
  attr(:variant, :atom, values: [:primary, :success, :danger, :ghost], default: :primary)
  attr(:big, :boolean, default: false)
  attr(:class, :any, default: nil)
  attr(:rest, :global, include: ~w(disabled form name value type))
  slot(:inner_block, required: true)

  def ods_button(assigns) do
    ~H"""
    <button class={["ods-btn", btn_variant(@variant), @big && "ods-btn--big", @class]} {@rest}>
      {render_slot(@inner_block)}
    </button>
    """
  end

  defp btn_variant(:primary), do: nil
  defp btn_variant(:success), do: "ods-btn--success"
  defp btn_variant(:danger), do: "ods-btn--danger"
  defp btn_variant(:ghost), do: "ods-btn--ghost"

  @doc """
  Text input with optional label and error state.
  """
  attr(:id, :string, default: nil)
  attr(:name, :string, default: nil)
  attr(:value, :any, default: nil)
  attr(:label, :string, default: nil)
  attr(:error, :boolean, default: false)
  attr(:class, :any, default: nil)

  attr(:rest, :global,
    include:
      ~w(type placeholder autocomplete autofocus inputmode maxlength minlength pattern readonly required)
  )

  def ods_input(assigns) do
    ~H"""
    <div>
      <label :if={@label} for={@id} class="ods-label">{@label}</label>
      <input
        id={@id}
        name={@name}
        value={@value}
        class={["ods-input", @error && "ods-input--error", @class]}
        {@rest}
      />
    </div>
    """
  end

  @doc """
  Tab bar. Clicking a tab pushes the `on_select` event with the tab's `value`
  as `phx-value-tab`.
  """
  attr(:on_select, :string, required: true, doc: "event pushed when a tab is clicked")
  attr(:class, :any, default: nil)

  slot :tab, required: true do
    attr(:value, :string, required: true, doc: "sent as phx-value-tab")
    attr(:active, :boolean)
    attr(:locked, :boolean, doc: "renders a lock hint")
    attr(:class, :any)
  end

  def ods_tabs(assigns) do
    ~H"""
    <nav role="tablist" class={["ods-tabs", @class]}>
      <button
        :for={tab <- @tab}
        role="tab"
        aria-selected={to_string(tab[:active] == true)}
        phx-click={@on_select}
        phx-value-tab={tab.value}
        class={["ods-tab", tab[:active] && "ods-tab--active", tab[:class]]}
      >
        {render_slot(tab)}
        <span :if={tab[:locked]} class="ods-tab__lock">🔒</span>
      </button>
    </nav>
    """
  end
end
