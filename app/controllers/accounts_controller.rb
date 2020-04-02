class AccountsController < ApplicationController
  def show
    @orders = current_user.orders
  end

  def update
    account = current_user.account

    if account.update(account_params)
      redirect_to account_path
      flash.notice = "Account was successfully updated"
    else
      render edit_user_registration_path
    end
  end

  private

  def account_params
    params.require(:account).permit(:delivery_address)
  end
end
