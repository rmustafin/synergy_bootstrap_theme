Product.class_eval do
  
  def similar_products(limit=4)
    Product.joins(:taxons).where(["products.id != ?", self.id]).where("taxons.id" => [5]).order("rand()").limit(limit)
  end

end