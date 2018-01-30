class Amount < ApplicationRecord
  after_initialize :init

  def init
    self.default ||= 1500
  end
end
