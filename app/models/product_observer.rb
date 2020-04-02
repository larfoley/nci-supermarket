class ProductObserver < ActiveRecord::Observer
  def after_commit(product)
    notif = Notification.create(
      content: "
        <p>
          New product #{product.name} is now available
        </p>
        <p>Check it out <a href=\"/products/#{product.id}\">here</a></p>
        "
    )
    
    notif.save
  end
end
