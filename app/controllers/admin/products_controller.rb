class Admin::ProductsController < AdminController
  def index
    search_term = params[:search_term]
    @products = search_term ? Product.search(search_term) : Product.all
  end

  def show
    @product = Product.find(params[:id])
  end

  def edit
    @product = Product.find(params[:id])
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.create(product_params)

    if @product.save
      redirect_to admin_product_path(@product)
      flash.notice = 'Product was successfully created'
    else
      render 'new'
    end
  end

  def update
    @product = Product.find(params[:id])

    if @product.update(product_params)
      redirect_to admin_product_path
      flash.notice = "Product was successfully updated"
    else
      render 'edit'
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy

    flash.notice = "Product was successfully deleted"

    redirect_to admin_products_path
  end

  private

  def product_params
    params.require(:product).permit(:name, :description, :price, :stock, :img)
  end
end
