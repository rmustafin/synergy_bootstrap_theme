CheckoutHelper.module_eval do

  def checkout_states
    %w(address delivery payment confirm)
  end

  # TODO: this can be deleted from extension after Spree 0.70.0 release
  def checkout_progress
    states = checkout_states
    items = states.map do |state|
      css_class = "empty"
      current_index = states.index(@order.state)
      state_index = states.index(state)

      text = t("order_state.#{state}").titleize
      link = link_to "#{state_index + 1}. #{text}", checkout_state_path(state)

      if state == @order.state
        link = link_to "#{state_index + 1}. #{text}", "#"
        css_class = 'active'
      end

      content_tag('li', link, :class => css_class) if state_index <= current_index
    end
    content_tag('ul', raw(items.join("\n")), :class => 'nav nav-tabs checkout_states', :id => "checkout-step-#{@order.state}")
  end


  def address_field(form, method, id_prefix = "b", &handler)
    if handler
      handler.call
    else
      label = form.label(method, :class => "control-label")
      field = content_tag :div, :class => "controls" do
        form.text_field(method)
      end
      label + field
    end
  end

  def address_state(form, country)
    country ||= Country.find(Spree::Config[:default_country_id])
    have_states = !country.states.empty?
    state_elements = [
        form.collection_select(:state_id, country.states.order(:name),
                               :id, :name,
                               {:include_blank => true},
                               {:style => have_states ? "" : "display:none",
                                :disabled => !have_states}) +
            form.text_field(:state_name,
                            :style => !have_states ? "" : "display:none",
                            :disabled => have_states)
    ].join.gsub('"', "'").gsub("\n", "")

     content_tag :div, :class => "control-group" do
      label = form.label(:state, t(:state), :class => "control-label")
      field = content_tag :div, :class => "controls" do
        content_tag(:noscript, form.text_field(:state_name, :class => 'required')) +
            javascript_tag("document.write(\"#{state_elements.html_safe}\");")
      end
      label + field
    end


  end


end

