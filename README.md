# Ops Design System

design system for internal tools

1. **CSS** — one import, works in any stack, zero toolchain. Point the AI tool at it
   ("use the ods- classes and tokens from this stylesheet") and the prototype lands
   on-brand.
2. **HEEx components** — for Phoenix/LiveView apps (where prototypes get productionized),
   the same identity as real components: `ods_button`, `ods_input`, `ods_tabs`.
   Same install model as [daisyUI for Phoenix](https://daisyui.com/docs/install/phoenix/):
   a CSS layer plus markup-level components.

## What's inside

```
tokens.css       design identity as CSS custom properties (colors, radii, type, shadows,
                 touch ergonomics) — the source of truth
components.css   class-based kit built only on the tokens:
                 ods-app, ods-card, ods-btn (+success/danger/ghost/big), ods-badge
                 (+semantic/accent variants), ods-input, ods-label, ods-banner,
                 ods-tabs/ods-tab, ods-tile
index.css        imports both
lib/             OpsDesignSystem.Components — HEEx components for Phoenix consumers
demo/index.html  visual showcase — open it in a browser
```

## Usage

Add the dependency (git or path while unpublished; Hex once published):

```elixir
# mix.exs
{:ops_design_system, path: "../ops-design-system"}
```

Import the CSS in `assets/css/app.css` — components go into the `components` layer so
your Tailwind utilities can still override per instance (exactly how daisyUI does it):

```css
@import "tailwindcss";
@import "../../deps/ops_design_system/tokens.css";
@import "../../deps/ops_design_system/components.css" layer(components);
```

Import the components once in your web module's `html_helpers` (or per-view):

```elixir
import OpsDesignSystem.Components
```

Use them:

```heex
<.ods_button variant={:danger} big phx-click="clock_out">Clock Out</.ods_button>

<.ods_input label="Badge ID" id="badge" name="badge" value={@badge} error={@invalid?} />

<.ods_tabs>
  <:tab active={@tab == :scan} phx-click="tab" phx-value-tab="scan">Scan</:tab>
  <:tab locked={true} phx-click="tab" phx-value-tab="report">Report</:tab>
</.ods_tabs>
```

Every component takes `class` for layout/responsive tweaks and passes globals
(`phx-*`, `disabled`, `type`, ...) through. Current set: **button, input, tabs** —
small on purpose; grow it from real usage.
