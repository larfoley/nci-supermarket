class NotificationsController < ApplicationController
  def index
    @notifications = []

    # Filtering duplicate notifications due to bug with rails observers
    # after_commit being called twice.
    # More info here https://rails.lighthouseapp.com/projects/8994/tickets/764-observers-on-a-model-are-called-multiple-times
    notifs = Notification.all

    for n in notifs
      if n[:id] % 2 == 0 then
        @notifications.push(n)
      end
    end

  end
end
