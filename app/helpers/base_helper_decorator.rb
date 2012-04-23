Spree::BaseHelper.module_eval do
  def link_to_cart(text = t('cart'))
    item_count =  (current_order.nil? or current_order.line_items.empty?) ? 0 : current_order.item_count
    text = "<h4>#{text} <span class=\"badge badge-info\">#{item_count}</span></h4>"

    link_to text.html_safe, cart_path
  end

  # Outputs the corresponding flash message if any are set
  def flash_messages
    bootstrap_class = {"notice" => "alert alert-success", "error" => "alert alert-error", "warning" => "alert"}
    bootstrap_class.keys.map do |msg|
      content_tag(:div, ("<a class=\"close\" data-dismiss=\"alert\">&#215;</a>".html_safe + flash.delete(msg.to_sym).html_safe), {:class => bootstrap_class[msg]}) unless flash[msg.to_sym].blank?
    end.join("\n").html_safe
  end
end
