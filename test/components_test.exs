defmodule OpsDesignSystem.ComponentsTest do
  use ExUnit.Case, async: true

  import Phoenix.Component
  import Phoenix.LiveViewTest

  import OpsDesignSystem.Components

  describe "ods_button/1" do
    test "renders variants, size and passes attributes through" do
      html =
        render_component(fn assigns ->
          ~H"""
          <.ods_button variant={:danger} big phx-click="clock_out" class="w-full">
            Clock Out
          </.ods_button>
          """
        end)

      assert html =~ "ods-btn"
      assert html =~ "ods-btn--danger"
      assert html =~ "ods-btn--big"
      assert html =~ ~s(phx-click="clock_out")
      assert html =~ "w-full"
      assert html =~ "Clock Out"
    end

    test "supports disabled" do
      html =
        render_component(fn assigns ->
          ~H"""
          <.ods_button disabled>Submit</.ods_button>
          """
        end)

      assert html =~ "disabled"
      refute html =~ "ods-btn--"
    end
  end

  describe "ods_input/1" do
    test "renders label, name/value and error state" do
      html =
        render_component(fn assigns ->
          ~H"""
          <.ods_input label="Badge ID" id="badge" name="badge" value="EMP001" error={true} />
          """
        end)

      assert html =~ ~s(<label for="badge" class="ods-label">Badge ID</label>)
      assert html =~ ~s(name="badge")
      assert html =~ ~s(value="EMP001")
      assert html =~ "ods-input--error"
    end

    test "omits the label element when no label is given" do
      html =
        render_component(fn assigns ->
          ~H"""
          <.ods_input id="pin" name="pin" type="password" maxlength="4" />
          """
        end)

      refute html =~ "<label"
      assert html =~ ~s(type="password")
      assert html =~ ~s(maxlength="4")
    end
  end

  describe "ods_tabs/1" do
    test "renders tabs with active/locked states and phx bindings" do
      html =
        render_component(fn assigns ->
          ~H"""
          <.ods_tabs on_select="tab">
            <:tab value="scan" active={true}>Scan</:tab>
            <:tab value="report" locked={true}>Report</:tab>
          </.ods_tabs>
          """
        end)

      assert html =~ ~s(role="tablist")
      assert html =~ "ods-tab--active"
      assert html =~ ~s(aria-selected="true")
      assert html =~ ~s(aria-selected="false")
      assert html =~ ~s(phx-value-tab="report")
      assert html =~ ~s(phx-click="tab")
      assert html =~ "ods-tab__lock"
      assert html =~ "Scan"
    end
  end
end
