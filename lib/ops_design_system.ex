defmodule OpsDesignSystem do
  @moduledoc """
  Ops Design System — a deliberately small design system for internal apps.

  Two layers, one identity:

  - **CSS** (`tokens.css` + `components.css`) — framework-agnostic; any app
    (plain HTML, React, vibecoded anything) links one file and is on-brand.
  - **HEEx components** (`OpsDesignSystem.Components`) — for Phoenix/LiveView
    apps: `ods_button`, `ods_input`, `ods_tabs`, styled entirely by the CSS
    layer, so the visual identity has a single source of truth.

  See the README for installation in each kind of consumer.
  """
end
